import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class form extends StatefulWidget {
  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  TextEditingController _nameController = TextEditingController();

  TextEditingController _numberController = TextEditingController();

  TextEditingController _gmailController = TextEditingController();

  Future adddata() async {
    final imgurl = await uploadimage(_image!);
    await user.add({
      "name": _nameController.text.trim(),
      "mobile": _numberController.text.trim(),
      "gmail": _gmailController.text.trim(),
      "images": imgurl,
    });
  }

  File? _image;

  final Picker = ImagePicker();
  Future imagePicker() async {
    try {
      final pick = await Picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pick != null) {
          _image = File(pick.path);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future uploadimage(File _image) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child('images').child('users$imgId');
    await reference.putFile(_image);
    url = await reference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Form"),
        backgroundColor: Color(0XFF4169e1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0XFF4169e1)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _image == null
                          ? Text("no image selected")
                          : Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              height: 198,
                              width: 200,
                            ),
                    ],
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      imagePicker();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("selected image"),
                    )),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text("Name"),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0XFFEFF3F6),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(6, 2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0),
                      BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          offset: Offset(-6, -2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Enter Name"),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Phone"),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0XFFEFF3F6),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(6, 2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0),
                      BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          offset: Offset(-6, -2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: _numberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "+91"),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Email"),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0XFFEFF3F6),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(6, 2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0),
                      BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          offset: Offset(-6, -2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: _gmailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Email",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // adddata();
                      adddata();
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                          child: Text(
                        "Add user",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      )),
                      decoration: BoxDecoration(
                          color: Color(0XFF4169e1),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0XFF4169e1),
                                offset: Offset(6, 1),
                                blurRadius: 1.0,
                                spreadRadius: 2.0),
                          ]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
