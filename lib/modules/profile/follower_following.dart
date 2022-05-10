import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sup/controller/dashboard_controller.dart';
import 'package:sup/controller/friend_controller.dart';
import 'package:sup/utils/text_style.dart';

class FollowerFollowing extends StatefulWidget {
  final int selectionType;

  FollowerFollowing(this.selectionType);

  @override
  _FollowerFollowingState createState() => _FollowerFollowingState();
}

class _FollowerFollowingState extends State<FollowerFollowing> with SingleTickerProviderStateMixin {

  DashboardController _dashboardController = Get.find();
  FriendController _friendController = Get.find();
  late int _selectedIndex;

  late TabController _controller;


  @override
  void initState() {
    _selectedIndex= widget.selectionType;
    _controller = TabController(length: 2, vsync: this);
    _controller.index=_selectedIndex;
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });



    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.95),
      appBar:AppBar(
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: _controller,
          labelStyle: textStyle14.copyWith(color: Color(0xffEF4723).withOpacity(0.50),letterSpacing: 2,fontWeight: FontWeight.w500),
          unselectedLabelColor: Colors.white,
          labelColor: Color(0xffEF4723).withOpacity(0.60),
          indicatorColor: Color(0xffEF4723).withOpacity(0.50),
          tabs: [

            Tab(text: 'Follower'),
            Tab(text: 'Following'),
          ],
        ),
      ),
      body:Obx(()=> TabBarView(
          controller: _controller,
          children: [
            Container(
                padding: EdgeInsets.all(16),
                color:  Colors.black.withOpacity(0.95),
                child:GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.2 / 2.8,
                  children: List.generate(
                    _friendController.arrOfFollower.length,
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
                                          .arrOfFollower[index]
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
                                            _friendController.setFollowUnFollow(_friendController
                                                .arrOfFollower[
                                            index].id.toString());

                                            Future.delayed(Duration(seconds: 2),(){
                                              _dashboardController.getDashboard();
                                            });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets
                                              .symmetric(
                                              horizontal: 4,
                                              vertical: 2),
                                          child: Text(
                                                   "Remove"
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
                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child: Material(
                              //     color: Colors.transparent,
                              //     type: MaterialType.circle,
                              //     clipBehavior:
                              //     Clip.antiAliasWithSaveLayer,
                              //     child: InkWell(
                              //       onTap: () {
                              //         _friendController
                              //             .arrOfFriend
                              //             .removeAt(index);
                              //       },
                              //       child: Padding(
                              //         padding: EdgeInsets.all(8),
                              //         child: Icon(
                              //           Icons.close,
                              //           color: Colors.white,
                              //           size: 15,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),
            Container(
                padding: EdgeInsets.all(16),
                color:  Colors.black.withOpacity(0.95),
                child:GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.2 / 2.8,
                  children: List.generate(
                    _friendController.arrOfFollowing.length,
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
                                          .arrOfFollowing[index]
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

                                            _friendController.setFollowUnFollow(_friendController
                                                .arrOfFollowing[
                                            index].id.toString());

                                            _friendController.arrOfFollowing.removeAt(index);

                                            Future.delayed(Duration(seconds: 2),(){
                                              _dashboardController.getDashboard();
                                            });


                                        },
                                        child: Padding(
                                          padding: EdgeInsets
                                              .symmetric(
                                              horizontal: 4,
                                              vertical: 2),
                                          child: Text(
                                              "Unfollow"
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
                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child: Material(
                              //     color: Colors.transparent,
                              //     type: MaterialType.circle,
                              //     clipBehavior:
                              //     Clip.antiAliasWithSaveLayer,
                              //     child: InkWell(
                              //       onTap: () {
                              //         _friendController
                              //             .arrOfFriend
                              //             .removeAt(index);
                              //       },
                              //       child: Padding(
                              //         padding: EdgeInsets.all(8),
                              //         child: Icon(
                              //           Icons.close,
                              //           color: Colors.white,
                              //           size: 15,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),

          ]
      )),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
