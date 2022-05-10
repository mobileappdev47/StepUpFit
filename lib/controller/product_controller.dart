// @dart=2.9

import 'dart:convert';

import 'package:get/get.dart';
import 'package:sup/model/model_product.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/request.dart';

class ProductController extends GetxController{

  var isProductLoading=false.obs;

  // RxList arrOfProduct = [].obs;
  var arrOfProduct = List<ModelProduct>().obs;

  void getProduct() async {

    if(arrOfProduct.isEmpty){
      isProductLoading.value = true;
    }


    Request request = Request(url: urlProduct, body: {
      'type': "API",
      'user_id': userId,
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);
      isProductLoading.value = false;
      if (responseData['status_code'] == 1) {
        arrOfProduct.assignAll((responseData['products'] as List)
            .map((data) => ModelProduct.fromJson(data))
            .toList());
      } else {
        showToast(responseData['message']);
      }
    }).catchError((onError) {
      isProductLoading.value = false;
      showToast("Can't reach to server.");
      print(onError);
    });
  }
}