import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/model/model_product.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/sabt.dart';
import 'package:sup/utils/text_style.dart';

class ProductDetails extends StatefulWidget {

  final ModelProduct modelProduct;
  ProductDetails(this.modelProduct);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var hideShowAppBar = false;
  
  int productCoins=0;
  int userCoins=0;
  
  LoginController _loginController=Get.find();
  
  @override
  void initState() {
    productCoins=int.parse(widget.modelProduct.coins.toString());
    userCoins=int.parse(_loginController.modelUser.value.coins.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));

    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    brightness: Brightness.dark,
                    title: Text(
                      widget.modelProduct.name.toString(),
                      style: textStyle12.copyWith(color: Colors.white),
                    ),
                    expandedHeight: 250,
                    elevation: 0,
                    pinned: true,
                    floating: true,
                    backgroundColor: Colors.black,
                    leading: Container(),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Container(
                          color: Colors.white,
                          height: 240,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image(
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  STORAGE_URL+widget.modelProduct.image.toString(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(

                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                 Expanded(child:  FlatButton(onPressed: (){}, child: RichText(
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   text: TextSpan(

                                   children: [
                                     TextSpan(text: widget.modelProduct.brandName,style: textStyle10.copyWith(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500))
                                   ]),
                                 ),color: Colors.grey.withOpacity(0.20),)),

                                  Expanded(child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Image(
                                      image: AssetImage(
                                          "assets/icons/ic_coin.png"),
                                      height: iconSize - 10,
                                      width: iconSize - 10,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(widget.modelProduct.coins.toString(),
                                        style: textStyle12.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        width: 16,
                                      ),
                                  ],))
                                ],
                              ),
                              SizedBox(height: 16,),
                              RichText(
                                maxLines: 2,
                                text: TextSpan(children: [
                                  TextSpan(text: "Product Name",style: textStyle10.copyWith(fontSize:14,color: Colors.white,fontWeight: FontWeight.w500))
                                ]),
                              ),

                              Html(data: widget.modelProduct.shortDescription,
                                  style: {
                                    "body": Style(
                                        fontFamily: "Poppins",
                                        color: Colors.white),
                                  }
                              ),
                              Html(data: widget.modelProduct.description,
                                  style: {
                                "body": Style(
                                    fontFamily: "Poppins",
                                    color: Colors.white),
                              }
                              ),
                              Html(data: widget.modelProduct.aboutBrand,
                                  style: {
                                    "body": Style(
                                        fontFamily: "Poppins",
                                        color: Colors.white),
                                  }
                              ),
                              SizedBox(height: Get.height*0.10,)
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                color: hideShowAppBar ? Colors.black : Colors.transparent,
                height: AppBar().preferredSize.height,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image(
                        image: AssetImage("assets/icons/ic_back.png"),
                        width: iconSize - 8,
                        height: iconSize - 8,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Spacer(),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Image(
                    //     image: AssetImage("assets/icons/ic_setting.png"),
                    //     width: iconSize - 5,
                    //     height: iconSize - 5,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 16,
                    // )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.black,
                    child: Material(
                      color: userCoins>productCoins?Color(0xffEF4723):Colors.white.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(4),
                      child: InkWell(
                        onTap: (){
                          if(userCoins<productCoins){
                            showToast("Your coin balance is low.");
                          }
                        },
                        child: Container(
                          height: Get.height * 0.07,
                          child: Center(
                            child: Text("Redeem Now",style: textStyle12.copyWith(color: Colors.white,fontWeight: FontWeight.w700),),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
