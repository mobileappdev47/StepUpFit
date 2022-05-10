import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sup/controller/dashboard_controller.dart';
import 'package:sup/page/shop_products.dart';
import 'package:sup/shimmer/shimmer_view_transaction.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/text_style.dart';

class ViewTransaction extends StatefulWidget {
  const ViewTransaction({Key? key}) : super(key: key);

  @override
  _ViewTransactionState createState() => _ViewTransactionState();
}

class _ViewTransactionState extends State<ViewTransaction> {

  DashboardController _dashboardController = Get.find();

  var isAdmobLoad = true;
  var isDisableAds = false;

  @override
  void initState() {
    _dashboardController.viewTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  alignment: Alignment.center,
                  child: Text(
                    "Transaction History",
                    style: textStyle16.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    type: MaterialType.circle,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: Get.width * 0.05),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      body: Obx(()=>_dashboardController.isViewTransactionLoading.value?ShimmerViewTransaction():Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Divider(color:Colors.transparent),
              Divider(color:Colors.transparent),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/icons/ic_coin.png"),
                    height: iconSize,
                    width: iconSize,
                    fit: BoxFit.contain,
                  ),
                  VerticalDivider(
                    width: 4,
                  ),
                  Text(
                    _dashboardController.currentBalance.toString(),
                    style: textStyle16.copyWith(
                        color: Color(0xffEF4723), fontWeight: FontWeight.w700),
                  )
                ],
              ),
              Center(
                child: Text(
                  "Coin Balance",
                  style: textStyle12.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              Divider(color:Colors.transparent),
              Divider(color:Colors.transparent),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Earned Coins",
                          style: textStyle12.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/icons/ic_coin.png"),
                              height: iconSize - 5,
                              width: iconSize - 5,
                              fit: BoxFit.contain,
                            ),
                            VerticalDivider(
                              width: 4,
                            ),
                            Text(
                              _dashboardController.totalBalance.toString(),
                              style: textStyle14.copyWith(
                                  color: Color(0xffEF4723),
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white.withOpacity(0.40),
                    width: 1,
                    height: 50,
                  ),
                  Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.to(ProductList());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Spent Coins",
                                  style: textStyle12.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          "assets/icons/ic_coin.png"),
                                      height: iconSize - 5,
                                      width: iconSize - 5,
                                      fit: BoxFit.contain,
                                    ),
                                    VerticalDivider(
                                      width: 4,
                                    ),
                                    Text(
                                      _dashboardController.spentBalance
                                          .toString(),
                                      style: textStyle14.copyWith(
                                          color: Color(0xffEF4723),
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
              Divider(color:Colors.transparent),
              Divider(color:Colors.transparent),
              Container(
                color: Colors.white.withOpacity(0.10),
                width: Get.width,
                height: 1.5,
              ),
              Divider(color:Colors.transparent),
              Divider(color:Colors.transparent),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "All Transactions",
                  style: textStyle13.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              Divider(color:Colors.transparent),
              Divider(color:Colors.transparent),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          leading: SizedBox(
                            width: Get.width*0.10,
                            height: Get.width*0.10,
                            child: Center(
                              child: Image(
                                image: AssetImage(_dashboardController.arrOfTransaction[index].transactionType=="Walking"?"assets/icons/ic_step.png":_dashboardController.arrOfTransaction[index].transactionType=="Reward"?"assets/icons/ic_reward.png":"assets/icons/ic_coin.png"),
                                height: iconSize ,
                                width: iconSize ,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          title: Text(_dashboardController.arrOfTransaction[index].transactionType,style: textStyle12.copyWith(color: Colors.white.withOpacity(0.50)),),
                          subtitle: Row(
                            children: [
                              Text("+",style: textStyle12,),
                              SizedBox(width: 4,),
                              Image(
                                image: AssetImage("assets/icons/ic_coin.png"),
                                height: iconSize - 10,
                                width: iconSize - 10,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: 4,),
                              Text(
                                _dashboardController.arrOfTransaction[index].coin,
                                style: textStyle12.copyWith(
                                    color: Colors.white.withOpacity(0.60), fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          trailing: Text(_dashboardController.arrOfTransaction[index].displayDate.toString(),style: textStyle11,),
                        ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(color: Colors.transparent);
                          },
                          itemCount:
                              _dashboardController.arrOfTransaction.length),
                    ),
                    Container(
                      height: Get.height * 0.10,
                    )
                  ],
                ),
                // isDisableAds
                //     ? SizedBox.shrink()
                //     : Align(
                //         alignment: Alignment.bottomCenter,
                //         child: Container(
                //             margin: EdgeInsets.only(
                //                 left: 10, right: 10, top: 16, bottom: 2),
                //             height: Get.height * 0.07,
                //             decoration: BoxDecoration(
                //               color: Colors.transparent,
                //               borderRadius: BorderRadius.circular(4),
                //             ),
                //             child: isAdmobLoad
                //                 ? AdmobBanner(
                //                     adUnitId: _dashboardController
                //                         .modelSetting.value.bannerId
                //                         .toString(),
                //                     adSize: AdmobBannerSize.BANNER,
                //                     listener: (AdmobAdEvent event,
                //                         Map<String, dynamic> args) {
                //                       print(event.toString());
                //                       if (event == AdmobAdEvent.failedToLoad) {
                //                         setState(() {
                //                           isAdmobLoad = false;
                //                         });
                //                       }
                //                     })
                //                 : FacebookBannerAd(
                //                     placementId: _dashboardController
                //                         .modelSetting.value.fbBannerId,
                //                     bannerSize: BannerSize.STANDARD,
                //                     listener: (result, value) {
                //                       switch (result) {
                //                         case BannerAdResult.ERROR:
                //                           print("Error: $value");
                //                           setState(() {
                //                             isDisableAds = true;
                //                           });
                //                           break;
                //                         case BannerAdResult.LOADED:
                //                           print("Loaded: $value");
                //                           break;
                //                         case BannerAdResult.CLICKED:
                //                           print("Clicked: $value");
                //                           break;
                //                         case BannerAdResult.LOGGING_IMPRESSION:
                //                           print("Logging Impression: $value");
                //                           break;
                //                       }
                //                     },
                //                   )),
                //       )
              ],
            )),
    );
  }
}
