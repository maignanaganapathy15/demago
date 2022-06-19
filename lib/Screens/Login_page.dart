import 'package:demago/Screens/Home_page.dart';
import 'package:demago/Screens/Registration_page.dart';
import 'package:demago/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  @override
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

//fire base

  final _auth = FirebaseAuth.instance;

//firebase end

  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return ("Please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        prefixIconColor: Colors.red,
        hintText: 'Email id',
        contentPadding: EdgeInsets.fromLTRB(30, 15, 30, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),

        //own code
        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        /* fillColor: color2,
        hoverColor: Colors.yellow,
        focusColor: Colors.blue,
        //   iconColor: color1,*/
      ),
    );

    final passwordField = TextFormField(
      obscureText: true,
      autofocus: false,
      controller: passwordController,
      //  keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter valid password(min 6 character)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        //  prefixIconColor: Colors.red,
        hintText: 'Password',
        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(30, 15, 30, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),

        //own code
        //  labelStyle: TextStyle(fontSize: 14)
        /*
        fillColor: color2,
        hoverColor: Colors.yellow,
        focusColor: Colors.blue,
        //   iconColor: color1,*/
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          child: Text(
            "LOGIN",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          }),
    );

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/shop1.webp", fit: BoxFit.cover),
          Container(
            color: bgColor.withOpacity(0.3),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                  // color: bgColor,
                  child: Padding(
                padding: const EdgeInsets.all(36),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/LOGO.png",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        emailField,
                        SizedBox(
                          height: 30,
                        ),
                        passwordField,
                        SizedBox(
                          height: 50,
                        ),
                        loginButton,
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don/''t have an account?"),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Registration_page(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                            )
                          ],
                        )
                      ]),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  //login function

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: 'Login successful'),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        Home_page(uid.user!.email.toString()))),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
