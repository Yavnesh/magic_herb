
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:magic_herb/screens/signIn.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pages = [
    PageViewModel(
      pageColor: Colors.white,
      bubbleBackgroundColor:Color(0xff4f7344),
      title: Container(child: SizedBox(height: 50)),
      body: Column(
        children:[
          Text("Up your Herb knowledge",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),),
          Text("Learn about different types of herbs!",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0
            ),),
        ],
      ),
      mainImage: Image.network("https://image.freepik.com/free-photo/arrangement-natural-various-herbs-top-view_23-2148791496.jpg",
          width: 350,
          alignment: Alignment.center),
      textStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    PageViewModel(
      pageColor: Colors.white,
      bubbleBackgroundColor:Color(0xff4f7344),
      title: Container(),
      body: Column(
        children:[
          Text(
              "Over __ Herbs to view",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),),
          Text("There's herb of the day every day too...",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0
            ),),
        ],
      ),
      mainImage: Image.network("https://image.freepik.com/free-photo/colored-water-cups-with-with-tea-herbs-bowls-flat-lay-dark-textured-background_176474-5165.jpg",
          width: 350,
          alignment: Alignment.center),
      textStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    PageViewModel(
      pageColor: Colors.white,
      bubbleBackgroundColor:Color(0xff4f7344),
      title: Container(),
      body: Column(
        children:[
          Text("Fun Projects", style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),),
          Text("Buy and sell recipes!",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0
            ),),
        ],
      ),
      mainImage: Image.network("https://image.freepik.com/free-photo/top-view-orange-colored-water-with-tea-herbs-sackcloth-gray-wooden-background-horizontal-space-text_176474-5240.jpg",
          width: 350,
          alignment: Alignment.center),
      textStyle: TextStyle(
        color: Colors.black,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SafeArea(
        child:Stack(
          children: [
            IntroViewsFlutter(
              pages,
              onTapDoneButton:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
              },
              showSkipButton: false,
              doneText:Text("Get Started"),
              pageButtonsColor: Colors.black,
            ),
            SizedBox(height: 20),
            Positioned(
                top: 20.0,
                left: MediaQuery.of(context).size.width/2 - 50,
                child: Material(
                  elevation: 5.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage("assets/images/Herb.jpg"),
                  ),
                ),
            )
          ]
        )
      )
    );
  }
}
