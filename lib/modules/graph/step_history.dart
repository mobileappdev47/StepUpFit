import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sup/controller/dashboard_controller.dart';
import 'package:sup/controller/history_controller.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/text_style.dart';

class StepHistory extends StatefulWidget {
  const StepHistory({Key? key}) : super(key: key);

  @override
  _StepHistoryState createState() => _StepHistoryState();
}

class _StepHistoryState extends State<StepHistory> {

  int selectedType=1;
  int selectedSubType=1;
  int selectedMonth=0;
  int year=0;

  HistoryController _historyController=Get.find();

  var arrOfMonth=['JAN',"FEB","MAR","APR","MAY","JUN","JULY","AUG","SEP","OCT","NOV","DEC"];


  @override
  void initState() {
    getCurrentMonth();
    _historyController.viewWeekHistory();
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
                          child: Icon(Icons.arrow_back_ios,color: Colors.white,size: Get.width*0.05,),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Step History",
                    style: textStyle16.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )),
      body: Obx(()=>Container(
        color: Colors.black.withOpacity(0.95),
        padding: EdgeInsets.all(16),
        width: Get.width,
        height: Get.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [

                  Expanded(child: Container(
                    constraints: BoxConstraints(
                        minHeight: Get.height*0.06
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                    decoration: BoxDecoration(
                        color: selectedType==1?Color(0xffEF4723):Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            selectedType=1;
                          });
                        },
                        child: Center(
                          child: Text("Week",style: textStyle12.copyWith(fontWeight: FontWeight.w700),),
                        ),
                      ),
                    ),
                  )),
                  Expanded(child: Container(
                    constraints: BoxConstraints(
                        minHeight: Get.height*0.07
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                    decoration: BoxDecoration(
                        color: selectedType==2?Color(0xffEF4723):Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            selectedType=2;
                            getCurrentMonth();
                            _historyController.viewMonthHistory(selectedMonth,year);
                          });
                        },
                        child: Center(
                          child: Text("Month",style: textStyle12.copyWith(fontWeight: FontWeight.w700),),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Divider(color:Colors.transparent),
            Visibility(
                visible: selectedType==2?true:false,
                child:
                Container(
                  height: Get.height*0.08,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return Material(
                          color: index==selectedMonth-1?Color(0xffEF4723):Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: (){
                              setState(() {
                                selectedMonth=index+1;
                                print("Month  :"+selectedMonth.toString());
                                _historyController.viewMonthHistory(selectedMonth,year);
                              });
                            },
                            child:  Container(
                              constraints: BoxConstraints(
                                minWidth: Get.width * 0.16,
                                minHeight: Get.height * 0.08,
                              ),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    arrOfMonth[index].toUpperCase(),
                                    style: textStyle11.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  // Divider(
                                  //   height: 3,
                                  // ),
                                  // Text(
                                  //   (index + 1).toString().toUpperCase(),
                                  //   style: textStyle12.copyWith(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.w600),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }, separatorBuilder: (context,index){return VerticalDivider(color:Colors.transparent);}, itemCount: arrOfMonth.length),
                )
            ),
            Divider(color:Colors.transparent),
            _historyController.isLoadingHistory.value && _historyController.isLoadingMonthHistory.value?loader():Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: (){
                            setState(() {
                              selectedSubType=1;
                            });
                          },
                          child: Container(
                            decoration:selectedSubType==1? BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Color(0xffEF4723).withOpacity(0.50))
                            ):BoxDecoration(),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "Step",
                                  style:textStyle12.copyWith(
                                      color: selectedSubType==1? Color(0xffEF4723).withOpacity(0.50):Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  _historyController.steps.toString(),
                                  style: textStyle12.copyWith(
                                      color:  Color(0xffEF4723).withOpacity(0.50),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(color:Colors.transparent),
                    Expanded(
                      child: Material(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: (){
                            setState(() {
                              selectedSubType=2;
                            });
                          },
                          child: Container(
                            decoration:selectedSubType==2? BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Color(0xffEF4723).withOpacity(0.50))
                            ):BoxDecoration(),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "Your Coin",
                                  style:textStyle12.copyWith(
                                      color: selectedSubType==2? Color(0xffEF4723).withOpacity(0.50):Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  _historyController.coins.toString(),
                                  style: textStyle12.copyWith(
                                      color:  Color(0xffEF4723).withOpacity(0.50),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(color:Colors.transparent),
                    Expanded(
                      child: Material(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: (){
                            setState(() {
                              selectedSubType=3;
                            });
                          },
                          child: Container(
                            decoration:selectedSubType==3? BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Color(0xffEF4723).withOpacity(0.50))
                            ):BoxDecoration(),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "Calories",
                                  style:textStyle12.copyWith(
                                      color: selectedSubType==3? Color(0xffEF4723).withOpacity(0.50):Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  _historyController.calories.toString(),
                                  style: textStyle12.copyWith(
                                      color:  Color(0xffEF4723).withOpacity(0.50),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                Divider(color:Colors.transparent),
                selectedType==1?GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 2.8,
                  children: List.generate(
                    _historyController.arrOfWeekHistory.length,
                        (index) => Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () {

                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: selectedSubType==1?AssetImage("assets/icons/ic_step.png"):selectedSubType==2?AssetImage("assets/icons/ic_coin.png"):AssetImage("assets/icons/ic_cal.png"),
                                  height: iconSize,
                                  width: iconSize,
                                  fit: BoxFit.contain,
                                  color: Color(0xffEF4723),
                                ),
                                SizedBox(height: 4,),
                                Text(selectedSubType==1?_historyController.arrOfWeekHistory[index].steps!+" Steps":selectedSubType==2?_historyController.arrOfWeekHistory[index].coins!+" Coins":_historyController.arrOfWeekHistory[index].cal!+" Calories",style: textStyle11.copyWith(fontWeight: FontWeight.w700),),
                                SizedBox(height: 4,),
                                Text(_historyController.arrOfWeekHistory[index].dayName!,style: textStyle11.copyWith(fontWeight: FontWeight.w700,color: Colors.white.withOpacity(0.50)),),
                                SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ):GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 2.8,
                  children: List.generate(
                    _historyController.arrOfMonthHistory.length,
                        (index) => Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () {

                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: selectedSubType==1?AssetImage("assets/icons/ic_step.png"):selectedSubType==2?AssetImage("assets/icons/ic_coin.png"):AssetImage("assets/icons/ic_cal.png"),
                                  height: iconSize,
                                  width: iconSize,
                                  color: Color(0xffEF4723),
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: 4,),
                                Text(selectedSubType==1?_historyController.arrOfMonthHistory[index].steps!+" Steps":selectedSubType==2?_historyController.arrOfMonthHistory[index].coins!+" Coins":_historyController.arrOfMonthHistory[index].cal!+" Calories",style: textStyle11.copyWith(fontWeight: FontWeight.w700),),
                                SizedBox(height: 4,),
                                Text(_historyController.arrOfMonthHistory[index].dayName!,style: textStyle11.copyWith(fontWeight: FontWeight.w700,color: Colors.white.withOpacity(0.50)),),
                                SizedBox(height: 4,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }


  getCurrentMonth(){
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    selectedMonth = dateParse.month;
    year = dateParse.year;
    print(year);
  }
}
