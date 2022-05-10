import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/modules/login/social_login.dart';
import 'package:sup/utils/constant_key.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/shared_preference.dart';
import 'package:sup/utils/text_style.dart';
import 'dart:io' as Io;
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  final bool isFirstTime;
  EditProfile(this.isFirstTime);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  LoginController _loginController=Get.find();

  InputDecoration textFieldDecoration = InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintStyle: textStyle10.copyWith(color: Colors.white));

  String name = "";
  String mobileNumber = "";
  String weight = "";
  String height = "";
  String gender = "Male";
  bool isColorBlack = false;
  int genderType = 1;
  DateTime currentDate = DateTime.now();
  String dateOfBirth = "Select DOB";
  String databaseDate = "";
  String referralCode = "";

  String address="";
  String city="";
  String state="";
  bool isDateSelected=false;

  late TextEditingController textDateController;

  XFile _image=XFile("");
  String photo_1 = "";
  bool isImageUpdate = false;

  var permissionGranted = false;

  @override
  void initState() {
    if(widget.isFirstTime){
      name=_loginController.modelUser.value.name.toString();
    }
    if(_loginController.modelUser.value.dob==null){
      isDateSelected=false ;
    }else{
      databaseDate = _loginController.modelUser.value.dob!;
      var date =
          DateTime.parse(_loginController.modelUser.value.dob.toString());
      dateOfBirth = DateFormat.yMMMMd().format(date);

      isDateSelected = true;
    }
    textDateController = TextEditingController(text: dateOfBirth);

    if(_loginController.modelUser.value.weight!=null){
      weight=_loginController.modelUser.value.weight.toString();
    }else{
      weight="";
    }

    if(_loginController.modelUser.value.height!=null){
      height=_loginController.modelUser.value.height.toString();
    } else {
      height = "";
    }

    if (_loginController.modelUser.value.gender != null) {
      gender = _loginController.modelUser.value.gender.toString();
    } else {
      gender = "";
    }

    if (_loginController.modelUser.value.name != null) {
      name = _loginController.modelUser.value.name.toString();
    } else {
      name = "";
    }

    if (_loginController.modelUser.value.mobileNumber != null) {
      mobileNumber = _loginController.modelUser.value.mobileNumber.toString();
    } else {
      mobileNumber = "";
    }

    if (_loginController.modelUser.value.address != null) {
      address = _loginController.modelUser.value.address.toString();
    } else {
      address = "";
    }

    if (_loginController.modelUser.value.city != null) {
      city = _loginController.modelUser.value.city.toString();
    } else {
      city = "";
    }

    if (_loginController.modelUser.value.state != null) {
      state = _loginController.modelUser.value.state.toString();
    } else {
      state = "";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: onClickBack,
        child:Scaffold(
      backgroundColor: Colors.black.withOpacity(0.95),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top),
          child: Container(
            height: AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: Colors.black,
            // color: Colors.yellow,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      type: MaterialType.circle,
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          onClickBack();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                              size: Get.width*0.05
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Profile",
                    style: textStyle16.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )),
      body: Container(
        padding: EdgeInsets.all(16),
        height: Get.height,
        color: Colors.black.withOpacity(0.95),
        child: Obx(()=>SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: Get.height * 0.04,
              ),

              // widget.isFirstTime?SizedBox.shrink():,
              Center(
                child: Material(
                  color: Colors.red,
                  type: MaterialType.circle,
                  child: InkWell(

                    onTap: (){
                      _getStoragePermission();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(1),
                      child: isImageUpdate?CircleAvatar(
                          radius: 45,

                          backgroundColor: Colors.grey,
                          child: ClipOval(
                            child: Image.file(
                              File(_image.path),
                              fit: BoxFit.contain,
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.width * 0.25,

                            ),
                          )):Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                            image: DecorationImage(
                                image: NetworkImage(_loginController.modelUser.value.image!=null?_loginController.modelUser.value.image.toString().contains("http")?_loginController.modelUser.value.image.toString():STORAGE_URL+_loginController.modelUser.value.image.toString():PROFILE),
                                fit: BoxFit.contain)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Text(
                "Name",
                style:
                textStyle12.copyWith(color: Colors.white.withOpacity(0.60)),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  initialValue: name,
                  style: textStyle12.copyWith(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: textFieldDecoration.copyWith(
                      hintText: "Name",
                      hintStyle: textStyle12.copyWith(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  initialValue: mobileNumber,
                  style: textStyle12.copyWith(color: Colors.white),
                  maxLength: 10,
                  onChanged: (value) {
                    setState(() {
                      mobileNumber = value;
                    });
                  },
                  keyboardType: TextInputType.phone,
                  decoration: textFieldDecoration.copyWith(
                      hintText: "Mobile Number",
                      counterText: "",
                      hintStyle: textStyle12.copyWith(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Weight",
                            style: textStyle12.copyWith(
                                color: Colors.white.withOpacity(0.60)),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextFormField(
                              initialValue: weight,
                              style: textStyle12.copyWith(color: Colors.white),
                              onChanged: (value) {
                                setState(() {
                                  weight = value;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: textFieldDecoration.copyWith(
                                  hintText: "i.e 70",
                                  hintStyle:
                                  textStyle12.copyWith(color: Colors.grey)),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    width: 32,
                  ),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Height",
                            style: textStyle12.copyWith(
                                color: Colors.white.withOpacity(0.60)),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextFormField(
                              initialValue: height,
                              style: textStyle12.copyWith(color: Colors.white),
                              onChanged: (value) {
                                setState(() {
                                  height = value;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: textFieldDecoration.copyWith(
                                  hintText: "i.e 5.56",
                                  hintStyle:
                                  textStyle12.copyWith(color: Colors.grey)),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date of Birth",
                            style: textStyle12.copyWith(
                                color: Colors.white.withOpacity(0.60)),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8)),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: TextFormField(
                                  controller: textDateController,
                                  enabled: false,
                                  style: textStyle12.copyWith(color: Colors.white),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: textFieldDecoration.copyWith(
                                      hintText: dateOfBirth,
                                      hintStyle:
                                      textStyle12.copyWith(color: Colors.grey)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    width: 32,
                  ),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
                            style: textStyle12.copyWith(
                                color: Colors.white.withOpacity(0.60)),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Container(
                            width: Get.width,
                            padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8)),
                            child: DropdownButton<String>(
                              // value: gender,
                                hint: Text(gender,
                                    style: TextStyle(color: Colors.white)),
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 22,
                                // style:textStyle12.copyWith(color: isColorBlack?Colors.black:Colors.white),
                                underline: SizedBox(),
                                onChanged: (newValue) {
                                  setState(() {
                                    gender = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Male',
                                  'Female',
                                  'Other',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()),
                          )
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              widget.isFirstTime?Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  initialValue: referralCode,
                  style: textStyle12.copyWith(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      referralCode = value;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: textFieldDecoration.copyWith(
                      hintText: "Referral Code",
                      hintStyle: textStyle12.copyWith(color: Colors.grey)),
                ),
              ):SizedBox.shrink(),
              SizedBox(
                height: Get.height * 0.02,
              ),

              Visibility(
                  visible: widget.isFirstTime?false:true,
                  // visible: true,
                  child: Column(
                    children: [
                      Divider(color: Colors.white,),

                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          initialValue: address,
                          style: textStyle12.copyWith(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              address = value;
                            });
                          },
                          keyboardType: TextInputType.streetAddress,
                          decoration: textFieldDecoration.copyWith(
                              hintText: "Address",
                              hintStyle: textStyle12.copyWith(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "City",
                                    style: textStyle12.copyWith(
                                        color: Colors.white.withOpacity(0.60)),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      initialValue: city,
                                      style: textStyle12.copyWith(color: Colors.white),
                                      onChanged: (value) {
                                        setState(() {
                                          city = value;
                                        });
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: textFieldDecoration.copyWith(
                                          hintText: "i.e Surat",
                                          hintStyle:
                                          textStyle12.copyWith(color: Colors.grey)),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: 32,
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "State",
                                    style: textStyle12.copyWith(
                                        color: Colors.white.withOpacity(0.60)),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      initialValue: state,
                                      style: textStyle12.copyWith(color: Colors.white),
                                      onChanged: (value) {
                                        setState(() {
                                          state = value;
                                        });
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: textFieldDecoration.copyWith(
                                          hintText: "i.e Gujarat",
                                          hintStyle:
                                          textStyle12.copyWith(color: Colors.grey)),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        )),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(16),
        child: Obx(()=>Material(
          color: Color(0xffEF4723),
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: () {
              if (name.isEmpty) {
                showToast("Please enter name");
              }else if (mobileNumber.isEmpty) {
                showToast("Please enter mobile number");
              }else if (mobileNumber.length<10) {
                showToast("Please enter valid mobile number");
              }else if (height.isEmpty) {
                showToast("Please enter height");
              }else if (weight.isEmpty) {
                showToast("Please enter weight");
              }else if (!isDateSelected) {
                showToast("Please select date of birth");
              }else if (gender.isEmpty) {
                showToast("Please select gender");
              }  else {
                if(isImageUpdate){
                  _loginController.savedProfile(name,weight,height,databaseDate,gender,widget.isFirstTime,referralCode,mobileNumber,address,city,state,photo_1);
                }else{
                  _loginController.savedProfile(name,weight,height,databaseDate,gender,widget.isFirstTime,referralCode,mobileNumber,address,city,state,"");
                }
              }
            },
            child: Container(
              width: Get.width,
                      height: AppBar().preferredSize.height,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _loginController.isSavedProgressVisible.value
                              ? whiteLoader()
                              : Text(
                                  "Save",
                                  style: textStyle14.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                        ],
              ),
            ),
          ),
        )),
      ),
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    var date = new DateTime.now().toString();


    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        isDateSelected=true;
        databaseDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        dateOfBirth = DateFormat.yMMMMd().format(pickedDate);
        textDateController.text = dateOfBirth;
        print(dateOfBirth);
      });
  }

  _imgFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image != null) {
      setState(() {
        isImageUpdate = true;
        _image = image;
        photo_1 = base64Encode(Io.File(_image.path).readAsBytesSync());
        print(photo_1);
      });
    }
  }

  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        permissionGranted = true;
      });
      _imgFromGallery();
    }
  }

  _confirmExit(BuildContext context) {
    return AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              Text(
                "You have not update your profile,are you sure to Exit ?",
                style: TextStyle(fontSize: 18),
              )
            ],
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () async {
            SystemNavigator.pop();
          },
          textColor: Colors.black,
          child: const Text('YES'),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
          textColor: Colors.red,
          child: const Text('CANCEL'),
        ),
      ],
    );
  }

  Future<bool> onClickBack() async {
    if(widget.isFirstTime){
      if(_loginController.modelUser.value.weight==null){
          showDialog(
              context: context,
              builder: (context) =>
                  _confirmExit(context));
      }
    }else{
      Get.back();
    }
    return true;
  }
}
