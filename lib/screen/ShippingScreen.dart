import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/model/BeanApplyPromo.dart';
import 'package:food_app/model/GetCartDetail.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/HttpException.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';

class ShippingScreen extends StatefulWidget {
  var address;
  ShippingScreen(this.address);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var isSelected = 0;
  Future future;
  var distancekm = "";
  var total_amount = "";
  var applyPromoController = TextEditingController();
  var tax_amount = "";
  ProgressDialog _progressDialog;
  var delivery_charge = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      future = getCartDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 26,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Image.asset(
                                Res.ic_back,
                                width: 16,
                                height: 16,
                              )),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "Your Location",
                                  style: TextStyle(color: Color(0xffA7A8BC)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  widget.address,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                        /*  Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Text(
                            "Change",
                            style: TextStyle(color: AppConstant.appColor),
                          ),
                        ),*/
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: applyPromoController,
                              decoration:
                                  InputDecoration(hintText: 'Apply Offer'),
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              if (applyPromoController.text
                                  .toString()
                                  .isEmpty) {
                                Utils.showToast("Please enter promo");
                              } else {
                                applyPromo();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppConstant.appColor,
                                  borderRadius: BorderRadius.circular(13)),
                              height: 40,
                              width: 80,
                              child: Center(
                                child: Text(
                                  "Apply",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        "Services",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<GetCartDetail>(
                              future: future,
                              builder: (context, projectSnap) {
                                print(projectSnap);
                                if (projectSnap.connectionState ==
                                    ConnectionState.done) {
                                  var result;
                                  if (projectSnap.data != null) {
                                    result = projectSnap.data.data.cartItems;
                                    if (result != null) {
                                      print(result.length);
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return getServices(result[index]);
                                        },
                                        itemCount: result.length,
                                      );
                                    }
                                  }
                                }
                                return Container(
                                    child: Center(child: Text('No Data')));
                              }),
                          SizedBox(
                            height: 16,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                Res.ic_veg,
                                width: 16,
                                height: 16,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    "Package 1",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppConstant.fontBold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "₹3,000",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "South indian",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontRegular,
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "including ,saturday,sunday",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontRegular,
                                  fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "11 Apr to  March 2021",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontRegular,
                                  fontSize: 13),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Taxes",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppConstant.fontRegular,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "₹" + tax_amount,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 16),
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
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Delivery Charge",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppConstant.fontRegular,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "₹" + delivery_charge,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 16),
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
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Coupon",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppConstant.fontRegular,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "₹0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 16),
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
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Subtotal",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppConstant.fontBold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "₹" + total_amount,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Ordering for",
                                    style: TextStyle(
                                        color: Color(0xffA7A8BC),
                                        fontFamily: AppConstant.fontBold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              /*    Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "Change",
                                  style: TextStyle(
                                      color: AppConstant.appColor,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 16),
                                ),
                              ),*/
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Prepared joshi, +91997777979",
                              style: TextStyle(
                                  color: Color(0xffA7A8BC),
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 80)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/payment');
                    },
                    child: Material(
                      elevation: 7,
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(13),
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "ADD PAYMENT DETAILS",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                Res.ic_next_arrow,
                                width: 17,
                                height: 17,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<GetCartDetail> getCartDetail() async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "token": "123456789",
        "user_id": "15",
      });
      print("param" + from.toString());
      GetCartDetail bean = await ApiProvider().getCartDetail(from);
      print(bean.data);
      _progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {});
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

  Widget getServices(CartItems result) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: result.menuimage.isEmpty
                  ? Image.asset(
                      Res.ic_poha,
                      width: 60,
                      height: 60,
                    )
                  : Image.network(
                      result.menuimage,
                      width: 60,
                      height: 60,
                    )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    result.itemName,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 16),
                  )),
              Text(
                result.cuisinetype,
                style: TextStyle(color: Color(0xffA7A8BC)),
              ),
              Text(
                "₹" + result.price,
                style: TextStyle(color: Color(0xff7EDABF)),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      result.deliveryDate +
                          "/" +
                          result.deliveryFromtime +
                          "/" +
                          result.deliveryTotime,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      "₹" + result.price,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          )),
          Container(
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                  color: AppConstant.appColor,
                  borderRadius: BorderRadius.circular(100)),
              height: 30,
              width: 70,
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "-",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "2",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "+",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Future<BeanApplyPromo> applyPromo() async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": "2",
        "token": "123456789",
        "order_amount": "700",
        "coupon_code": applyPromoController.text.toString()
      });
      BeanApplyPromo bean = await ApiProvider().applyPromo(from);
      print(bean.data);
      _progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {});
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
