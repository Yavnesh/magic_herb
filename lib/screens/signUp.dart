import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:magic_herb/auth/auth_services.dart';
import 'package:magic_herb/screens/homeScreen.dart';
import 'package:magic_herb/screens/signIn.dart';
import 'package:magic_herb/screens/user_details.dart';
import 'package:provider/provider.dart';

import 'navigation.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      color: Color(0xff94a78e),
      child: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: RPSCustomPainter(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                SizedBox(height: 50,),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/Herb.jpg'),
                    ),
                  ),
                ),
                const SizedBox(height: 70.0),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Hello!",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                      ),
                      Text(
                        "Sign up for an account",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email address",
                          ),
                          controller: emailTextController),
                      const SizedBox(height: 10.0),
                      TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Name",
                          ),
                          controller: nameTextController),
                      const SizedBox(height: 10.0),
                      TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                          ),
                          controller: passwordTextController),
                      const SizedBox(height: 30.0),
                      Container(
                        width: MediaQuery.of(context).size.width*.5,
                        child: RaisedButton(
                          padding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Color(0xff4f7344),
                          textColor: Colors.white,
                          onPressed: () async {
                            await authService.createUserWithEmailAndPassword(
                                emailTextController.text, passwordTextController.text).then((value) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserDetailScreen(email: emailTextController.text, name: nameTextController.text)));
                              final userId = FirebaseAuth.instance.currentUser!.uid;
                              // saveUser(userId);
                              Fluttertoast.showToast(
                                  msg: "User Registered Successfully!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM);
                            }).catchError((error){
                              showDialog(context: context,
                                  builder: (con) {
                                    return AlertDialog(title: Text("Error"),content: Text(error.toString()
                                    ),);
                                  } );
                            });
                          },
                          child: Text("Sign Up"),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    const SizedBox(width: 10.0),
                    InkWell(
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              color: Color(0xff4f7344),
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_0.shader = ui.Gradient.linear(
        Offset(size.width * 0.64, size.height * 0.11),
        Offset(size.width, size.height * 0.11),
        [Color(0xffb2bfae), Color(0xff93a88d)],
        [0.00, 1.00]);
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.64, 0);
    path_0.quadraticBezierTo(size.width * 0.74, size.height * 0.09,
        size.width * 0.79, size.height * 0.08);
    path_0.cubicTo(size.width * 0.74, size.height * 0.09, size.width * 0.69,
        size.height * 0.14, size.width * 0.71, size.height * 0.17);
    path_0.quadraticBezierTo(size.width * 0.72, size.height * 0.19,
        size.width * 0.79, size.height * 0.21);
    path_0.quadraticBezierTo(
        size.width * 0.93, size.height * 0.24, size.width, size.height * 0.21);
    path_0.quadraticBezierTo(size.width, size.height * 0.16, size.width, 0);
    path_0.lineTo(size.width * 0.64, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
    Paint paint_1 = new Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_1.shader = ui.Gradient.linear(
        Offset(size.width * 0.64, size.height * 0.12),
        Offset(size.width, size.height * 0.12),
        [Color(0xff93a88d), Color(0xff4f7344)],
        [0.00, 1.00]);
    Path path_1 = Path();
    path_1.moveTo(size.width * 0.64, size.height * 0.08);
    path_1.quadraticBezierTo(size.width * 0.68, size.height * 0.15,
        size.width * 0.76, size.height * 0.13);
    path_1.cubicTo(size.width * 0.81, size.height * 0.15, size.width * 0.71,
        size.height * 0.22, size.width * 0.74, size.height * 0.24);
    path_1.quadraticBezierTo(
        size.width * 0.81, size.height * 0.27, size.width, size.height * 0.18);
    path_1.lineTo(size.width, 0);
    path_1.quadraticBezierTo(size.width * 0.83, 0, size.width * 0.77, 0);
    path_1.quadraticBezierTo(size.width * 0.66, size.height * 0.02,
        size.width * 0.64, size.height * 0.08);
    path_1.close();

    // canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
