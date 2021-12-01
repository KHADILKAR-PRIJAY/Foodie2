import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/model/BeanClearRecentsearch.dart';
import 'package:food_app/model/BeanSearchData.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SearchHistoryScreen extends StatefulWidget {
  @override
  SearchHistoryScreenState createState() => SearchHistoryScreenState();
}

class SearchHistoryScreenState extends State<SearchHistoryScreen> {
  ProgressDialog progressDialog;
  Future future;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      future = getSearchData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog((context));
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 10, right: 16, top: 26),
                  decoration: BoxDecoration(
                      color: Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(13)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Image.asset(
                        Res.ic_back,
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                              hintText: 'Search for your location or kitchen',
                              hintStyle: TextStyle(
                                  color: Color(0xffA7A8BC), fontSize: 12)),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          "Recently Searched",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        clearSearch();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                        child: Text(
                          "Clear",
                          style: TextStyle(
                              color: AppConstant.appColor, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                    height: 70,
                    child: FutureBuilder<BeanSearchData>(
                        future: future,
                        builder: (context, projectSnap) {
                          print(projectSnap);
                          if (projectSnap.connectionState ==
                              ConnectionState.done) {
                            var result;
                            if (projectSnap.data != null) {
                              result = projectSnap.data.data[0].recentSearch;
                              if (result != null) {
                                print(result.length);
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return getSearchItem(result[index]);
                                  },
                                  itemCount: result.length,
                                );
                              }
                            }
                          }
                          return Container(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        })),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Trending Near you",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Container(
                    height: 70,
                    child: FutureBuilder<BeanSearchData>(
                        future: future,
                        builder: (context, projectSnap) {
                          print(projectSnap);
                          if (projectSnap.connectionState ==
                              ConnectionState.done) {
                            var result;
                            if (projectSnap.data != null) {
                              result = projectSnap.data.data[0].trending;
                              if (result != null) {
                                print(result.length);
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return getTrending(result[index]);
                                  },
                                  itemCount: result.length,
                                );
                              }
                            }
                          }
                          return Container(child: Center(child: Container()));
                        })),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Kitchen recommendations for you",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Container(
                    height: 250,
                    child: FutureBuilder<BeanSearchData>(
                        future: future,
                        builder: (context, projectSnap) {
                          print(projectSnap);
                          if (projectSnap.connectionState ==
                              ConnectionState.done) {
                            var result;
                            if (projectSnap.data != null) {
                              result = projectSnap
                                  .data.data[0].kitchenRecommandation;
                              if (result != null) {
                                print(result.length);
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return getRecommended(result[index]);
                                  },
                                  itemCount: result.length,
                                );
                              }
                            }
                          }
                          return Container(child: Center(child: Container()));
                        })),
              ],
            ),
          ),
        ));
  }

  Widget getRecommended(KitchenRecommandation result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
              height: 150,
              margin: EdgeInsets.only(top: 16, left: 16, bottom: 16),
              child: Image.network(result.image, fit: BoxFit.cover),
            ),
            Container(
              margin: EdgeInsets.only(left: 26, top: 26),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              width: 100,
              height: 30,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      result.avgReview.toString(),
                      style: TextStyle(
                          fontSize: 12, fontFamily: AppConstant.fontBold),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  RatingBarIndicator(
                    rating: 1,
                    itemCount: 1,
                    itemSize: 15.0,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Text(
                      result.totalReview,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: AppConstant.fontBold,
                          color: Color(0xffA7A8BC)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 1),
          child: Text(
            result.kitchenname,
            style: TextStyle(fontFamily: AppConstant.fontBold, fontSize: 16),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 25,
              width: 80,
              margin: EdgeInsets.only(left: 16, top: 6),
              decoration: BoxDecoration(
                  color: Color(0xffEEEEEE),
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Text(
                  result.foodtype,
                  style: TextStyle(fontSize: 12, color: Color(0xffA7A8BC)),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 6,
                ),
                Image.asset(
                  Res.ic_time,
                  width: 16,
                  height: 16,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  result.time,
                  style: TextStyle(
                      fontFamily: AppConstant.fontRegular, fontSize: 12),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Future<BeanSearchData> getSearchData(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({"userid": "62", "token": "123456789"});
      BeanSearchData bean = await ApiProvider().searchData(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {});
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

  Widget getSearchItem(RecentSearch result) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xffF3F6FA),
              borderRadius: BorderRadius.circular(13)),
          height: 40,
          width: 100,
          margin: EdgeInsets.only(left: 16, top: 16),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                Res.ic_time,
                width: 15,
                height: 15,
                color: Color(0xffA7A8BC),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  result.keyword,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppConstant.fontRegular),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget getTrending(Trending result) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, top: 16),
          decoration: BoxDecoration(
              color: Color(0xffF3F6FA),
              borderRadius: BorderRadius.circular(13)),
          height: 40,
          width: 140,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                Res.ic_up_arrow,
                width: 15,
                height: 15,
                color: Color(0xffA7A8BC),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  result.kitchenname,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppConstant.fontRegular),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void clearSearch() async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({"userid": "70", "token": "123456789"});
      BeanClearRecentSearch bean = await ApiProvider().clearRecentSearch(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          future = getSearchData(context);
        });
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }
}
