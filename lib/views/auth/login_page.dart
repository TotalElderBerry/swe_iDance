import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/auth/register_page.dart';
import 'package:i_dance/views/home.dart';
 
import '../../controllers/auth/auth_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? isCorrect = true;
  @override
  Widget build(BuildContext context) {
    final _auth = Get.find<AuthController>();
    String name = _auth.name.value;
    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: WaveClipper2(),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color.fromARGB(33, 176, 58, 255),
                        Color.fromARGB(33, 176, 58, 255)
                      ])),
                      child: Column(),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper3(),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color.fromARGB(68, 143, 58, 255),
                        Color.fromARGB(68, 143, 58, 255)
                      ])),
                      child: Column(),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper1(),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.purple, Colors.purple])),
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 40,
                          ),
                          Icon(
                            Icons.music_note_rounded,
                            color: Colors.white,
                            size: 60,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "iDance",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: TextField(
                    controller: userController,
                    onChanged: (String value) {},
                    decoration: const InputDecoration(
                        hintText: "Email",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.email,
                            color: Colors.purple,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: TextField(
                    controller: passwordController,
                    onChanged: (String value) {},
                    decoration: const InputDecoration(
                        hintText: "Password",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.lock,
                            color: Colors.purple,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Colors.purple,
                  ),
                  child: TextButton(
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    onPressed: () async {
                      AuthController authController = Get.find();
                      if (authController.name.value == null) {
                        print(
                            'The current user: ${authController.currentUser.value}');
                      } else {
                        print(
                            'The current user: ${authController.currentUser.value}');
                      }
                      bool isSuccess = await authController.login(
                          userController.text, passwordController.text);
                      print(isSuccess);
                      if (isSuccess) Get.to(HomePage());
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  Get.to(RegisterPage());
                },
                child: const Text(
                  "Register Now",
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
                  // TextField(

                  //   controller: passwordController,
                  //   decoration: InputDecoration(
                  //     hintText: "Password",
                  //   ),
                  // ),
                  // Divider(),

                  (isCorrect!)?
                  Text("")
                  :
                  Text("Credentials Incorrect"),

                // ElevatedButton(onPressed: () async {
                //   AuthController authController = Get.find();
                //   if(authController.name.value == null){
                //     print('The current user: ${authController.currentUser.value}');
                //   }else{
                //     print('The current user: ${authController.currentUser.value}');

                //   }
                //   bool isSuccess = await authController.login(userController.text, passwordController.text);
                //   setState(() {
                //     isCorrect = isSuccess;
                //   });
                //   if(isSuccess) Get.to(HomePage());
                // }, child: Text("Login")),

                //   TextButton(onPressed: (){
                //     Get.to(RegisterPage());
                //   }, child: Text("Register Now")),
            ],
          ),
          
        ),
      )
    );
  }
}
 
class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);
 
    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
 
    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
 
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
 
class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);
 
    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
 
    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
 
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
 
class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);
 
    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
 
    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
 
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}