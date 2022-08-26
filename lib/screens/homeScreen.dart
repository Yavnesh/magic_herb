import 'dart:math';

import 'package:flutter/material.dart';
import 'package:magic_herb/screens/doScreen.dart';
import 'herbScreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  Color? appBarBackground;
  late double topPosition;
  @override
  void initState() {
    topPosition = -80;
    appBarBackground = Colors.transparent;
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  double _getOpacity() {
    double op = (topPosition + 80) / 80;
    return op > 1 || op < 0 ? 1 : op;
  }

  _onScroll() {
    if (_scrollController.offset > 50) {
      if (topPosition < 0)
        setState(() {
          topPosition = -130 + _scrollController.offset;
          if (_scrollController.offset > 130) topPosition = 0;
        });
    } else {
      if (topPosition > -80)
        setState(() {
          topPosition--;
          if (_scrollController.offset <= 0) topPosition = -80;
        });
    }
  }

  List images = [
    "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/borage.jpg",
    "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/jimbu.jpg",
    "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/rue.jpg",
    "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/shiso.jpg",
    "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/sorrel.jpg",
    "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/tulsi.jpg",
    "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/turmeric.jpg"
  ];
  List titles = [
    "Borage",
    "Jimbu",
    "Rue",
    "Sisho",
    "Sorrel",
    "Tulsi",
    "Turmeric"
  ];
  List greetings = [
    "Welcome Back ",
    "What's Up ",
    "Let's go ",
    "Get ready to have some fun ",
    "Hi "
  ];
  int randomNumber = Random().nextInt(7);
  int randomGreeting = Random().nextInt(5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xbe94a78e),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*1,
                  padding: const EdgeInsets.only(left: 16.0, right: 50),
                  height: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0)),
                    color: Color(0xff1E5128),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 70),
                      Text(
                        greetings[randomGreeting],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
                      ),
                      const SizedBox(height: 20.0),
                      Text("Robert" ,style:TextStyle(fontSize: 24, fontWeight:FontWeight.bold, color: Colors.white))
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                const SizedBox(height: 20.0),
                        Container( height: 300, child:
                        Column(
                          children: <Widget>[
                        Container(
                        width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.freepik.com/free-photo/top-view-cooked-pearl-barley-inside-plate-with-notepad-light-surface_140725-75115.jpg'),
                                  fit: BoxFit.cover)),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  color: Color.fromRGBO(30, 81, 40, 0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      " Deal Of The Day ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                RaisedButton(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DoScreen()));},
                                  child: Container(
                                    height: 50,
                                    margin: EdgeInsets.symmetric(horizontal: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xff1E5128)),
                                    child: Center(
                                        child: Text(
                                          "Shop Now",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ])),

                const SizedBox(height: 30.0),
                Container( height: 300, child:
                Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    images[randomNumber]),
                                fit: BoxFit.cover)),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                color: Color.fromRGBO(30, 81, 40, 0.5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Herb Of The Day",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              RaisedButton(
                                color: Colors.transparent,
                                elevation: 0,
                                onPressed: (){
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => HerbScreen(document: ,)));
                                  },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff1E5128)),
                                  child: Center(
                                      child: Text(
                                        "Explore",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])),
                const SizedBox(height: 30.0),
                // Container(color: Colors.pink, height: 300),
              ],
            ),
          ),

          Positioned(
              top: topPosition,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                padding: const EdgeInsets.only(left: 50,top: 25.0,right: 20.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0)),
                  color: Color(0xff1E5128).withOpacity(_getOpacity()),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  child: Semantics(
                    child: Text(
                        greetings[randomGreeting],
                      style: TextStyle(color: Colors.white, fontSize: 18.0,fontWeight: FontWeight.bold),
                    ),
                    header: true,
                  ),
                ),
              )
          ),
          SizedBox(
            height: 80,
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
            ),
          )
        ],
      ),
    );
  }
}
