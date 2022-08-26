import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:magic_herb/auth/auth_services.dart';
import 'package:magic_herb/auth/user_db.dart';
import 'package:magic_herb/screens/signIn.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final Stream<QuerySnapshot> _stream;
    _stream = UsersDatabase.readUser(userId);
    return StreamBuilder(
        stream: _stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot)
    {
      if (!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      final List userDetails = [];
      snapshot.data!.docs.map((e) {
        Map details = e.data() as Map<String, dynamic>;
        userDetails.add(details);
      }).toList();
      return Scaffold(
        backgroundColor: Color(0xbe94a78e),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.network(
                  userDetails[0]["user_image"],
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 96.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      userDetails[0]['user_name'], style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(userDetails[0]['user_profession']),
                                      subtitle: Text(userDetails[0]['user_location']),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      userDetails[0]['user_image']),
                                  fit: BoxFit.cover)),
                          margin: EdgeInsets.only(left: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text("User information"),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Email"),
                            subtitle: Text(userDetails[0]['user_email']),
                            leading: Icon(Icons.email,
                                color: Color(0xff1E5128)),
                          ),
                          ListTile(
                            title: Text("Phone"),
                            subtitle: Text(userDetails[0]['user_contact']),
                            leading: Icon(Icons.phone,
                                color: Color(0xff1E5128)),
                          ),
                          ListTile(
                            title: Text("Website"),
                            subtitle: Text(userDetails[0]['user_website']),
                            leading: Icon(Icons.web,
                                color: Color(0xff1E5128)),
                          ),
                          ListTile(
                            title: Text("About"),
                            subtitle: Text(
                                userDetails[0]['user_about']),
                            leading: Icon(Icons.person,
                                color: Color(0xff1E5128)),
                          ),
                          ListTile(
                            title: Text("Joined Date"),
                            subtitle: Text("15 February 2019"),
                            leading: Icon(Icons.calendar_view_day,
                                color: Color(0xff1E5128)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    RaisedButton(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff1E5128)),
                        child: Center(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      onPressed: () async {
                        authService.signOut().then((value) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        });
                      },),
                  ],
                ),
              ),
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
              )
            ],
          ),
        ),
      );
    });
  }
}
