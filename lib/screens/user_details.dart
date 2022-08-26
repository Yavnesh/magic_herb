import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magic_herb/auth/auth_services.dart';
import 'package:magic_herb/auth/user_db.dart';
import 'package:magic_herb/screens/navigation.dart';
import 'package:provider/provider.dart';

class UserDetailScreen extends StatefulWidget {
  final String? email, name;
  const UserDetailScreen({Key? key, this.email, this.name}) : super(key: key);

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  String uploadedPath = "";
  late XFile _image;
  ImagePicker imagePicker = ImagePicker();
  bool _isLoading = false;
  File? _imageFile;
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  selectImage() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
          builder: (context) =>
              Column(mainAxisSize: MainAxisSize.min, children: [
                ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.of(context).pop();
                      imagePickerMethod(ImageSource.camera);
                    }),
                ListTile(
                    leading: Icon(Icons.filter),
                    title: Text("Gallery"),
                    onTap: () {
                      Navigator.of(context).pop();
                      imagePickerMethod(ImageSource.gallery);
                    })
              ]),
          onClosing: () {},
        ));
  }

  imagePickerMethod(ImageSource source) async {
    var pic = await imagePicker.pickImage(source: source);
    if (pic != null) {
      setState(() {
        _image = XFile(pic.path);
      });
    }
    uploadImage(); // image upload function
  }

  void uploadImage() {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageReference =
    FirebaseStorage.instance.ref().child('Images').child(imageFileName);
    final UploadTask uploadTask = storageReference.putFile(File(_image.path));
    uploadTask.snapshotEvents.listen((event) {
      setState(() {
        _isLoading = true;
      });
    });
    uploadTask.then((TaskSnapshot taskSnapshot) async {
      uploadedPath = await uploadTask.snapshot.ref.getDownloadURL();
      print(uploadedPath);

      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {});
  }

  void saveUser() {
    UsersDatabase.addUser(
      userId: userId,
      user_name: widget.name.toString(),
      user_contact: _phoneNumberController.text,
      user_image: uploadedPath,
      user_location: _locationController.text,
      user_email: widget.email.toString(),
      user_about: _aboutController.text,
      user_website: _websiteController.text,
      user_profession: _professionController.text,
    ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Navigation())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xbe94a78e),
                  Color(0xbe94a78e),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    _imageFile != null
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20,
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ],
                    )
                        : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: Card(
                        elevation: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff1E5128),
                                  Color(0xff1E5128),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .3,
                          child: _isLoading == false
                              ? Container(
                            child: uploadedPath == ""
                                ? Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  color: Colors.white,
                                  size: 100,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5),
                                  child: Text(
                                    "Upload Image",
                                    style:
                                    TextStyle(fontSize: 22,color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5),
                                  child: Text(
                                    "click here for upload image", style: TextStyle(color: Colors.white),),
                                )
                              ],
                            )
                                : Image(
                                image:
                                NetworkImage(uploadedPath)),
                          )
                              : CircularProgressIndicator(
                            color:  Color(0xff1E5128),
                          ),
                          // child: Image.asset(
                          //   'assets/images/upload.png',
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _websiteController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.0)),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      hintText: "Enter website",
                      hintStyle:
                      TextStyle(fontSize: 18.0, color: Colors.white),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _phoneNumberController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.0)),
                      prefixIcon: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      hintText: "Enter phone number",
                      hintStyle:
                      TextStyle(fontSize: 18.0, color: Colors.white),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _locationController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.0)),
                      prefixIcon: const Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                      hintText: "Enter Location",
                      hintStyle:
                      TextStyle(fontSize: 18.0, color: Colors.white),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _professionController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.0)),
                      prefixIcon: const Icon(
                        Icons.assignment_ind_outlined,
                        color: Colors.white,
                      ),
                      hintText: "Enter profession",
                      hintStyle:
                      TextStyle(fontSize: 18.0, color: Colors.white),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _aboutController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.0)),
                      prefixIcon: const Icon(
                        Icons.assignment_ind_outlined,
                        color: Colors.white,
                      ),
                      hintText: "Enter about me",
                      hintStyle:
                      TextStyle(fontSize: 18.0, color: Colors.white),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              // SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: RaisedButton(
                  onPressed: () async {
                    saveUser();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: MediaQuery.of(context).size.width*.5,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: new LinearGradient(
                            colors: [Color(0xff1E5128), Color(0xff1E5128)])),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "Save",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
