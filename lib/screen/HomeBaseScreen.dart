import 'package:flutter/material.dart';
import 'package:food_app/Menu/Profile.dart';
import 'package:food_app/Menu/OrderScreen.dart';
import 'package:food_app/model/BeanSignUp.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';

import 'package:food_app/res.dart';
import 'package:food_app/screen/AccountScreen.dart';
import 'package:food_app/screen/CutomerChatScreen.dart';
import 'package:food_app/screen/DashboardScreen.dart';
import 'package:food_app/screen/FeedbackScreen.dart';
import 'package:food_app/screen/MenuScreen.dart';
import 'package:food_app/screen/OfferManagementScreen.dart';
import 'package:food_app/screen/PaymentScreen.dart';
import 'package:food_app/screen/TrackDeliveryScreen.dart';
import 'package:food_app/utils/Constents.dart';
import 'package:food_app/utils/PrefManager.dart';
import 'package:food_app/utils/Utils.dart';

class HomeBaseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeBaseScreenState();
}

class HomeBaseScreenState extends State<HomeBaseScreen> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    DashboardScreen(0, 0, 0, 0, 0, 0),
    OrderScreen(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawers(),
        body: Center(
          child: _children.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                backgroundColor: Colors.black,
                showSelectedLabels: true,
                unselectedItemColor: Colors.white,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/images/ic_order.png'),
                    ),
                    title: Text(
                      'Order',
                      style: TextStyle(
                        fontFamily: AppConstant.fontRegular,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/images/ic_order_history.png'),
                    ),
                    title: Text(
                      'Orders History',
                      style: TextStyle(
                          fontFamily: AppConstant.fontRegular, fontSize: 12),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/images/ic_profile.png'),
                    ),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                          fontFamily: AppConstant.fontRegular, fontSize: 12),
                    ),
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Color(0xffFFA451),
                onTap: _onItemTapped,
              ),
            )
          ],
        ));
  }
}

class MyDrawers extends StatefulWidget {
  @override
  MyDrawersState createState() => MyDrawersState();
}

class MyDrawersState extends State<MyDrawers> {
  BeanVerifyOtp userBean;
  var name = "";
  var address = "";
  var number = "";
  var email = "";

  void getUser() async {
    userBean = await Utils.getUser();
    setState(() {
      name = userBean.data.kitchenname;
      address = userBean.data.address;
      email = userBean.data.email;
      //print();
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          width: 300,
          child: Drawer(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 20),
                    child: Image.asset(
                      Res.ic_people,
                      width: 90,
                      height: 90,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 16),
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppConstant.fontBold,
                            fontSize: 18),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 5),
                      child: Text(
                        address,
                        style: TextStyle(
                            fontFamily: AppConstant.fontRegular,
                            fontSize: 14,
                            color: Colors.grey),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 5),
                      child: Text(
                        email,
                        style: TextStyle(
                            fontFamily: AppConstant.fontRegular,
                            fontSize: 14,
                            color: Colors.grey),
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_dashboard,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, top: 5),
                              child: Text(
                                'DASHBOARD',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(builder: (_) => FeedbackScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_feedback,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'FEEDBACK/REVIEW',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(builder: (_) => OrderScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_order,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'ORDERS HISTORY',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_payment,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'PAYMENT',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_account,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'ACCOUNT',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _ackAlert(context);
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                          color: Color(0xffFFA451),
                          borderRadius: BorderRadius.circular(60)),
                      margin: EdgeInsets.only(left: 16, top: 30),
                      child: Row(
                        children: [
                          Padding(
                            child: Image.asset(
                              Res.ic_logout,
                              color: Colors.white,
                              width: 25,
                              height: 25,
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'LOGOUT',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              physics: BouncingScrollPhysics(),
            ),
          ),
        ));
  }
}

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout!'),
        content: const Text('Are you sure want to logout'),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              PrefManager.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/loginSignUp', (Route<dynamic> route) => false);
            },
          )
        ],
      );
    },
  );
}
