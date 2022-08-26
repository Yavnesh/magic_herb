import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:magic_herb/screens/homeScreen.dart';
import 'package:magic_herb/screens/profileScreen.dart';
import 'cartScreen.dart';
import 'doScreen.dart';
import 'learnScreen.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);
   // final Stream<int> stream;
  // const Navigation({Key? key,required this.stream}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final List<Widget> _tabItems = [HomeScreen(), LearnScreen(), DoScreen(), CartScreen(), ProfileScreen()];
  int _page = 0;
  int newIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   widget.stream.listen((index){
  //     mySetState(index);
  //   });
  // }
  //
  // void mySetState(int index){
  //   setState(() {
  //     newIndex = index!;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: newIndex,
        height: 50,
        items: [
          Icon(Icons.home_filled,
              size: 30,
              color: (_page == 0) ? Color(0xff1E5128) :Colors.white),
          Icon(Icons.eco_outlined,
              size: 30,
              color: (_page == 1) ? Color(0xff1E5128) :Colors.white),
          Icon(Icons.add_business,
              size: 30,
              color: (_page == 2) ? Color(0xff1E5128) :Colors.white),
          Icon(Icons.add_shopping_cart_sharp,
              size: 30,
              color: (_page == 3) ? Color(0xff1E5128) :Colors.white),

          Icon(Icons.account_box,
              size: 30,
              color: (_page == 4) ? Color(0xff1E5128) :Colors.white),
        ],
        color: Color(0xff1E5128),
        buttonBackgroundColor: Colors.grey[50],
        backgroundColor: Color(0xffD8E9A8),
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _tabItems[_page],
    );
  }

}

