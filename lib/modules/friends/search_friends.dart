import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sup/controller/friend_controller.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/text_style.dart';

class SearchFriends extends StatefulWidget {
  @override
  _SearchFriendsState createState() => _SearchFriendsState();
}

class _SearchFriendsState extends State<SearchFriends> {

  late TextEditingController textEditingController;

  FriendController _friendController=Get.find();


  @override
  void initState() {
    textEditingController=TextEditingController(text: "");
    super.initState();
  }
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
                  alignment: Alignment.center,
                  child: Text(
                    "Friends",
                    style: textStyle16.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child:Material(
                    type: MaterialType.circle,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (){
                            Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.arrow_back_ios,color: Colors.white,size: Get.width*0.05),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      body: Obx(()=>Container(
        height: Get.height,
        padding: EdgeInsets.all(16),
        color: Colors.black.withOpacity(0.95),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: Get.height * 0.07,
              width: Get.width,
              padding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Image(
                    image: AssetImage("assets/icons/ic_search.png"),
                    width: iconSize - 7,
                    height: iconSize - 7,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(child: TextFormField(
                    cursorColor: Colors.white,
                    style:  textStyle12,
                    controller: textEditingController,
                    onChanged: (value){
                      // textEditingController.text=value;
                      _friendController.findFriend(value.toString());
                    },
                    decoration: InputDecoration(
                      hintText: "Find Friends",
                      hintStyle: textStyle12.copyWith(color: Colors.white.withOpacity(0.80)),
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,


                    ),
                  ))
                ],
              ),
            ),
            Divider(color: Colors.transparent,),
            _friendController.isSearching.value?loader():GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.2 / 2.8,
              children: List.generate(
                _friendController.arrOfSearchList.length,
                    (index) => Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {

                    },
                    child:  Container(
                      width: Get.width * 0.30,
                      height: Get.height * 0.20,
                      decoration: BoxDecoration(
                          color:
                          Colors.white.withOpacity(0.08),
                          borderRadius:
                          BorderRadius.circular(8)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                  Color(0xffEF4723),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/icons/ic_avatar.png"),
                                    radius: 23,
                                  ),
                                ),
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Text(
                                  _friendController
                                      .arrOfSearchList[index]
                                      .name,
                                  style: textStyle11,
                                ),
                                Divider(
                                  color: Colors.white
                                      .withOpacity(0.10),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      if (_friendController
                                          .arrOfSearchList[
                                      index]
                                          .isFollow ==
                                          "0") {
                                        setState(() {
                                          _friendController
                                              .arrOfSearchList[
                                          index]
                                              .isFollow = "1";
                                        });
                                        _friendController.setFollowUnFollow(_friendController
                                            .arrOfSearchList[
                                        index].id.toString());
                                      } else {
                                        setState(() {
                                          _friendController
                                              .arrOfSearchList[
                                          index]
                                              .isFollow = "0";
                                        });
                                        _friendController.setFollowUnFollow(_friendController
                                            .arrOfSearchList[
                                        index].id.toString());
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets
                                          .symmetric(
                                          horizontal: 4,
                                          vertical: 2),
                                      child: Text(
                                          _friendController
                                              .arrOfSearchList[
                                          index]
                                              .isFollow ==
                                              "0"
                                              ? "Follow"
                                              .toUpperCase()
                                              : "Following"
                                              .toUpperCase(),
                                          style: textStyle11.copyWith(
                                              color: Color(
                                                  0xffEF4723)
                                                  .withOpacity(
                                                  0.70),
                                              fontWeight:
                                              FontWeight
                                                  .w600)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
