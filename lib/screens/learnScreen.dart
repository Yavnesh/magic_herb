import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:magic_herb/auth/herb_db.dart';
import 'herbScreen.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff4f7344);
  final secondary = Color(0xff000000);

  // final List<Map> schoolLists = [
  //   {
  //     "title": "Borage",
  //     "logoText":
  //         "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/borage.jpg",
  //   },
  //   {
  //     "title": "Jimbu",
  //     "logoText":
  //         "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/jimbu.jpg",
  //   },
  //   {
  //     "title": "Rue",
  //     "logoText":
  //         "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/rue.jpg",
  //   },
  //   {
  //     "title": "Sisho",
  //     "logoText":
  //         "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/sisho.jpg",
  //   },
  //   {
  //     "title": "Sorrel",
  //     "logoText":
  //         "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/sorrel.jpg",
  //   },
  //   {
  //     "title": "Tulsi",
  //     "logoText":
  //         "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/tulsi.jpg",
  //   },
  //   {
  //     "title": "Turmeric",
  //     "logoText":
  //         "https://raw.githubusercontent.com/Siddy-man/Herb-Image-MH/main/turmeric.jpg",
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xbe94a78e),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 145),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                  stream: HerbDatabase.readAllHerbs(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 0.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((document) {
                            return InkWell(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>PostDescriptionScreen(document: document)
                                // ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                width: double.infinity,
                                height: 110,
                                margin:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                padding:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      height: 50,
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(width: 3, color: secondary),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                document['image']),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            document['name'],
                                            style: TextStyle(
                                                color: primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              const SizedBox(width: 10.0),
                                              Expanded(
                                                child: RaisedButton(
                                                  color: Color(0xffD8E9A8),
                                                  textColor: Color(0xff191A19),
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(20.0),
                                                  ),
                                                  child: Text("Info"),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HerbScreen(
                                                                  document: document,
                                                                )));
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 10.0),
                                              Expanded(
                                                child: RaisedButton(
                                                  color: Color(0xff1E5128),
                                                  textColor: Colors.white,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(20.0),
                                                  ),
                                                  child: Text("Products"),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HerbScreen(
                                                                  document: document,
                                                                )));
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 10.0),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList()),
                    );
                  })
              // ListView.builder(
              //     itemCount: schoolLists.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return buildList(context, index);
              //     }),
            ),
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff4f7344),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Herbs",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 110,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: TextField(
                        // controller: TextEditingController(text: locations[0]),
                        cursorColor: Theme.of(context).primaryColor,
                        style: dropdownMenuItem,
                        decoration: InputDecoration(
                            hintText: "Search Herb",
                            hintStyle: TextStyle(
                                color: Colors.black38, fontSize: 16),
                            prefixIcon: Material(
                              elevation: 0.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: Icon(Icons.search),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 13)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget buildList(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: HerbDatabase.readAllHerbs(),
  //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (!snapshot.hasData) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         return Padding(
  //           padding: const EdgeInsets.only(
  //             top: 0.0,
  //             left: 10.0,
  //             right: 10.0,
  //           ),
  //           child: ListView(
  //               shrinkWrap: true,
  //                 children: snapshot.data!.docs.map((document) {
  //               return InkWell(
  //                 onTap: () {
  //                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>PostDescriptionScreen(document: document)
  //                   // ));
  //                 },
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(25),
  //                     color: Colors.white,
  //                   ),
  //                   width: double.infinity,
  //                   height: 110,
  //                   margin:
  //                       EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //                   padding:
  //                       EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: <Widget>[
  //                       Container(
  //                         width: 50,
  //                         height: 50,
  //                         margin: EdgeInsets.only(right: 15),
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(50),
  //                           border: Border.all(width: 3, color: secondary),
  //                           image: DecorationImage(
  //                               image: NetworkImage(
  //                                   document['image']),
  //                               fit: BoxFit.fill),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: <Widget>[
  //                             Text(
  //                               document['name'],
  //                               style: TextStyle(
  //                                   color: primary,
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 18),
  //                             ),
  //                             Row(
  //                               children: <Widget>[
  //                                 const SizedBox(width: 10.0),
  //                                 Expanded(
  //                                   child: RaisedButton(
  //                                     color: Color(0xffD8E9A8),
  //                                     textColor: Color(0xff191A19),
  //                                     elevation: 0,
  //                                     shape: RoundedRectangleBorder(
  //                                       borderRadius:
  //                                           BorderRadius.circular(20.0),
  //                                     ),
  //                                     child: Text("Info"),
  //                                     onPressed: () {
  //                                       // Navigator.push(
  //                                       //     context,
  //                                       //     MaterialPageRoute(
  //                                       //         builder: (context) =>
  //                                       //             HerbScreen(
  //                                       //               herb: schoolLists[index]
  //                                       //                   ['title'],
  //                                       //               image:
  //                                       //                   schoolLists[index]
  //                                       //                       ['logoText'],
  //                                       //             )));
  //                                     },
  //                                   ),
  //                                 ),
  //                                 const SizedBox(width: 10.0),
  //                                 Expanded(
  //                                   child: RaisedButton(
  //                                     color: Color(0xff1E5128),
  //                                     textColor: Colors.white,
  //                                     elevation: 0,
  //                                     shape: RoundedRectangleBorder(
  //                                       borderRadius:
  //                                           BorderRadius.circular(20.0),
  //                                     ),
  //                                     child: Text("Products"),
  //                                     onPressed: () {
  //                                       // Navigator.push(
  //                                       //     context,
  //                                       //     MaterialPageRoute(
  //                                       //         builder: (context) =>
  //                                       //             HerbScreen(
  //                                       //               herb: schoolLists[index]
  //                                       //                   ['title'],
  //                                       //               image:
  //                                       //                   schoolLists[index]
  //                                       //                       ['logoText'],
  //                                       //             )));
  //                                     },
  //                                   ),
  //                                 ),
  //                                 const SizedBox(width: 10.0),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             }).toList()),
  //         );
  //       });
  //   // return Container(
  //   //   decoration: BoxDecoration(
  //   //     borderRadius: BorderRadius.circular(25),
  //   //     color: Colors.white,
  //   //   ),
  //   //   width: double.infinity,
  //   //   height: 110,
  //   //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //   //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //   //   child: Row(
  //   //     crossAxisAlignment: CrossAxisAlignment.start,
  //   //     children: <Widget>[
  //   //       Container(
  //   //         width: 50,
  //   //         height: 50,
  //   //         margin: EdgeInsets.only(right: 15),
  //   //         decoration: BoxDecoration(
  //   //           borderRadius: BorderRadius.circular(50),
  //   //           border: Border.all(width: 3, color: secondary),
  //   //           image: DecorationImage(
  //   //               image: NetworkImage(schoolLists[index]['logoText']),
  //   //               fit: BoxFit.fill),
  //   //         ),
  //   //       ),
  //   //       Expanded(
  //   //         child: Column(
  //   //           crossAxisAlignment: CrossAxisAlignment.start,
  //   //           children: <Widget>[
  //   //             Text(
  //   //               schoolLists[index]['title'],
  //   //               style: TextStyle(
  //   //                   color: primary,
  //   //                   fontWeight: FontWeight.bold,
  //   //                   fontSize: 18),
  //   //             ),
  //   //             Row(
  //   //               children: <Widget>[
  //   //                 const SizedBox(width: 10.0),
  //   //                 Expanded(
  //   //                   child: RaisedButton(
  //   //                     color: Color(0xffD8E9A8),
  //   //                     textColor: Color(0xff191A19),
  //   //                     elevation: 0,
  //   //                     shape: RoundedRectangleBorder(
  //   //                       borderRadius: BorderRadius.circular(20.0),
  //   //                     ),
  //   //                     child: Text("Info"),
  //   //                     onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HerbScreen(herb: schoolLists[index]['title'], image:schoolLists[index]['logoText'],)));},
  //   //                   ),
  //   //                 ),
  //   //                 const SizedBox(width: 10.0),
  //   //                 Expanded(
  //   //                   child: RaisedButton(
  //   //                     color: Color(0xff1E5128),
  //   //                     textColor: Colors.white,
  //   //                     elevation: 0,
  //   //                     shape: RoundedRectangleBorder(
  //   //                       borderRadius: BorderRadius.circular(20.0),
  //   //                     ),
  //   //                     child: Text("Products"),
  //   //                     onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HerbScreen(herb: schoolLists[index]['title'], image:schoolLists[index]['logoText'],)));},
  //   //                   ),
  //   //                 ),
  //   //                 const SizedBox(width: 10.0),
  //   //               ],
  //   //             ),
  //   //           ],
  //   //         ),
  //   //       )
  //   //     ],
  //   //   ),
  //   // );
  // }
}
