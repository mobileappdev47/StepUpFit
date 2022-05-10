import 'package:admob_flutter/admob_flutter.dart';
import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sup/controller/dashboard_controller.dart';
import 'package:sup/controller/product_controller.dart';
import 'package:sup/modules/product/product_details.dart';
import 'package:sup/shimmer/shimmer_dummy_page.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/text_style.dart';
import 'package:transparent_image/transparent_image.dart';

class ShopTab extends StatefulWidget {
  @override
  _ShopTabState createState() => _ShopTabState();
}

class _ShopTabState extends State<ShopTab> {

  ProductController _productController = Get.find();
  DashboardController _dashboardController = Get.find();
  var hideShowAppBar = false;

  @override
  void initState() {
    _productController.getProduct();
    super.initState();
  }

  var isAdmobLoad = true;
  var isDisableAds = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => Stack(
            children: [
              Container(
                color: Colors.black,
                height: Get.height,
                width: Get.width,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: NotificationListener<ScrollUpdateNotification>(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: Get.height * 0.06,
                      ),
                      Text(
                    "Health is indeed Wealth",
                    style: textStyle12.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2 / 2.5,
                      children: List.generate(
                        _productController.arrOfProduct.length,
                            (index) => Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {
                              Get.to(
                                  ProductDetails(_productController.arrOfProduct[index]));
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Color(0xff0A1E25).withOpacity(0.60),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Stack(
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(4.0),
                                          child: FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image: STORAGE_URL+ _productController.arrOfProduct[index].image!,
                                            height: 120.0,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        // FadeInImage.memoryNetwork(
                                        //   placeholder: kTransparentImage,
                                        //   image: arrOfImages[nIndex],
                                        //   height: 120.0,
                                        //   fit: BoxFit.cover,
                                        // ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[

                                            Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2, horizontal: 4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.30),
                                                      borderRadius:
                                                      BorderRadius.circular(2)),
                                                  child: RichText(
                                                    maxLines: 1,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: _productController.arrOfProduct[index].brandName,
                                                          style:
                                                          textStyle10.copyWith(
                                                              fontSize: 12,
                                                              color:
                                                              Colors.white,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500))
                                                    ]),
                                                  ),
                                                )),
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
                                            Text(_productController.arrOfProduct[index].coins!,
                                                style: textStyle12.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.w700)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        RichText(
                                          maxLines: 2,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: _productController.arrOfProduct[index].name,
                                                style: textStyle10.copyWith(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.w500))
                                          ]),
                                        ),
                                      ],
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
                      SizedBox(
                        height: Get.height * 0.07,
                      ),
                    ],
              ),
              onNotification: (notification) {
                print(notification.metrics.pixels);
                if (notification.metrics.pixels > 40) {
                  setState(() {
                    hideShowAppBar = true;
                  });
                } else {
                  setState(() {
                    hideShowAppBar = false;
                  });
                }
                return false;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: hideShowAppBar ? Colors.black : Colors.transparent,
            height: AppBar().preferredSize.height,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Product",
                    style: textStyle16.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
                Spacer(),
                // Material(
                //   type: MaterialType.circle,
                //   clipBehavior: Clip.antiAliasWithSaveLayer,
                    //   color: Colors.transparent,
                    //   child: InkWell(
                    //     onTap: (){
                    //       Get.to(NotificationList());
                    //     },
                    //     child: Padding(
                    //       padding: EdgeInsets.all(16),
                    //       child: Image(
                    //         image: AssetImage("assets/icons/ic_notification.png"),
                    //         width: iconSize - 5,
                    //         height: iconSize - 5,
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              isDisableAds
                  ? SizedBox.shrink()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 16, bottom: 2),
                          height: Get.height * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: isAdmobLoad
                              ? AdmobBanner(
                                  adUnitId: _dashboardController
                                      .modelSetting.value.bannerId
                                      .toString(),
                                  adSize: AdmobBannerSize.SMART_BANNER(context),
                                  // listener: (AdmobAdEvent event,
                                  //     Map<String, dynamic> args) {
                                  //   print(event.toString());
                                  //   if (event == AdmobAdEvent.failedToLoad) {
                                  //     setState(() {
                                  //       isAdmobLoad = false;
                                  //     });
                                  //   }
                                  // }
                                )
                              : FacebookBannerAd(
                                  placementId: _dashboardController
                                      .modelSetting.value.fbBannerId,
                                  bannerSize: BannerSize.STANDARD,
                                  listener: (result, value) {
                                    switch (result) {
                                      case BannerAdResult.ERROR:
                                        print("Error: $value");
                                        setState(() {
                                          isDisableAds = true;
                                        });
                                        break;
                                      case BannerAdResult.LOADED:
                                        print("Loaded: $value");
                                        break;
                                      case BannerAdResult.CLICKED:
                                        print("Clicked: $value");
                                        break;
                                      case BannerAdResult.LOGGING_IMPRESSION:
                                        print("Logging Impression: $value");
                                        break;
                                    }
                                  },
                                )),
                    ),
              Container(
                width: Get.width,
                height: Get.height,
                child: _productController.isProductLoading.value
                    ? ShimmerDummyPage()
                    : SizedBox.shrink(),
              )
            ],
          )),
    );
  }
}
