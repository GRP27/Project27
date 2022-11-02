import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider extends ChangeNotifier{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  //hasError, errorCode, provider, uid, email, name
  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _provider;
  String? get provider => _provider;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  String? _name;
  String? get name => _name;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  SignInProvider(){
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null){
      //executing the authentication
      try{
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        //sign in to firebase instance
        final User userDetails = (await firebaseAuth.signInWithCredential(credential)).user!;

        //Save all values
        _name = userDetails.displayName;
        _email = userDetails.email;
        _imageUrl = userDetails.photoURL;
        _provider = "GOOGLE";
        _uid = userDetails.uid;
        notifyListeners();

      } on FirebaseAuthException catch(e){
        switch(e.code){
          case "account-exists-with-different-credential":
          _errorCode = "You are already registered. Use correct Provider!";
          _hasError = true;
          notifyListeners();
          break;

          case "null":
            _errorCode = "An Unexpected error has occurred. Please Try Again";
            _hasError = true;
            notifyListeners();
            break;

          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
    _hasError = true;
    notifyListeners();
    }
  }

  //ENTRY FOR CLOUDFIRESTORE
  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid).get().then(
            (DocumentSnapshot snapshot)
        => {
              _uid = snapshot['uid'],
              _name = snapshot['name'],
              _email = snapshot['email'],
              _imageUrl = snapshot['image_url'],
              _provider = snapshot['provider'],
        });
  }

  Future saveDataToFirestore() async {
    final DocumentReference r = FirebaseFirestore.instance.collection("users").doc(uid);
    await r.set({
      "name": _name,
      "email": _email,
      "uid": _uid,
      "image_url": _imageUrl,
      "provider": _provider,
    });
}

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('name', _name!);
    await s.setString('email', _email!);
    await s.setString('uid', _uid!);
    await s.setString('image_url', _imageUrl!);
    await s.setString('provider', _provider!);
  }

  Future getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString('name');
    _email = s.getString('email');
    _uid = s.getString('uid');
    _imageUrl = s.getString('image_url');
    _provider = s.getString('provider');
    notifyListeners();
  }

  //check if user exists in Cloud Firestore
  Future<bool> checkUserExists() async {
  DocumentSnapshot snap =
  await FirebaseFirestore.instance.collection('users').doc(_uid).get();
  if(snap.exists){
    print("USER ALREADY EXISTS");
    return true;
  } else {
    print("NEW USER");
    return false;
  }
  }

  //user Sign Out
  Future userSignOut() async {
  await firebaseAuth.signOut();
  await googleSignIn.signOut();
  _isSignedIn = false;
  notifyListeners();
  clearStoredData();
  }


  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }

  void phoneNumberUser(User user, email, name){
    _name = name;
    _email = email;
    _imageUrl = null;
    _uid = user.phoneNumber;
    _provider = "PHONE";
    notifyListeners();
  }
}