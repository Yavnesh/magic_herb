import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:magic_herb/screens/checkoutScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("This feature is under development"),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showAlert(context));
    return Scaffold(
      backgroundColor: Color(0xbe94a78e),
      appBar:AppBar(title: Text("Your Cart"), automaticallyImplyLeading: false, backgroundColor: Color(0xff1E5128)),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                ProductListItem(
                  image: "https://image.freepik.com/free-photo/dry-turmeric-dust-haldi-powder-also-known-as-curcuma-longa-linn-selective-focus_466689-75729.jpg",
                  subtitle: "100 g",
                  title: "Turmeric Powder",
                  price: 900,
                ),
                ProductListItem(
                  image: "https://image.freepik.com/free-photo/selective-focus-shot-basil-leaves_181624-51036.jpg",
                  subtitle: "50 g",
                  title: "Tulsi",
                  price: 600,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0,),
          _buildTotals()
        ],
      ),
    );
  }

  Widget _buildTotals() {
    return ClipPath(
      clipper: OvalTopBorderClipper(),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 5.0,color: Colors.grey.shade700,spreadRadius: 80.0),
          ],
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Subtotal"),
                Text("Rs. 1500"),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Delivery fee"),
                Text("Rs. 100"),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total"),
                Text("Rs. 1600"),
              ],
            ),
            SizedBox(height: 10.0,),
            RaisedButton(
              color: Color(0xff1E5128),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => Checkout()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Continue to Checkout", style: TextStyle(color: Colors.white)),
                  Text("Rs. 1600", style: TextStyle(color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.price,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  final double? price;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10.0),
          Container(
              height: 80.0,
              child: Image.network(
                image,
                height: 80.0,
              )),
          const SizedBox(width: 10.0),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 15,),
                  new Text(subtitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                color: Color(0xff1E5128),
                onPressed: () {},
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    color: Color(0xff1E5128),
                    onPressed: () {},
                  ),
                  Text(
                    "1",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                    ),
                    color: Color(0xff1E5128),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: Row(
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox( width: 10,),
                    Text(
                      price.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 10.0),
        ],
      ),
    );
  }
}
