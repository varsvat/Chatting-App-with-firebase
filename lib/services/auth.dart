import 'package:chat/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _useridfromfirebaseuser(FirebaseUser user){
    return user!=null ? User(user.uid) :null;
  }

  Future signInWithEmailandPassword(String email , String password) async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _useridfromfirebaseuser(user);
    } catch (e) {
      print(e);
    }
  }

  Future signUpWithEmailandPassword(String email , String password)async{
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;
      return _useridfromfirebaseuser(user);
    } catch (e) {
      print(e);
    }
  }

  Future resetpassword(String email) async{
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
