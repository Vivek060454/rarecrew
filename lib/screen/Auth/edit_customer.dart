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
import 'package:intl/intl.dart';

import '../../bloc/blocs/customer_bloc.dart';
import '../../bloc/blocsvent/customer_event.dart';
import '../../theme.dart';


class EditCustomer extends StatefulWidget {
  final dta;
   EditCustomer(this.dta,  {Key? key}) : super(key: key);

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final TextEditingController name = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  String imageName = '';
  late XFile imagePath;
  final ImagePicker _picker = ImagePicker();

@override
  void initState() {

    name.text==widget.dta.name.toString()??'';
    city.text==widget.dta.city.toString()??'';
    state.text==widget.dta.state.toString()??'';
    // name==widget.dta.name??'';
    selectedDate==widget.dta.dob?? DateTime.now();
    // TODO: implement initState
    super.initState();
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

//  final TextEditingController  _brandController = new TextEditingController();



  upload() async {
  if(imageName==''){

    context.read<ProfileBloc>().add(updatedata(
        widget.dta.id, name.text, state.text, city.text, widget.dta.image.toString(),
        selectedDate.toString()));
  }
  else {
    UploadTask? uploadTask;
    UploadTask? uploadTask1;
    UploadTask? uploadTask2;
    final path = 'Image/${imageName}';
    final file = File(imagePath.path);
    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask;
    var url = await snapshot.ref.getDownloadURL();
    print('url$url');
    // print('countryValue$countryValue');
    // print('stateValue$stateValue');
    // print('cityValue$cityValue');
    context.read<ProfileBloc>().add(updatedata(
        widget.dta.id, name.text, state.text, city.text, url.toString(),
        selectedDate.toString()));
  }
    clearText();
    // Fluttertoast.showToast(msg: "Enter all details$countryValue$url$stateValue$cityValue'");
  }
  clearText(){
    name.clear();
    city.clear();
    state.clear();
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
          title: Text('Update Customer '),
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
                                        image:widget.dta.image.toString()
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
                                          Icons.edit,
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
                                          Icons.edit,
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
                          TextFormField(
                            autofocus: false,
                            controller: state,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              state.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              // prefixIcon: Icon(Icons.email),
                                contentPadding: EdgeInsets.fromLTRB(
                                    20, 15, 20, 15),
                                hintText: "Enter state",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (state) {
                              if (state!.isEmpty) {
                                return ("Please enter state");
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autofocus: false,
                            controller: city,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              city.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              // prefixIcon: Icon(Icons.email),
                                contentPadding: EdgeInsets.fromLTRB(
                                    20, 15, 20, 15),
                                hintText: "Enter city",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (city) {
                              if (city!.isEmpty) {
                                return ("Please enter city");
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
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
                                if(city.text==''||state.text==''){
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
                                child: Text('Update',

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
