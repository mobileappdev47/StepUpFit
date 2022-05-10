import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/text_style.dart';

class LevelUnderStanding extends StatefulWidget {
  const LevelUnderStanding({Key? key}) : super(key: key);

  @override
  _LevelUnderStandingState createState() => _LevelUnderStandingState();
}

class _LevelUnderStandingState extends State<LevelUnderStanding> {
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
                    "Understanding Levels",
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
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                            size: Get.width*0.05
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      body: ListView(
        shrinkWrap: true,
        children: [
          Divider(color:Colors.transparent),
          ListTile(

            leading:Container(
              width: Get.width*0.10,
              height: Get.width*0.10,

              decoration: BoxDecoration(
                  color: Color(0xffEF4723),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child:Text(
                  "1",
                  style: textStyle15.copyWith(
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            title: Text("The higher your Level, the more you earn",style: textStyle12.copyWith(fontWeight: FontWeight.w500),),
            subtitle: Text("your step up fit level determines how many coins you can earn a day.",style: textStyle11.copyWith(color: Colors.white.withOpacity(0.60))),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            color: Colors.white.withOpacity(0.08),
            height: 1.5,
          ),
          ListTile(

            leading:Container(
              width: Get.width*0.10,
              height: Get.width*0.10,

              decoration: BoxDecoration(
                  color: Color(0xffEF4723),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child:Text(
                  "2",
                  style: textStyle15.copyWith(
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            title: Row(
              children: [
                Container(
                  width: Get.width*0.07,
                  height: Get.width*0.07,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffEF4723)
                  ),
                  child: Center(child: Icon(Icons.star_border,color: Colors.white,size: 15,),),
                ),Text("= Daily Limit",style: textStyle12.copyWith(fontWeight: FontWeight.w500),)
              ],
            ),
            subtitle: Text("Each Leve; has a Daily Limit - this is the max coins you can earn a day.",style: textStyle11.copyWith(color: Colors.white.withOpacity(0.60))),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            color: Colors.white.withOpacity(0.08),
            height: 1.5,
          ),
          ListTile(

            leading:Container(
              width: Get.width*0.10,
              height: Get.width*0.10,

              decoration: BoxDecoration(
                  color: Color(0xffEF4723),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child:Text(
                  "3",
                  style: textStyle15.copyWith(
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            title: Row(
              children: [
                Container(
                  width: Get.width*0.07,
                  height: Get.width*0.07,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEF4723)
                  ),
                  child: Center(child: Icon(Icons.star_border,color: Colors.white,size: 15,),),
                ),Container(
                  width: Get.width*0.07,
                  height: Get.width*0.07,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEF4723)
                  ),
                  child: Center(child: Icon(Icons.star_border,color: Colors.white,size: 15,),),
                ),Container(
                  width: Get.width*0.07,
                  height: Get.width*0.07,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEF4723)
                  ),
                  child: Center(child: Icon(Icons.star_border,color: Colors.white,size: 15,),),
                ),Text("= Level Up",style: textStyle12.copyWith(fontWeight: FontWeight.w500),)
              ],
            ),
            subtitle: Text("Reach the Daly, 3 Days in a row Level Up (Level 2 to 4)",style: textStyle11.copyWith(color: Colors.white.withOpacity(0.60))),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            color: Colors.white.withOpacity(0.08),
            height: 1.5,
          ),
          ListTile(
            leading:Container(
              width: Get.width*0.10,
              height: Get.width*0.10,
              decoration: BoxDecoration(
                  color: Color(0xffEF4723),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child:Text(
                  "4",
                  style: textStyle15.copyWith(
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            title: Row(
              children: [
                Container(
                  width: Get.width*0.07,
                  height: Get.width*0.07,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEF4723)
                  ),
                  child: Center(child: Icon(Icons.check,color: Colors.white,size: 15,),),
                ),Text("= Safe Point",style: textStyle12.copyWith(fontWeight: FontWeight.w500),)
              ],
            ),
            subtitle: Text("Each Level has a Safe Point - this is the minimum coins you must earn to stay on your level.",style: textStyle11.copyWith(color: Colors.white.withOpacity(0.60))),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            color: Colors.white.withOpacity(0.08),
            height: 1.5,
          ),

          ListTile(
            leading:Container(
              width: Get.width*0.10,
              height: Get.width*0.10,
              decoration: BoxDecoration(
                  color: Color(0xffEF4723),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child:Text(
                  "5",
                  style: textStyle15.copyWith(
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            title: Row(
              children: [
                Container(
                  width: Get.width*0.07,
                  height: Get.width*0.07,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow
                  ),
                  child: Center(child: Icon(Icons.warning_amber_outlined,color: Colors.black,size: 15,),),
                ),Text("= Flag",style: textStyle12.copyWith(fontWeight: FontWeight.w500),)
              ],
            ),
            subtitle: Text("If you MISS the safe point for a day, you get a Flag",style: textStyle11.copyWith(color: Colors.white.withOpacity(0.60))),
          ),
        ],
      ),
    );
  }
}
