// @dart=2.9

import 'dart:convert';

import 'package:get/get.dart';
import 'package:sup/controller/dashboard_controller.dart';
import 'package:sup/model/model_friend.dart';
import 'package:sup/model/model_search.dart';
import 'package:sup/model/model_user.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/request.dart';

class FriendController extends GetxController{

  var isContactSyncingWithServer=false.obs;
  var isSearching=false.obs;
  var arrOfFriend=[].obs;
  var arrOfFollower=[].obs;
  var arrOfFollowing=[].obs;
  // var arrOfSearchList=[].obs;
  var arrOfSearchList = List<ModelSearch>().obs;





  void syncFriend(friendList) async {
    Request request = Request(url: urlSyncContact, body: {
      'type': "API",
      'user_id': userId.toString(),
      'contacts': friendList.toString(),
    });

    request.post().then((value) {
      final responseData = json.decode(value.body);
      arrOfFriend.assignAll((responseData['friends'] as List)
          .map((data) => ModelSearch  .fromJson(data))
          .toList());
      print(responseData['message']);
    }).catchError((onError) {
      print(onError.toString());
      print("Can't reach to server.");
      print(onError);
    });
  }

  void setFollowUnFollow(profileId) async {
    Request request = Request(url: urlSetFollower, body: {
      'type': "API",
      'user_id': userId.toString(),
      'profile_id': profileId.toString(),
    });

    request.post().then((value) {
      final responseData = json.decode(value.body);
      if(responseData['status_code'] == 1){
        showToast(responseData['message']);

      }
      print(responseData['message']);
    }).catchError((onError) {
      print(onError.toString());
      print("Can't reach to server.");
      print(onError);
    });
  }

  void getLeaderBoard() async {
    Request request = Request(url: urlGetLeaderboard, body: {
      'type': "API",
      'user_id': userId.toString(),
    });

    request.post().then((value) {
      final responseData = json.decode(value.body);
      arrOfFriend.assignAll((responseData['friends'] as List)
          .map((data) => ModelFriend.fromJson(data))
          .toList());


      print(responseData['message']);
    }).catchError((onError) {
      print(onError.toString());
      print("Can't reach to server.");
      print(onError);
    });
  }

  void findFriend(search) async {

    isSearching.value=true;
    Request request = Request(url: urlFindFriends, body: {
      'type': "API",
      'user_id': userId.toString(),
      'search': search.toString(),
    });

    request.post().then((value) {
      isSearching.value=false;
      final responseData = json.decode(value.body);
      arrOfFriend.assignAll((responseData['friends'] as List)
          .map((data) => ModelFriend.fromJson(data))
          .toList());
      print(responseData['message']);
    }).catchError((onError) {
      isSearching.value=false;
      print(onError.toString());
      print("Can't reach to server.");
      print(onError);
    });
  }

  void updateList(int i) {
    if(i==1){
      for(int i=0;i<arrOfFollowing.length;i++){
        arrOfFollower[i].isFollow.value="1";
      }
    }
  }

}