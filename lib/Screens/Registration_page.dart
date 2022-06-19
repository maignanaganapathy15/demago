import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demago/Screens/Home_page.dart';
import 'package:demago/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demago/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:dob_input_field/dob_input_field.dart';

class Registration_page extends StatefulWidget {
  const Registration_page({Key? key}) : super(key: key);

  @override
  State<Registration_page> createState() => _Registration_pageState();
}

class _Registration_pageState extends State<Registration_page> {
  final _formKey = GlobalKey<FormState>();

  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final birthdateEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
//First Name
    final firstNameField = TextFormField(
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter valid name(min 3 character)");
        }
        return null;
      },
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        // prefixIconColor: Colors.red,
        hintText: 'First Name',
        contentPadding: EdgeInsets.fromLTRB(30, 15, 30, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
//Second Name
    final secondNameField = TextFormField(
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Last Name cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter valid name(min 3 character)");
          }
          return null;
        },
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        onSaved: (value) {
          secondNameEditingController.text = value!;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          //prefixIconColor: Colors.red,
          hintText: 'Second Name',
          contentPadding: EdgeInsets.fromLTRB(30, 15, 30, 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));

//Birth date
    final birthdateField = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter Date of birth(dd/mm/yyyy";
        }
        return null;
      },
      autofocus: false,
      controller: birthdateEditingController,
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        birthdateEditingController.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.cake),
        //prefixIconColor: Colors.red,
        hintText: 'Date of Birth (dd/mm/yyy)',
        contentPadding: EdgeInsets.fromLTRB(30, 15, 30, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
//email
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
        emailEditingController.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        prefixIconColor: Colors.red,
        hintText: 'Email id',
        contentPadding: EdgeInsets.fromLTRB(30, 15, 30, 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        //own code
        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
//password
    final passwordField = TextFormField(
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter valid password(min 6 character)");
        }
      },
      obscureText: true,
      autofocus: false,
      controller: passwordEditingController,
      //  keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      //validator:
      onSaved: (value) {
        passwordEditingController.text = value!;
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
//confirm password
    final confirmpasswordField = TextFormField(
      validator: (value) {
        if (confirmPasswordEditingController.text.length > 6 &&
            passwordEditingController.text !=
                confirmPasswordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      obscureText: true,
      autofocus: false,
      controller: confirmPasswordEditingController,
      //  keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      //validator:
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        //  prefixIconColor: Colors.red,
        hintText: 'Confirm Password',
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

//sign up button

    final signUpButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.redAccent,
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          child: Text(
            "SIGN UP",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: (() {
            signUp(emailEditingController.text, passwordEditingController.text);
          }),
        ));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'User Registration',
            // textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: bgColor,
        body: Stack(fit: StackFit.expand, children: [
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
                        SizedBox(
                          height: 20,
                        ),
                        firstNameField,
                        SizedBox(
                          height: 20,
                        ),
                        secondNameField,
                        SizedBox(
                          height: 20,
                        ),
                        birthdateField,
                        SizedBox(
                          height: 20,
                        ),
                        emailField,
                        SizedBox(
                          height: 20,
                        ),
                        passwordField,
                        SizedBox(
                          height: 20,
                        ),
                        confirmpasswordField,
                        SizedBox(
                          height: 30,
                        ),
                        signUpButton,
                        SizedBox(
                          height: 15,
                        ),
                      ]),
                ),
              )),
            ),
          ),
        ]));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        postDetailsToFireStore();

        //   Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => Home_page(value.user.email)),
        //       (route) => false);
        // }).catchError((e) {
        //   Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFireStore() async {
    //calling firestore
    //calling user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.lastName = secondNameEditingController.text;
    userModel.dob = birthdateEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                Home_page(userModel.email.toString())));
  }
}
