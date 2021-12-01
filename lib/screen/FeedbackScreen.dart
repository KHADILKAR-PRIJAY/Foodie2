import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/Menu/BasePackagescreen.dart';
import 'package:food_app/Menu/OrderScreen.dart';
import 'package:food_app/model/GetFeedback.dart';
import 'package:food_app/model/GetOverAllReview.dart';
import 'package:food_app/model/GetReview.dart' as response;
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'dart:math';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:food_app/utils/progress_dialog.dart';
class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future _future;
  var rating=0.0;
  var review="";
  var excellent=0.0;
  var good=0.0;
  var avrg=0.0;
  var poor=0.0;
  var total="";
  int mult = 5;
  int divide = 100;
  var avgrating="";
  Future future;
  ProgressDialog progressDialog;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      future = getFeedback(context);
      getOverAllReview();
    });

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    progressDialog=ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor:AppConstant.appColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Image.asset(
                        Res.ic_right_arrow,
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 16),
                      child: Text(
                        "Feedback/Reviews",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16,top: 16),
                    child: Image.asset(
                      Res.ic_noti,
                      width: 25,
                      height: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              height: 70,
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Padding(

                          child: Text(avgrating,style: TextStyle(color: Colors.black,fontFamily: AppConstant.fontBold,fontSize: 20),),

                          padding: EdgeInsets.only(top: 16),
                        )
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: RatingBarIndicator(
                        rating: 0,
                        itemCount: 5,
                        itemSize: 16.0,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16,top: 6),
                        child: Text(
                          "Based on "+total+" review",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: AppConstant.fontRegular),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text("Excellent"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: LinearPercentIndicator(
                            width: 200.0,
                            lineHeight: 6.0,
                            percent: excellent,
                            backgroundColor: Colors.grey.shade300,
                            progressColor: Color(0xff7EDABF),
                          ),
                        ),


                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text("Good"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: LinearPercentIndicator(
                            width: 200.0,
                            lineHeight: 6.0,
                            percent: good,
                            backgroundColor: Colors.grey.shade300,
                            progressColor: Color(0xffFDD303),
                          ),
                        ),


                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text("Average"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: LinearPercentIndicator(
                            width: 200.0,
                            lineHeight: 6.0,
                            percent: avrg,
                            backgroundColor: Colors.grey.shade300,
                            progressColor: Color(0xffBEE8FF),
                          ),
                        ),


                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text("Poor"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: LinearPercentIndicator(
                            width: 200.0,
                            lineHeight: 6.0,
                            percent: poor,
                            backgroundColor: Colors.grey.shade300,
                            progressColor: Color(0xffFCA896),
                          ),
                        ),


                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<response.GetReview>(
                          future: future,
                          builder: (context, projectSnap) {
                            print(projectSnap);
                            if (projectSnap.connectionState ==
                                ConnectionState.done) {
                              var result;
                              if (projectSnap.data != null) {
                                result = projectSnap.data.data;
                                if (result != null) {
                                  print(result.length);
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return getItem(result[index]);
                                    },
                                    itemCount: result.length,
                                  );
                                }
                              }
                            }
                            return Container(
                                child: Center(
                                    child: CircularProgressIndicator()
                                ));
                          })
                    ),

                  ],
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget getItem(response.Data result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 16,top: 10),
                child: Image.asset(Res.ic_people,width: 60,height: 60,)
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16,top: 16),
                      child: Text(result.riderName!=null?result.riderName:"xyz",style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: AppConstant.fontBold),),
                    ),

                    
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16,top: 6),
                  child: RatingBarIndicator(
                    rating: double.parse(result.ratting),
                    itemCount: 5,
                    itemSize: 20.0,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16,top: 10),
                  child: Text(result.reviewDescription,style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: AppConstant.fontRegular),),
                ),
                Divider(
                  color: Colors.grey.shade400,
                ),
              ],
            ),

          ],

        )
      ],
    );


  }

  Future<response.GetReview> getFeedback(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "user_id": "15",
        "token": "123456789"
      });
      response.GetReview bean = await ApiProvider().getFeedback(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          if(bean.data!=null){

          }
        });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  getImage(result) {
    if(result.customerPhoto.toString().isEmpty){
      return   ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(Res.ic_people,fit:BoxFit.cover,width: 60,height: 60));

    }else{
      return  ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child:
          Image.network(AppConstant.ImageUrl+result.customerPhoto,width: 60,height: 60,fit: BoxFit.cover,));
    }

  }

  Future<GetOverAllReview> getOverAllReview() async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "user_id": "15",
        "token": "123456789"
      });
      GetOverAllReview bean = await ApiProvider().getoverallreview(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          if(bean.data!=null){
            excellent=(int.parse(bean.data[0].excellent)*5/100);
            avrg=(int.parse(bean.data[0].average)*5/100);
            good=(int.parse(bean.data[0].good)*5/100);
            poor=(int.parse(bean.data[0].poor)*5/100);
            total=bean.data[0].totalReview;
            avgrating=bean.data[0].avgRattings.toString();
         /*   "avg_rattings": 0,
          "total_review": "4",
          "excellent": "1",
          "good": "1",
          "average": "1",
          "poor": "0"*/

          }
        });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }

  }



}
