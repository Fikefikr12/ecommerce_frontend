import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_frontend/core/service/user_service.dart';
import 'package:ecommerce_frontend/features/forgetpassword/view/reset_password_page.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/widgets/bottom_navigation_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_frontend/data/model/user.dart' as model;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final username = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // sign up on firebase and store on firestore the user
  // Future<void> signUp(BuildContext context) async {
  //   try {
  //     // 1, validate form
  //     if (!signupFormKey.currentState!.validate()) {
  //       print("Form not valid");
  //       return;
  //     }

  //     print("Creating user...");

  //     // 2,  Create user in Firebase Auth
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(
  //           email: email.text.trim(),
  //           password: password.text.trim(),
  //         );
  //     final user = userCredential.user;
  //     print("User created");

  //     //  3.save user data in firestore
  //     await _db.collection("users").doc(user!.email).set({
  //       "name": name.text.trim(),
  //       "username": username.text.trim(),
  //       "email": email.text.trim(),
  //       "phone": phoneNumber.text.trim(),
  //       "uid": user.uid,
  //       "creatdAt": DateTime.now(),
  //     });

  //     // 4 send email  verification
  //     await user.sendEmailVerification();
  //     print("Email sent");
  //     //  5 success message
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("Account created Successfully")));
  //     print("Navigating...");

  //     // 6 navigate to verify email page
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => BottomNavigationMenu()),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     String message = "Someting went wrong";

  //     if (e.code == 'email-already-in-use') {
  //       message = "Email already exists";
  //     } else if (e.code == 'weak-password') {
  //       message = "Password is too weak";
  //     } else if (e.code == 'invalid-email') {
  //       message = "Invalid email";
  //     }
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(message)));
  //   } catch (e) {
  //     print("ERROR: $e");
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }

  Future<void> signUp(BuildContext context) async {
    try {
      if (!signupFormKey.currentState!.validate()) {
        print("Form not valid");
        return;
      }

      print("Creating user...");

      // 1. CREATE USER IN FIREBASE AUTH
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.text.trim(),
            password: password.text.trim(),
          );

      final user = userCredential.user;

      if (user == null) {
        throw Exception("Firebase user is null");
      }

      print("Firebase user created: ${user.uid}");

      // 2. SEND DATA TO BACKEND (MongoDB)
      final newUser = model.User(
        firebaseUId: user.uid,
        name: name.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phone: phoneNumber.text.trim(),
        profileImage: [],
      );

      final createdUser = await UserService().createUser(newUser, []);

      print("MongoDB user created: ${createdUser.id}");

      // 3. SEND EMAIL VERIFICATION
      await user.sendEmailVerification();

      print("Email verification sent");

      // 4. SUCCESS MESSAGE
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );
      // load current user from backend
      context.read<ShopeBloc>().add(GetCurrentUserEvent());
      // 5. NAVIGATE
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNavigationMenu()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Something went wrong";

      if (e.code == 'email-already-in-use') {
        message = "Email already exists";
      } else if (e.code == 'weak-password') {
        message = "Password is too weak";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      print("ERROR: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> signIn(BuildContext context) async {
    try {
      // STEP 1: Login user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final user = userCredential.user;

      // STEP 2: Check user exist
      if (user == null) {
        print("user is null");
        return;
      }

      // load current user from backend
      context.read<ShopeBloc>().add(GetCurrentUserEvent());

      // get firebase token
      final token = await user.getIdToken();
      print("TOKEN:");
      print(token);

      print("UID:");
      print(user.uid);
      //3 check email verrification
      // if (!user.emailVerified) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text("please verify your email first")),
      //   );
      //   return;
      // }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationMenu()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Something went wrong";

      if (e.code == 'user-not-found') {
        message = "No user found with this email";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      print("ERROR: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<bool> checkEmailVerified() async {
    await _auth.currentUser?.reload(); // refresh user data
    final user = _auth.currentUser;
    return user?.emailVerified ?? false;
  }

  Future<void> resendVerificationEmail(BuildContext context) async {
    try {
      final user = _auth.currentUser;

      if (user == null) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Verification email sent again")));
      await user.sendEmailVerification();
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<void> handleEmailVerification(BuildContext context) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("User not found")));
        return;
      }

      // 🔥 VERY IMPORTANT: reload from Firebase
      await user.reload();

      // 🔥 get updated user
      final updatedUser = _auth.currentUser;

      if (updatedUser!.emailVerified) {
        // ✅ Verified → go to home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => BottomNavigationMenu()),
        );
      } else {
        // ❌ Not verified
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email not verified yet. Please check your inbox."),
          ),
        );
      }
    } catch (e) {
      print("ERROR: $e");
    }
  }

  Future<void> forgetpassword(BuildContext context, String emailInput) async {
    try {
      // step 1,validate email
      if (emailInput.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter your email")),
        );
        return;
      }

      // STEP 2: Send reset email via Firebase
      await _auth.sendPasswordResetEmail(email: emailInput.trim());

      // STEP 3: Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset email sent")),
      );

      // STEP 4: Navigate to Reset Password Page (success screen)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ResetPasswordPage()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Something went wrong";

      if (e.code == 'user-not-found') {
        message = "No user found with this email";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email address";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {}
  }
  // Google sign in

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // STEP 1: Initialize GoogleSignIn with clientId (optional for Android)
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      if (kIsWeb) {
        await googleSignIn.initialize(
          // ✅ REQUIRED for Web
          clientId:
              "315260986346-paakcts6sdaq0rdbqcpq8ll5igbcj39u.apps.googleusercontent.com",
        );
      } else {
        // 📱 ANDROID CONFIG
        await googleSignIn.initialize(
          serverClientId:
              "315260986346-paakcts6sdaq0rdbqcpq8ll5igbcj39u.apps.googleusercontent.com",
        );
      }

      //  step 2 start sign in flow
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      // step 3 ,get auth token
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // step 4 , create Firebase credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // STEP 5: Sign in with Firebase
      final userCredential = await _auth.signInWithCredential(credential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Firebase Error: ${e.code}");
      return null;
    } catch (e) {
      print("ERROR: $e");
      return null;
    }
  }

  // sign out from both firebase and google
  googleSignOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;
    // from firebase signout
    await _auth.signOut();

    // sign out from google
    await googleSignIn.signOut();
  }
}
// Yalefut 5 ametat yaderekut zare yalehubetn mannet setogal 
//,ahun maderge neger yewedefit 5 ametien ywesnal ena wendm neka denget bel sra 
//ydekmalko awo ydekmal gn amarach yelhm hiwet tgl nat mashenf
// bacha new lela mnm amarach yelatm,lidebrh yichlal gn dkem,tagel,tar, 
//ashenf jegna neh ,you can ,think tommoro,is bright 
// kes ble sra wutietum yamare yhonal

// yewah 
// 1 kifun bekifu yemaymels
// 2 kifu lemihonubachu tselyu
// 3 benie new tfat new yhie yhonew