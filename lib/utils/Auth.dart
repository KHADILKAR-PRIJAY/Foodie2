import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String name;
  String email;
  String imageUrl;

  Future<User> signInWithGoogle() async {
    try {
      print(User);
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      print(googleSignInAccount);

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user;
      // final User user = await _auth.signInWithGoogle(
      //   accessToken: googleSignInAuthentication.accessToken,
      //   idToken: googleSignInAuthentication.idToken,
      // );
      //
      // final FirebaseUser user = authResult.user;
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoURL;
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }
      final User currentUser = await _auth.currentUser;
      currentUser.getIdToken();
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      assert(user.uid == currentUser.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }
}
