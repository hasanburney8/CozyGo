import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices{
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();


  signInWithGoogle() async{
    try {
      //If the user selects a Google account, googleSignInAccount will contain that account info.
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      //Only proceeds if the user didn’t cancel.
      if(googleSignInAccount != null){

        //Gets the accessToken and idToken from the selected Google account.
        final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

        //Converts the Google tokens into a Firebase credential that Firebase can understand.
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );

        //Signs in the user to Firebase using the credential from Google.Firebase now considers the user as authenticated.
        await auth.signInWithCredential(authCredential);
      }

      //If something goes wrong during the sign-in (like invalid tokens or network issues), it catches the Firebase-specific error and prints it.
    }on FirebaseAuthException catch (e){
      print(e.toString());
    }
  }
}
