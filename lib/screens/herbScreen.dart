import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magic_herb/auth/cart_db.dart';
import 'package:magic_herb/auth/products_db.dart';
import 'package:magic_herb/main.dart';
import 'package:provider/provider.dart';

import 'navigation.dart';

class HerbScreen extends StatefulWidget {
  final document;
  HerbScreen({Key? key, this.document}) : super(key: key);

  @override
  _HerbScreenState createState() => _HerbScreenState();
}

class _HerbScreenState extends State<HerbScreen> {
  final List<String> images = [
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xbe94a78e),
      appBar:AppBar(
        backgroundColor: Color(0xff1E5128),
        title: Center(child: Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: Text(widget.document['name']),
        ))
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Card(child: Image.network(widget.document['image'])),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text("Scientific Name - ", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text(widget.document['sci_name'], style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text("Region Found - ", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text(widget.document['region'], style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text("Health Benefits - ",  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10,),
                  Flexible(
                    child: Text(
                        widget.document['health_benefits'],
                        maxLines: 3,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50,),
            Text("Products With This Herb:",style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 30,),
            _buildListItem()
          ],
        ),
      )
      // CustomScrollView(
      //   slivers: <Widget>[
      //     SliverToBoxAdapter(
      //       child: Container(
      //         color: Color(0xbe94a78e),
      //           child: ,
      //       ),
      //     ),
      //
      //     SliverList(
      //       delegate: SliverChildBuilderDelegate(
      //             (BuildContext context, int index) {
      //           return Container(
      //               color: Color(0xbe94a78e),
      //               child: _buildListItem());
      //         },
      //       ),
      //     )
      //   ]
      // )
    );
  }

  Widget _buildListItem() {
    return StreamBuilder<QuerySnapshot>(
                stream: ProductsDatabase.readHerbProduct(widget.document['name']),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top:20.0, left:10.0, right: 10.0,),
                    child: ListView(
                      shrinkWrap: true,
                        children: snapshot.data!.docs.map((document) {
                          return InkWell(
                            onTap: (){
                              _onTapItem(context, document);
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(document['image']),
                              ),
                              title: Text(
                                document['name'],
                                softWrap: true,
                              ),
                              subtitle: Text(r"$ " +
                                document['price'],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff1E5128)),
                              ),
                            ),
                          );
                        }).toList()),
                  );
                }
            );
  }

  _onTapItem(BuildContext pcontext, document) {
    Navigator.of(pcontext)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1E5128),
          title: Text(document['name']),
        ),
        body: Material(
          child: Container(
            // The blue background emphasizes that it's a new route.
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Hero(
                          tag: "",
                          child: Image.network(document['image'],
                              fit: BoxFit.cover))),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    document['name'],
                    softWrap: true,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(r"$ " +
                    document['price'],
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1E5128)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height:50,
                    child: RaisedButton(
                        color: Color(0xff1E5128),

                        onPressed: () {
                          streamController.add(3);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Navigation()));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text("Add To Cart", style:TextStyle(color: Colors.white)),
                              ),
                              Icon(Icons.add_shopping_cart_sharp,
                                  color: Colors.white),
                            ])),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }
  }

