import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/model/BeanFavKitchen.dart';
import 'package:food_app/model/BeanKitchenDetail.dart';
import 'package:food_app/model/BeanRemoveKitchen.dart';
import 'package:food_app/model/GetCartCount.dart';
import 'package:food_app/model/GetHomeData.dart' as home;
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/AddPackageScreen.dart';
import 'package:food_app/screen/ShippingScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class DetailsScreen extends StatefulWidget {
  home.Data result;
  DetailsScreen(this.result);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  var cuisine = 1;
  var isSelectFood = 1;
  var isSelect = 1;
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  var username = "";
  var email = "";
  var kitchenName = "";
  var foodtype = "";
  var address = "";
  var timing = "";
  bool isLike = false;
  bool isDislike = true;
  var open_status = "";
  var total_review = "";
  var avg_review = "";
  List<Offers> offer = [];
  List<Menu> menu = [];
  TabController _controller;
  ScrollController _Never = ScrollController();
  Future future;
  var cartCount = "";

  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    Future.delayed(Duration.zero, () {
      future = kithchenDetail(context);
      getCartCount(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      body: NestedScrollView(
        controller: _Never,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: false,
              automaticallyImplyLeading: false,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Image.network(widget.result.image,
                        width: double.infinity, fit: BoxFit.cover),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                              padding: EdgeInsets.only(left: 16, top: 26),
                              child: Image.asset(
                                Res.ic_back,
                                color: Colors.white,
                                width: 16,
                                height: 16,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ShippingScreen(address)));
                          },
                          child: Container(
                            height: 45,
                            margin: EdgeInsets.only(top: 36),
                            decoration: BoxDecoration(
                                color: AppConstant.appColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40),
                                )),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16, right: 6),
                                  child: Image.asset(
                                    Res.ic_bascket,
                                    width: 20,
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Text(
                                    cartCount,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(bottom: 6),
                                  child: Image.asset(
                                    Res.ic_chef,
                                    width: 80,
                                    height: 80,
                                  )),
                              Expanded(
                                child: SizedBox(
                                  height: 10,
                                ),
                              ),
                              Stack(
                                children: [
                                  Visibility(
                                    visible: isDislike,
                                    child: InkWell(
                                      onTap: () {
                                        addFavKitchen();
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(top: 1),
                                          child: Image.asset(
                                            Res.ic_like,
                                            width: 70,
                                            height: 70,
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
                                          padding: EdgeInsets.only(
                                              top: 1, right: 16),
                                          child: Image.asset(
                                            Res.ic_hearfille,
                                            width: 30,
                                            height: 30,
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //collapsedHeight: 100,
            ),
          ];
        },
        body: ListView(
          controller: _Never,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Name Of Kitchen",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                kitchenName,
                style: TextStyle(
                    color: Color(0xffA7A8BC),
                    fontSize: 15,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Image.asset(
                      Res.ic_location,
                      width: 16,
                      height: 16,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    address,
                    style: TextStyle(
                        color: Color(0xffA7A8BC),
                        fontSize: 15,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Image.asset(
                      Res.ic_time_circle,
                      width: 16,
                      height: 16,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    timing,
                    style: TextStyle(
                        color: Color(0xffA7A8BC),
                        fontSize: 15,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Open Now",
                    style: TextStyle(
                        color: Color(0xff7EDABF),
                        fontSize: 15,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
              ],
            ),
            Container(
                height: 55,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return getOffer(offer[index]);
                    },
                    itemCount: offer.length)),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Select Meal Plan",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSelect = 1;
                        kithchenDetail(context);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                          color: isSelect == 1
                              ? AppConstant.appColor
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(13)),
                      width: 100,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Weekly",
                          style: TextStyle(
                              color:
                                  isSelect == 1 ? Colors.white : Colors.black,
                              fontSize: 15),
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
                        kithchenDetail(context);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                          color: isSelect == 2
                              ? AppConstant.appColor
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(13)),
                      width: 100,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Monthly",
                          style: TextStyle(
                              color:
                                  isSelect == 2 ? Colors.white : Colors.black,
                              fontSize: 15),
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
                        kithchenDetail(context);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                          color: isSelect == 3
                              ? AppConstant.appColor
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(13)),
                      width: 100,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Trial Meal",
                          style: TextStyle(
                              color:
                                  isSelect == 3 ? Colors.white : Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Meal Type",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, top: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelectFood = 1;
                          kithchenDetail(context);
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
                            margin: EdgeInsets.only(left: 10),
                            height: 50,
                            width: 100,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                ),
                                Image.asset(
                                  Res.ic_veg,
                                  width: 16,
                                  height: 16,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
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
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelectFood = 2;
                          kithchenDetail(context);
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
                            margin: EdgeInsets.only(left: 10),
                            height: 50,
                            width: 150,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 6,
                                ),
                                Image.asset(
                                  Res.ic_chiken,
                                  width: 16,
                                  height: 16,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6),
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
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelectFood = 3;
                          kithchenDetail(context);
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
                            margin: EdgeInsets.only(left: 10),
                            height: 50,
                            width: 100,
                            child: Row(
                              children: [
                                Image.asset(
                                  Res.ic_vegnonveg,
                                  width: 16,
                                  height: 16,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6),
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
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 6),
              child: Text(
                "Menu",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            SizedBox(height: 10),
            // Expanded(
            //   child: menu.isEmpty
            //       ? Container()
            //       : ListView.builder(
            //           shrinkWrap: true,
            //           scrollDirection: Axis.vertical,
            //           physics: BouncingScrollPhysics(),
            //           itemBuilder: (context, index) {
            //             return getBreakfast(menu[index]);
            //           },
            //           itemCount: menu.length,
            //         ),
            // ),
            Container(
              height: 50,
              color: Colors.white,
              child: TabBar(
                labelPadding: EdgeInsets.only(right: 4, left: 0),
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 2.0, color: AppConstant.appColor),
                    insets: EdgeInsets.all(-1)),
                controller: _controller,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Breakfast',
                  ),
                  Tab(
                    text: 'Lunch',
                  ),
                  Tab(
                    text: 'Dinner ',
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: menu.length,
                      // controller: _Never,
                      //physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return getBreakfast(menu[index]);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      // controller: _Never,
                      scrollDirection: Axis.vertical,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return getLunch();
                      },
                      itemCount: 10,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // controller: _Never,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return getLunch();
                      },
                      itemCount: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getOffer(Offers offer) {
    return Container(
      margin: EdgeInsets.only(left: 6, right: 6, top: 16),
      height: 40,
      width: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppConstant.appColor)),
      child: Center(
        child: Text(
          offer.discount.toString() + "% " + offer.offercode,
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }

  Widget getBreakfast(Menu menu) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Image.asset(
                Res.ic_idle,
                width: 60,
                height: 60,
              )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 2),
                  child: Text(
                    menu.itemname,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 16),
                  )),
              Text(
                menu.cuisinetype,
                style: TextStyle(color: Color(0xffA7A8BC)),
              ),
              Text(
                "₹" + menu.itemprice,
                style: TextStyle(color: Color(0xff7EDABF)),
              ),
              RatingBarIndicator(
                rating: 4,
                itemCount: 5,
                itemSize: 16.0,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
            ],
          )),
          Container(
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
                border: Border.all(color: AppConstant.appColor),
                borderRadius: BorderRadius.circular(100)),
            height: 30,
            width: 70,
            child: Center(
              child: Text(
                "Add+",
                style: TextStyle(color: AppConstant.appColor, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getLunch() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 16),
                  child: Image.asset(
                    Res.ic_veg,
                    width: 30,
                    height: 30,
                  )),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 6, top: 10),
                    child: Text(
                      "Package 1",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    )),
              ),
              Text(
                "₹3,000",
                style: TextStyle(color: Color(0xff7EDABF)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 6),
            child: Text(
              "South indian",
              style: TextStyle(
                  color: Color(0xffA7A8BC),
                  fontSize: 13,
                  fontFamily: AppConstant.fontRegular),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Text(
              "Including Saturday, Sunday",
              style: TextStyle(
                  color: Color(0xffA7A8BC),
                  fontSize: 13,
                  fontFamily: AppConstant.fontRegular),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: RatingBarIndicator(
                  rating: 4,
                  itemCount: 5,
                  itemSize: 16.0,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPackageScreen()));
                },
                child: Text(
                  'View Details',
                  style: TextStyle(color: AppConstant.appColor, fontSize: 12),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<KitchenDetail> kithchenDetail(BuildContext context) async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchenid": "2",
        "token": "123456789",
        "meal_plan": isSelect == 1
            ? "weekly"
            : isSelect == 2
                ? "monthly"
                : isSelect == 3
                    ? "trial"
                    : "weekly",
        "meal_type": isSelectFood == 1
            ? "0"
            : isSelectFood == 2
                ? "1"
                : isSelectFood == 2
                    ? "2"
                    : "",
        "meal_for": "1"
      });
      print(from);
      KitchenDetail bean = await ApiProvider().kitchenDetail(from);
      print(bean.data);
      _progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          kitchenName = bean.data[0].kitchenname;
          foodtype = bean.data[0].foodtype;
          address = bean.data[0].address;
          timing = bean.data[0].timing;
          open_status = bean.data[0].openStatus;
          total_review = bean.data[0].totalReview;
          avg_review = bean.data[0].avgReview.toString();
          offer = bean.data[0].offers;

          if (menu != null) {
            menu = bean.data[0].menu;
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
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }
  }

  void addFavKitchen() async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap(
          {"userid": "70", "token": "123456789", "kitchenid": "3"});
      BeanFavKitchen bean = await ApiProvider().favKitchen(from);
      print(bean.data);
      _progressDialog.dismiss();
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
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }
  }

  void removeFav() async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap(
          {"userid": "70", "token": "123456789", "kitchenid": "3"});
      BeanRemoveKitchen bean = await ApiProvider().removeKitchen(from);
      print(bean.data);
      _progressDialog.dismiss();
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
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }
  }

  getCartCount(BuildContext context) async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "user_id": "15",
        "token": "123456789",
      });
      print(from);
      GetCartCount bean = await ApiProvider().getCartCount(from);
      print(bean.data);
      _progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          cartCount = bean.data.cartCount.toString();
        });
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }
  }
}
