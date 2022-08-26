import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:magic_herb/screens/cartScreen.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final List<String> categories = [
    'DarazMall',
    'Flash Sales',
    'Collection',
    'Vouchers',
    'Categories'
  ];
  final List<String> images = [
    "https://image.freepik.com/free-vector/credit-card-vector_23-2147498028.jpg",
    "https://image.freepik.com/free-vector/credit-card-vector_23-2147498028.jpg",
    "https://image.freepik.com/free-vector/credit-card-vector_23-2147498028.jpg",
    "https://image.freepik.com/free-vector/credit-card-vector_23-2147498028.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb0c2ab),
        appBar: AppBar(
          backgroundColor: Color(0xff1E5128),
          title: Text('Checkout'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            ClipPath(
              clipper: DiagonalPathClipperOne(),
              child: Container(
                height: 110,
                color: Color(0xff1E5128),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child: Image.network(
                    "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/03-removebg-preview.png")
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.55),
              child: Text("Payment Details",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
                title: TextField(
              style: TextStyle(color: Color(0xff1E5128)),
              decoration: InputDecoration(
                  hintText: "Cardholder name:",
                  hintStyle: TextStyle(color: Color(0xff1E5128)),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.credit_card,
                    color: Color(0xff1E5128),
                  )),
            )),
            Divider(
              color: Color(0xff1E5128),
            ),
            ListTile(
                title: TextField(
              style: TextStyle(color: Color(0xff1E5128)),
              decoration: InputDecoration(
                  hintText: "CVV:",
                  hintStyle: TextStyle(color: Color(0xff1E5128)),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.lock,
                    color: Color(0xff1E5128),
                  )),
            )),
            Divider(
              color: Color(0xff1E5128),
            ),
            ListTile(
                title: TextField(
              style: TextStyle(color: Color(0xff1E5128)),
              decoration: InputDecoration(
                  hintText: "Expiration Date:",
                  hintStyle: TextStyle(color: Color(0xff1E5128)),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.date_range,
                    color: Color(0xff1E5128),
                  )),
            )),
            Divider(
              color: Color(0xff1E5128),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 41.7),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  elevation: 0,
                  textColor: Colors.white,
                  color: Color(0xff1E5128),
                  child: Text("Complete Transaction".toUpperCase()),
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder:(context) => CartScreen()));},
                ),
              ),
            )
          ]),
        ));
  }
}
