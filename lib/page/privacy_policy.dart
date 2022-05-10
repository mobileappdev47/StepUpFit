import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sup/modules/login/social_login.dart';
import 'package:sup/modules/profile/edit_profile.dart';
import 'package:sup/utils/constant_key.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/shared_preference.dart';
import 'package:sup/utils/text_style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height+MediaQuery.of(context).padding.top),
          child: Container(
            height: AppBar().preferredSize.height+MediaQuery.of(context).padding.top,
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
                        onTap: (){
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.arrow_back_ios,color: Colors.white,size: Get.width*0.05),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Privacy",
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
          initialUrl: PRIVACY_URL,
        ),
      ),
    );
  }


  _confirmLogout(BuildContext context) {
    return AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              Text(
                "Confirm Logout ?",
                style: TextStyle(fontSize: 18),
              )
            ],
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop('dialog');
            await addBoolToSF(KEY_IS_LOGIN, false);
            Get.offAll(SocialLogin());
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
}
