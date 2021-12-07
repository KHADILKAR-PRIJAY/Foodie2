import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/model/BeanFavKitchen.dart';
import 'package:food_app/model/BeanRemoveKitchen.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';

import 'package:food_app/model/GetHomeData.dart' as home;
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/DetailsScreen.dart';
import 'package:food_app/screen/FilterScreen.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardScreen extends StatefulWidget {
  var mealfor;
  var cuisine;
  var type;
  var min;
  var max;
  var mealPlan;
  DashboardScreen(
      this.mealfor, this.cuisine, this.mealPlan, this.type, this.min, this.max);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BeanVerifyOtp userBean;
  var name = "";
  var menu = "";
  var isSelect = 1;
  var isSelectFood = 1;
  var address = '';
  Future future;
  bool isLike = false;
  bool isDislike = true;
  List<home.Data> list = [];
  ProgressDialog progressDialog;

  void getUser() async {
    userBean = await Utils.getUser();
    name = userBean.data.kitchenname;
    menu = userBean.data.kitchenname;
    address = userBean.data.address;
    setState(() {});
  }

  @override
  void initState() {
    progressDialog = ProgressDialog(context);
    getUser();
    super.initState();
    Future.delayed(Duration.zero, () {
      getHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 50,
                        width: 50,
                        child: Image.asset(Res.ic_boy)),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          Res.ic_logo,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: AppConstant.appColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          )),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Image.asset(
                              Res.ic_bascket,
                              width: 16,
                              height: 16,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 6),
                            child: Text(
                              "0",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        Res.ic_location,
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(address)
                    ],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/searchhistory');
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: Color(0xffF6F6F6),
                            borderRadius: BorderRadius.circular(13)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Image.asset(
                              Res.ic_search,
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              width: 250,
                              child: Text(
                                "search for your location",
                                style: TextStyle(
                                    color: Color(0xffA7A8BC), fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          getFilter();
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 5, top: 16),
                            child: Image.asset(
                              Res.ic_filter,
                              width: 30,
                              height: 30,
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Image.asset(
                  Res.slider,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "What would you like\nto order",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isSelect = 1;
                              getHomeData();
                            });
                          },
                          child: Card(
                            color: isSelect == 1
                                ? AppConstant.appColor
                                : Colors.white,
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 16),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: Container(
                              height: 110,
                              width: 70,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    height: 60,
                                    width: 60,
                                    child: Center(
                                      child: Image.asset(
                                        Res.ic_break,
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Breakfast",
                                    style: TextStyle(
                                        color: isSelect == 1
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 12,
                                        fontFamily: AppConstant.fontRegular),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isSelect = 2;
                              getHomeData();
                            });
                          },
                          child: Card(
                            color: isSelect == 2
                                ? AppConstant.appColor
                                : Colors.white,
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 16),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: Container(
                              height: 110,
                              width: 70,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    height: 60,
                                    width: 60,
                                    child: Center(
                                      child: Image.asset(
                                        Res.ic_break,
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Lunch",
                                    style: TextStyle(
                                        color: isSelect == 2
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 12,
                                        fontFamily: AppConstant.fontRegular),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isSelect = 3;
                              getHomeData();
                            });
                          },
                          child: Card(
                            color: isSelect == 3
                                ? AppConstant.appColor
                                : Colors.white,
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 16),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Container(
                              height: 110,
                              width: 70,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    height: 60,
                                    width: 60,
                                    child: Center(
                                      child: Image.asset(
                                        Res.ic_break,
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Dinner",
                                    style: TextStyle(
                                        color: isSelect == 3
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 12,
                                        fontFamily: AppConstant.fontRegular),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 25, bottom: 8),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSelectFood = 1;
                              getHomeData();
                            });
                          },
                          child: Card(
                            color: isSelectFood == 1
                                ? Color(0xff7EDABF)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Container(
                                height: 50,
                                //width: 100,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                          Res.ic_veg,
                                          width: 16,
                                          height: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Veg",
                                        style: TextStyle(
                                            color: isSelectFood == 1
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 11),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSelectFood = 2;
                              getHomeData();
                            });
                          },
                          child: Card(
                            color: isSelectFood == 2
                                ? Color(0xff7EDABF)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Container(
                                height: 50,
                                // width: 150,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                          Res.ic_chiken,
                                          width: 16,
                                          height: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Non-veg",
                                        style: TextStyle(
                                            color: isSelectFood == 2
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 11),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSelectFood = 3;
                              getHomeData();
                            });
                          },
                          child: Card(
                            color: isSelectFood == 3
                                ? Color(0xff7EDABF)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Container(
                                height: 50,
                                //width: 120,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                          Res.ic_vegnonveg,
                                          width: 16,
                                          height: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Veg/Non-veg",
                                        style: TextStyle(
                                            color: isSelectFood == 3
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 11),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                list.isEmpty
                    ? Container(
                        child: Center(
                          child: Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text("No Item Available")),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return getFoods(list[index]);
                        },
                        itemCount: list.length,
                      )
                /*FutureBuilder<home.BeanHomeData>(
                    future: future,
                    builder: (context, projectSnap) {
                      print(projectSnap);
                      if (projectSnap.connectionState == ConnectionState.done) {
                        var result;
                        if (projectSnap.data != null) {
                          result = projectSnap.data.data;
                          if (result != null) {
                            print(result.length);
                            return
                          }
                        }
                      }
                      return Container(
                          child: Center(
                            child: Text(
                              "No Food Available",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily:
                                  AppConstant.fontBold),
                            ),
                          )
                      );
                    }),*/
                /*    InkWell(
                  onTap: (){
                 */ /*   Navigator.pushNamed(context, '/detail');*/ /*
                    },
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return getFoods();
                    },
                    itemCount: 3,
                  ),
                )*/
              ],
            ),
            physics: BouncingScrollPhysics(),
          ),
        ));
  }

  Widget getFoods(home.Data result) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailsScreen(result)));
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  width: double.infinity,
                  child: Image.network(result.image, fit: BoxFit.cover),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, top: 36),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 40,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          result.averageRating,
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
                Visibility(
                  visible: isDislike,
                  child: InkWell(
                    onTap: () {
                      addFavKitchen();
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            alignment: Alignment.bottomRight,
                            height: 80,
                            width: 80,
                            child: Image.asset(Res.ic_like, fit: BoxFit.cover),
                          ),
                        )),
                  ),
                ),
                Visibility(
                  visible: isLike,
                  child: InkWell(
                    onTap: () {
                      removeFav();
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 16, right: 16),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            alignment: Alignment.bottomRight,
                            height: 30,
                            width: 30,
                            child: Image.asset(Res.ic_hearfille,
                                fit: BoxFit.cover),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Text(
                "Name Of Kitchen",
                style:
                    TextStyle(fontFamily: AppConstant.fontBold, fontSize: 18),
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
                      result.kitchenname,
                      style: TextStyle(fontSize: 12, color: Color(0xffA7A8BC)),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      Res.ic_time,
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text(
                        result.time,
                        style: TextStyle(
                            fontFamily: AppConstant.fontRegular, fontSize: 12),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<home.BeanHomeData> getHomeData() async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "token": "123456789",
        "customer_id": "77",
        "search_location_or_kitchen": "",
        "mealfor": isSelect == 1
            ? "0"
            : isSelect == 2
                ? "1"
                : isSelect == 3
                    ? "2"
                    : "1",
        "cuisinetype": "0",
        "mealtype": isSelectFood == 1
            ? "0"
            : isSelectFood == 2
                ? "1"
                : isSelectFood == 3
                    ? "2"
                    : "0",
        "mealplan": "2",
        "min_price": "",
        "max_price": "",
        "rating": "0",
        "customer_address": "Devpara Rd, Charaniya, Gujarat"
      });
      print("param" + from.toString());
      home.BeanHomeData bean = await ApiProvider().getHomeData(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          if (list != null) {
            list = bean.data;
          } else {
            return Container();
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

  void addFavKitchen() async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap(
          {"userid": "70", "token": "123456789", "kitchenid": "3"});
      BeanFavKitchen bean = await ApiProvider().favKitchen(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          Utils.showToast(bean.message);
          isDislike = false;
          isLike = true;
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

  void removeFav() async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap(
          {"userid": "70", "token": "123456789", "kitchenid": "3"});
      BeanRemoveKitchen bean = await ApiProvider().removeKitchen(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          Utils.showToast(bean.message);
          isDislike = true;
          isLike = false;
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

  getFilter() async {
    var data = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => FilterScreen()));
    if (data != null) {
      getFilterData();
    }
  }

  getFilterData() async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "token": "123456789",
        "customer_id": "77",
        "search_location_or_kitchen": "",
        "mealfor": widget.mealfor == 1
            ? "0"
            : widget.mealfor == 2
                ? "1"
                : widget.mealfor == 3
                    ? "2"
                    : "1",
        "cuisinetype": widget.cuisine == 1
            ? "0"
            : widget.cuisine == 2
                ? "1"
                : widget.cuisine == 3
                    ? "2"
                    : "1",
        "mealtype": "1",
        "mealplan": widget.mealPlan == 1
            ? "0"
            : widget.mealPlan == 2
                ? "1"
                : widget.mealPlan == 3
                    ? "2"
                    : "1",
        "min_price": 0.0,
        "max_price": 100.0,
        "rating": "0",
        "customer_address": "Devpara Rd, Charaniya, Gujarat"
      });
      print("param" + from.toString());
      home.BeanHomeData bean = await ApiProvider().getHomeData(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          if (list != null) {
            list = bean.data;
          } else {
            return Container();
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
