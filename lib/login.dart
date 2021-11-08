import 'package:flutter/material.dart';
import 'design.dart';
import 'package:donate_admin/firebase/firebase_login.dart';
import 'package:donate_admin/homepage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String adminURL = 'images/admin.png';
  String logoURL = 'images/donate_logo.png';

  final _loginKey = GlobalKey<FormState>();
  String email = "", pass = "";
  bool load = false, logged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Spacer(),
          Container(
              padding: const EdgeInsets.all(30),
              child: Column(children: [
                Expanded(
                  child: Center(
                      child: Image(
                    image: AssetImage(adminURL),
                  )),
                ),
                const Text(
                  'Admin Login',
                  style: TextStyle(fontSize: 50),
                )
              ])),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(30),
            width: 500,
            color: Design.backgroundColor,
            child: Column(
              children: [
                Image(
                  image: AssetImage(logoURL),
                  width: 150,
                  height: 150,
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 350,
                  height: 400,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 3,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _loginKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Enter Credentials',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 50,
                            ),
                            TextFormField(
                              decoration: DesignTextBox(
                                  'Email', 'Enter your Email', Icons.email),
                              validator: (String? email) {
                                email = email?.trim();
                                if (email == "") {
                                  return "Email should not be empty";
                                }
                                return null;
                              },
                              onSaved: (String? e) {
                                email = e.toString();
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: DesignTextBox('Password',
                                  'Enter your password', Icons.password),
                              validator: (String? pass) {
                                pass = pass?.trim();
                                if (pass == "") {
                                  return "Password should not empty";
                                }
                                return null;
                              },
                              onSaved: (String? p) {
                                pass = p.toString();
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            (load)
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      _loginKey.currentState?.save();
                                      if (_loginKey.currentState!.validate()) {
                                        setState(() {
                                          load = true;
                                        });

                                        var credential =
                                            FirebaseLogin(email, pass);
                                        await credential.login();

                                        if (credential.isAdminExist) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Homepage()));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Admin is not exst')));
                                        }

                                        setState(() {
                                          load = false;
                                        });
                                      }

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const Homepage()));
                                    },
                                    child: const Text('Log In'))
                          ],
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
