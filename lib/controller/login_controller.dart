import 'dart:convert';

import 'package:get/get.dart';
import 'package:sup/model/model_user.dart';
import 'package:sup/modules/profile/edit_profile.dart';
import 'package:sup/page/home.dart';
import 'package:sup/utils/constant_key.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/request.dart';
import 'package:sup/utils/shared_preference.dart';


class LoginController extends GetxController{
  var isEmailEnter=false.obs;
  var isMobileEnter=false.obs;
  var isPasswordEnter=false.obs;
  var isConfirmPasswordEnter=false.obs;

  var email="".obs;
  var mobileNumber="".obs;
  var password="".obs;
  var confirmPassword="".obs;

  var isLoginProgressVisible=false.obs;
  var isGoogleProgressVisible=false.obs;

  var isFbProgressVisible=false.obs;
  var isRegisterProgressVisible=false.obs;
  var isSavedProgressVisible=false.obs;
  var isForgotPasswordProgressVisible=false.obs;

  var modelUser=ModelUser().obs;


  void resetPassword(email) async {
    isForgotPasswordProgressVisible.value = true;

    Request request = Request(url: urlForgotPassword, body: {
      'type': "API",
      'email': email.toString(),
    });

    request.post().then((value) {
      isForgotPasswordProgressVisible.value = false;
      final responseData = json.decode(value.body);
      if (responseData['status_code'] == 1) {
        showToast(responseData['message']);
      }else{
        showToast("Can't reach to server.");
      }
    }).catchError((onError) {
      isForgotPasswordProgressVisible.value = false;
      showToast("Can't reach to server.");
      print(onError);
    });
  }

  void registerWithGoogle(uid, userName, emailAddress, photo) async {
    isGoogleProgressVisible.value = true;

    Request request = Request(url: urlSignUp, body: {
      'type': "API",
      'google_id': uid.toString(),
      'name': userName.toString(),
      'email': emailAddress.toString(),
      'image': photo.toString(),
      'device_id': deviceId.toString(),
      'login_with': "GOOGLE",
    });

    request.post().then((value) {
      final responseData = json.decode(value.body);
      isGoogleProgressVisible.value = false;
      if (responseData['status_code'] == 1) {
        onLoginSuccess(responseData);
      } else {
        showToast(responseData['message']);
      }
    }).catchError((onError) {
      isGoogleProgressVisible.value = false;
      showToast("Can't reach to server.");
      print(onError);
    });
  }

  void registerWithFacebook(uid, userName, emailAddress, photo) async {
    isFbProgressVisible.value = true;

    Request request = Request(url: urlSignUp, body: {
      'type': "API",
      'facebook_id': uid.toString(),
      'name': userName.toString(),
      'email': emailAddress.toString(),
      'image': photo.toString(),
      'login_with': "FACEBOOK",
      'device_id': deviceId.toString(),
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);
      isFbProgressVisible.value = false;
      if (responseData['status_code'] == 1) {
        onLoginSuccess(responseData);
      } else {
        showToast(responseData['message']);
      }
    }).catchError((onError) {
      isFbProgressVisible.value = false;
      showToast("Can't reach to server.");
      print(onError);
    });
  }

  void registerWithEmail() async {
    isRegisterProgressVisible.value = true;

    Request request = Request(url: urlSignUp, body: {
      'type': "API",
      'email': email.toString(),
      'password': password.toString(),
      'login_with': "EMAIL",
      'device_id': deviceId.toString(),
      'mobile_number': mobileNumber.toString(),
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);
      isRegisterProgressVisible.value = false;
      if (responseData['status_code'] == 1) {
        onLoginSuccess(responseData);
      } else {
        showToast(responseData['message']);
      }
    }).catchError((onError) {
      isRegisterProgressVisible.value = false;
      showToast("Can't reach to server.");
      print(onError);
    });
  }

  void loginWithEmail(email,password) async {
    isGoogleProgressVisible.value = true;

    Request request = Request(url: urlSignIn, body: {
      'type': "API",
      'email': email.toString(),
      'password': password.toString(),
      'login_with': "EMAIL",
      'device_id': deviceId.toString(),
    });

    request.post().then((value) {
      isGoogleProgressVisible.value = false;
      final responseData = json.decode(value.body);
      if (responseData['status_code'] == 1) {
        onLoginSuccess(responseData);
      } else {
        showToast(responseData['message']);
      }
    }).catchError((onError) {
      isGoogleProgressVisible.value = false;
      showToast("Can't reach to server.");
      print(onError);
    });
  }

  onLoginSuccess(responseData) async {
    await addStringToSF(KEY_IS_USER_ID, responseData['data']['id'].toString());
    userId = responseData['data']['id'].toString();
    modelUser.value= ModelUser.fromJson(responseData['data']);

    print("User Id : "+userId.toString());
    if(responseData['data']['height']==null){
      Get.to(EditProfile(true));
    }else{
      await addBoolToSF(KEY_IS_LOGIN, true);
      isLogin = true;
      Get.offAll(Home(false));
    }

  }


  void savedProfile(name,weight,height,dob,gender,isFirstTime, String referralCode,mobileNumber,address,city,state,photo) async {
    isSavedProgressVisible.value = true;

    Request request = Request(url: urlProfileUpdate, body: {
      'type': "API",
      'user_id': userId.toString(),
      'name': name.toString(),
      'weight': weight.toString(),
      'height': height.toString(),
      'dob': dob.toString(),
      'gender': gender.toString(),
      'referral_code': referralCode.toString(),
      'mobile_number': mobileNumber.toString(),
      'address': address.toString(),
      'city': city.toString(),
      'state': state.toString(),
      'image': photo.toString(),
    });


    request.post().then((value) async {
      isSavedProgressVisible.value = false;
      final responseData = json.decode(value.body);
      showToast(responseData['message']);
      if (responseData['status_code'] == 1) {
        modelUser.value= ModelUser.fromJson(responseData['data']);
        // modelUser.value.name=name.toString();
        // modelUser.value.height=height.toString();
        // modelUser.value.weight=weight.toString();
        // modelUser.value.dob=dob.toString();
        // modelUser.value.gender=gender.toString();
        // modelUser.value.mobileNumber=mobileNumber.toString();
        // modelUser.value.address=address.toString();
        // modelUser.value.city=city.toString();
        // modelUser.value.state=state.toString();
        if(isFirstTime){

          await addBoolToSF(KEY_IS_LOGIN, true);
          isLogin = true;
          Get.offAll(Home(isFirstTime));
        }else{
          modelUser.value=ModelUser.fromJson(responseData['data']);
        }
      }
    }).catchError((onError) {
      isSavedProgressVisible.value = false;
      showToast("Can't reach to server.");
      print(onError);
    });
  }

}