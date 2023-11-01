import 'dart:convert';
import 'dart:io';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../bloc/blocs/customer_bloc.dart';
import '../../bloc/blocsvent/customer_event.dart';
import '../../theme.dart';


class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _formKey = GlobalKey<FormState>();

  var countryValue;
  var stateValue;

  var cityValue;

  dta() {
    print('sfgbdgr');
  }


  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

//  final TextEditingController  _brandController = new TextEditingController();
  final TextEditingController name = TextEditingController();
  String imageName = '';
  late XFile imagePath;
  final ImagePicker _picker = ImagePicker();

  DateTime selectedDate = DateTime.now();

  upload() async {
    UploadTask? uploadTask;

    final path = 'Image/${imageName}';
    final file = File(imagePath.path);
    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask;
    var url = await snapshot.ref.getDownloadURL();
    print('url$url');
    print('countryValue$countryValue');
    print('stateValue$stateValue');
    print('cityValue$cityValue');
    // Fluttertoast.showToast(msg: "Enter all details$countryValue$url$stateValue$cityValue'");
    context.read<ProfileBloc>().add(adddata(name.text,stateValue.toString(),countryValue.toString(),cityValue.toString(),url.toString(),selectedDate.toString()));
cleartext();
  }
cleartext(){
  countryValue.clear();
  stateValue.clear();
  cityValue.clear();

}


  @override
  void dispose() {
    name.dispose();


    super.dispose();
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add User'),
        ),
        backgroundColor: Mytheme().primary,
        body: SingleChildScrollView(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          imageName == ''
                              ? Stack(children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircleAvatar(
                                minRadius: 60,
                                maxRadius: 61,
                                child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images.jpeg',
                                      image: "https://firebasestorage.googleapis.com/v0/b/askehs-8a16d.appspot.com/o/images.jpeg?alt=media&token=86157703-245b-4e9c-a90f-9ac7d51b9894&_gl=1*1eyad72*_ga*MTU2ODEwMTc1NC4xNjk2OTEwNzk0*_ga_CW55HF8NVT*MTY5NjkxMDc5My4xLjEuMTY5NjkxMTgzNi4xMC4wLjA."
                                      //fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Positioned(
                              right: 1,
                              top: 1,
                              child: InkWell(
                                onTap: () {
                                  imagePicker();
                                  //              // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(profileresponse!.data)));
                                },
                                child: Container(
                                    height: 68,
                                    width: 68,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: Container(
                                      // height: 40,
                                      // width: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              60),
                                          color: Mytheme().primary,
                                        ),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ))),
                              ),
                            ),
                          ])
                              : Stack(children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircleAvatar(
                                minRadius: 60,
                                maxRadius: 61,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(80)),
                                  child: Container(
                                    padding: const EdgeInsets.all(1.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image:
                                            FileImage(File(imagePath!.path)),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 1,
                              top: 1,
                              child: InkWell(
                                onTap: () {
                                  imagePicker();
                                  //              // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(profileresponse!.data)));
                                },
                                child: Container(
                                    height: 68,
                                    width: 68,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: Container(
                                      // height: 40,
                                      // width: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              60),
                                          color: Mytheme().primary,
                                        ),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ))),
                              ),
                            )
                          ]),


                          TextFormField(
                            autofocus: false,
                            controller: name,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              name.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              // prefixIcon: Icon(Icons.email),
                                contentPadding: EdgeInsets.fromLTRB(
                                    20, 15, 20, 15),
                                hintText: "Enter name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (name) {
                              if (name!.isEmpty) {
                                return ("Please enter name");
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          CSCPicker(
                            onCountryChanged: (value) {
                              dta();
                              setState(() {
                                dta();
                                countryValue = value;
                              });
                            },
                            onStateChanged: (value) {
                              setState(() {
                                stateValue = value;
                              });
                            },
                            onCityChanged: (value) {
                              setState(() {
                                dta();
                                cityValue = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text('Date of Birth',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)
                              ),
                              child: Table(
                                columnWidths: {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(4)
                                },
                                children: [
                                  TableRow(
                                      children: [
                                        IconButton(onPressed: () {
                                          _selectDate(context);
                                        },
                                            icon: Icon(Icons.date_range)),
                                        Container(

                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 15),
                                            child: Text(
                                            selectedDate.day.toString()+"-"+ selectedDate.month.toString()+"-"+ selectedDate.year.toString()),
                                          ),
                                        ),
                                      ]
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          InkWell(
                            onTap: () async {
                              print('rg');
                              if (_formKey.currentState!.validate()) {
if(imageName==''||cityValue==null||countryValue==null||stateValue==null){
  Fluttertoast.showToast(msg: "Enter all details");
  print('fgh');

}
else{
upload();}
                              }
                            },
                            child: Container(

                              height: 50,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                color: Mytheme().primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text('ADD',

                                  style: TextStyle(fontSize: 20,
                                      color: Colors.white,
                                      letterSpacing: 3.0),
                                ),
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }


  imagePicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
        imageName = image.name.toString();
      });
    }
  }
}
