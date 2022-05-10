import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/text_style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: Get.width * 0.05),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Products",
                    style: textStyle16.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )),
      body: Container(
        height: Get.height,
        color: Colors.black.withOpacity(0.95),
        child: WebView(
          initialUrl: PRODUCTS_URL,
        ),
      ),
    );
  }
}
