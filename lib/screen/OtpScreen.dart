import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/network/ApiProvider.dart';
import 'package:food_app/res.dart';
import 'package:food_app/screen/HomeBaseScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/progress_dialog.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class OtpScreen extends StatefulWidget {
  var number;
  OtpScreen(this.number);

  @override
  State<StatefulWidget> createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  ProgressDialog _progressDialog;

  var code = "+91";
  var otp = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text("Verification",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 20)),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(
                  "Enter six digit code we have sent to\n" + widget.number,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: AppConstant.fontRegular,
                      fontSize: 14),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              PinEntryTextField(
                  fields: 4,
                  showFieldAsBox: false,
                  onSubmit: (String pin) {
                    otp = pin.toString();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Pin"),
                            content: Text('Pin entered is $pin'),
                          );
                        });
                  }),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {},
                child: Center(
                  child: Text("Resend Code",
                      style: TextStyle(
                          fontFamily: AppConstant.fontBold, fontSize: 14)),
                  /*Text("Resend Code in 19 sec", style: TextStyle(color: Colors.black, fontFamily: AppConstant.fontBold, fontSize: 14),),*/
                ),
              ),
              SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: () {
                  if (otp == null) {
                    Utils.showToast("Please enter otp");
                  } else {
                    verifyOTP(otp);
                  }
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 26, right: 26, top: 25, bottom: 10),
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                      color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(13)),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          )),
          physics: BouncingScrollPhysics(),
        )),
        appBar: AppBar(
          centerTitle: false,
          brightness: Brightness.light,
          automaticallyImplyLeading: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void verifyOTP(String otp) async {
    _progressDialog.show();
    try {
      FormData data = FormData.fromMap({
        "mobilenumber": widget.number,
        "token": "123456789",
        "otp": otp,
      });
      BeanVerifyOtp bean = await ApiProvider().verifyOtp(data);
      print(bean.data.toString());
      _progressDialog.dismiss();
      if (bean.status == true) {
        print(
            'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb--------' +
                bean.data.id.toString());
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeBaseScreen()));
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
    } catch (exception) {
      _progressDialog.dismiss();
    }
  }
}
