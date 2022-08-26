import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
///the path in app
import 'package:firebasetest/app-body/screens/HomeScreen.dart';
import 'package:firebasetest/utils/Consts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/DevicesProvider.dart';

int wrongSigninNo = 0;

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {

    super.initState();
  }
  ///to see or hide password
  bool seepassword = true;

  ///user email and password
  var mypassword, myemail;

  ///variable to get the form validat
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  ///firebase validat to sign in
  signIn() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        //showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);

        if (UserCredential != null) {
          await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
          //abanoub Edit
            Navigator.of(context).pop();
        }
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password' || e.code == 'user-not-found') {
          wrongSigninNo++;
          AwesomeDialog(
              btnOk: MaterialButton(
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              context: context,
              title: "Alarm",
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "user not found, try agian you have${3 - wrongSigninNo}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17),
                ),
              )).show();
        }
      }
    } else {
      print("Not Vaild");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),

            /// person avater

            CircleAvatar(
              radius: MediaQuery.of(context).size.width * .03,
              child: Icon(
                Icons.person,
                size: MediaQuery.of(context).size.width * .05,
              ),
            ),

            /// to take space
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),

            /// smart lab text
            Text(
              "SMART LAB",
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * .05),
            ),

            ///take space
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),

            ///TExt fields
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black87.withOpacity(.1)),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .03,
                    vertical: 20),
                child: Form(
                    key: formstate,
                    child: Column(
                      children: [
                        /// mail
                        TextFormField(
                          onSaved: (val) {
                            myemail = val;
                          },
                          validator: (val)
                          {
                            if (val!.length > 100) {
                              return "Email can't to be larger than 100 letter";
                            }
                            if (val.length < 8) {
                              return "Not valid account and should contain Email@Example.com";
                            }
                            if (val.contains('@fayoum') == false) {
                              return "it must to be an  '@fayoum' account";
                            }
                            return null;
                          },
                          onChanged: (s) => formstate.currentState!.validate(),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.account_circle_outlined),
                            labelText: "Email",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),

                        ///take space
                        const SizedBox(height: 20),

                        /// password
                        TextFormField(
                          onChanged: (s) => formstate.currentState!.validate(),
                          onSaved: (val) {
                            mypassword = val;
                          },
                          validator: (val) {
                            if (val!.length > 100) {
                              return "Password can't to be larger than 100 letter";
                            }
                            if (val.length < 4) {
                              return "Password can't to be less than 4 letter";
                            }
                            return null;
                          },
                          obscureText: seepassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.remove_red_eye_outlined),
                              onPressed: () {
                                setState(() {
                                  if (seepassword == true) {
                                    seepassword = false;
                                  } else {
                                    seepassword = true;
                                  }
                                });
                              },
                            ),
                            labelText: "password",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(),

                              //fillColor: Colors.green
                            ),
                          ),
                        ),

                        ///take space
                        const SizedBox(height: 20),

                        /// sign in button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () async {
                              if (sign_in_validation(context)) {
                                await signIn();
                              }
                              if (wrongSigninNo > 2) {
                                context
                                    .read<DevicesProvider>()
                                    .SetChanges(Consts.BUZZER, true);
                                AwesomeDialog(
                                    btnOk: MaterialButton(
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.blue,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    context: context,
                                    title: "warning",
                                    body: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        "call the info Sec Team please : ah2262@fayoum.edu.eg",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    )).show();
                              }

                              /// if for make user login just 3 times
                            },
                            child: const Text("Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontFamily: "Timesnewroman")),
                          ),
                        ),

                        ///take space
                        const SizedBox(
                          height: 50,
                        ),

                        /// thanks and help

                        const Text("thanks to use our Labs"),

                        ///
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("If you are facing any problem "),
                            InkWell(
                                onTap: () {
                                  AwesomeDialog(
                                      btnOk: MaterialButton(
                                        child: const Text(
                                          "OK",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.blue,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      context: context,
                                      title: "warning",
                                      body: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "you must check you E-mail and Password carefully before logging And if you still facing any problem Call the admin",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      )).show();
                                },
                                child: const Text(
                                  "ClickHere",
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// the functions of sign in button
  bool sign_in_validation(BuildContext context) {
    // alarm_variable_firebase.child("Bazzer").child('state').set('0').asStream();
    if (formstate.currentState!.validate()) {
      AwesomeDialog(
          context: context,
          title: "Welcome",
          body: const Text("Hi at SMART LAB to make Life Easier"))
          .show();
      return true;

    } else {
      return false;
    }

  }

// var user = await signIn();
// if (user != null) {
//   await Navigator.of(context)
//       .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
// }

}
