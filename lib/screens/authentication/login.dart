import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reslate/screens/bottomBar.dart';
import 'package:reslate/screens/authentication/registerPage.dart';

import '../../models/profile.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: FutureBuilder(
          future: firebase,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(title: Text("Error!")),
                body: Center(
                  child: Text("${snapshot.error}"),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Scaffold(
                    body: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.topCenter, colors: [
                      Colors.blue[600]!,
                      Colors.blue[300]!,
                      Colors.blue[100]!,
                    ]),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 90),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Aligns children to the start (left) of the column
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        10), // Adjusted EdgeInsets for left alignment
                                child: Text(
                                  'Reslate',
                                  style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(
                                        fontSize: 50, color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        10), // Adjusted EdgeInsets for left alignment
                                child: Text(
                                  'Login\nyour account',
                                  style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue[900]!,
                                    blurRadius: 30,
                                    offset: Offset(0, 10))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(60))),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 40, 30, 20),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.blue[400]!,
                                              blurRadius: 30,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: Column(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]!))),
                                        child: TextFormField(
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText:
                                                      'Please enter email.'),
                                              EmailValidator(
                                                  errorText:
                                                      'Email format is incorrect.')
                                            ]),
                                            onSaved: (var email) {
                                              profile.email = email;
                                            },
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              labelText: 'Email',
                                            )),
                                      ),
                                      Container(
                                        child: TextFormField(
                                            validator: ((password1) {
                                              if (password1!.isEmpty) {
                                                return 'Please enter password.';
                                              } else if (password1.length < 8) {
                                                return 'Password must be longer than 8 characters.';
                                              }
                                            }),
                                            onSaved: (password1) {
                                              profile.password = password1;
                                            },
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              labelText: 'Password',
                                            )),
                                      ),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: 300,
                                      child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue[400],
                                              fixedSize: const Size(300, 50),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50))),
                                          onPressed: () {
                                            handleLogin();
                                          },
                                          icon: Icon(
                                            Icons.login,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            "Login",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text("OR"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );
                                        try {
                                          GooglesignInProvider()
                                              .googleLogin()
                                              .then((value) {
                                            try {
                                              // un comment for web
                                              var user = FirebaseAuth
                                                  .instance.currentUser!;
                                            } catch (e) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please login using another method.",
                                                  gravity: ToastGravity.TOP);
                                            }

                                            Get.to(bottombar(),
                                                transition:
                                                    Transition.topLevel);
                                          });
                                        } catch (e) {
                                          Fluttertoast.showToast(
                                              msg: "Google login failed.",
                                              gravity: ToastGravity.TOP);
                                        }
                                      },
                                      child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Logo(Logos.google)),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(15),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(registerPage(),
                                            transition: Transition.fadeIn);
                                      },
                                      child: Text(
                                        "Don't have an account? Register now!",
                                        style: btTextStyle.nameOfTextStyle,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                )),
              );
            }
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        onWillPop: () async => false);
  }

  Future<void> googleRegister(String username, String email) async {
    CollectionReference googleAccount =
        FirebaseFirestore.instance.collection("Profile");
    String password = 'SocialLogin';
    await googleAccount.add({
      "Username": username,
      "Email": email,
      "password": password,
      "wordLength": 0,
      "topScore": 0,
      "cardTopScore": 0,
      "aids": 0,
      "archiveLevel": 0,
    });
  }

  Future<void> handleLogin() async {
    //ตรวจสอบความถูกต้องของ Input
    if (formKey.currentState!.validate()) {
      //บันทึกข้อมูลผู้ใช้
      formKey.currentState?.save();
      try {
        //เข้าสู่ระบบด้วย Firebase authentication
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: profile.email, password: profile.password)
            .then((value) {
          //แสดงข้อความเข้าสุ่ระบบสำเร็ตจและรีเซ็ตฟอร์ม
          formKey.currentState?.reset();
          Fluttertoast.showToast(
              msg: "Login successful.", gravity: ToastGravity.TOP);
          Get.to(bottombar(), transition: Transition.topLevel);
        });
        //แสดง error กรณีที่ไม่สามารถเข้าสู่ระบบได้
      } on FirebaseAuthException catch (e) {
        var message;
        if (e.code == "user-not-found") {
          message = "User not found.";
        } else if (e.code == "wrong-password") {
          message = "Password incorrect.";
        } else {
          message = e.code;
        }
        Fluttertoast.showToast(msg: message, gravity: ToastGravity.TOP);
      }
      formKey.currentState?.reset();
    }
  }
}

class btTextStyle {
  static const TextStyle nameOfTextStyle =
      TextStyle(fontSize: 12, color: Colors.black);
}

class Googlebt {
  static const TextStyle style = TextStyle(fontSize: 25);
}

class GooglesignInProvider extends ChangeNotifier {
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  _loginPageState login = _loginPageState();

  Future<void> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled the Google Sign-In
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await login.googleRegister(
              googleUser.displayName!, googleUser.email!);
        } else {
          print('This Google account is already used.');
        }
      } else {
        print('Failed to sign in with Google.');
      }
    } catch (e) {
      print('Error during Google sign-in: $e');
    }
  }
}
