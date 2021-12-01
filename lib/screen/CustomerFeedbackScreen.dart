import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Constents.dart';


class CustomerFeedbackScreen extends StatefulWidget {
  @override
  CustomerFeedbackScreenState createState() =>CustomerFeedbackScreenState();
}

class CustomerFeedbackScreenState extends State<CustomerFeedbackScreen> {

  var isSelect=-1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text("Customer Feedback",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: AppConstant.fontBold),),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text("You Just Delivered an order!",style: TextStyle(color: AppConstant.appColor,fontSize: 16,fontFamily: AppConstant.fontBold),),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text("Order ID 123456",style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: AppConstant.fontBold),),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text("Akshay K",style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: AppConstant.fontBold),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("Please rat your experience with customer"),
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return getItem(choices[index]);
                    },
                    itemCount: choices.length,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("Tell us more so we can improve",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: AppConstant.fontBold),),
                ),

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){

                          setState(() {
                            isSelect=1;
                          });
                        },
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 10,top:16,right: 10),
                          decoration: BoxDecoration(
                              color: isSelect==1?AppConstant.appColor:Color(0xffF3F6FA),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(
                            child: Text("Customer said thank you",style: TextStyle(fontSize:12,color: isSelect==1?Colors.white:Colors.black,fontFamily: AppConstant.fontRegular),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            isSelect=2;
                          });
                        },
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 10,top:16,right: 10),
                          decoration: BoxDecoration(
                              color: isSelect==2?AppConstant.appColor:Color(0xffF3F6FA),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(
                            child: Text("Customer said thank you",style: TextStyle(color: isSelect==2?Colors.white:Colors.black,fontFamily: AppConstant.fontRegular,fontSize: 12),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){

                          setState(() {
                            isSelect=3;
                          });
                        },
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 10,top:16,right: 10),
                          decoration: BoxDecoration(
                              color: isSelect==3?AppConstant.appColor:Color(0xffF3F6FA),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(
                            child: Text("Customer gave tip",style: TextStyle(fontSize:12,color: isSelect==3?Colors.white:Colors.black,fontFamily: AppConstant.fontRegular),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            isSelect=4;
                          });
                        },
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 10,top:16,right: 10),
                          decoration: BoxDecoration(
                              color: isSelect==4?AppConstant.lightGreen:Color(0xffF3F6FA),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(
                            child: Text("Customer was on time",style: TextStyle(color: isSelect==4?Colors.white:Colors.black,fontFamily: AppConstant.fontRegular,fontSize: 12),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: (){

                        setState(() {
                          isSelect=5;
                        });
                      },
                      child: Container(
                        height: 40,

                        margin: EdgeInsets.only(left: 10,top:16,right: 10),
                        decoration: BoxDecoration(
                            color: isSelect==5?AppConstant.lightGreen:Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Customer gave me water",style: TextStyle(fontSize:12,color: isSelect==5?Colors.white:Colors.black,fontFamily: AppConstant.fontRegular),)),
                        ),
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("Tip received from customer? ",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: AppConstant.fontBold),),
                ),

                Row(
                  children: [
                    Column(
                      children: [

                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Image.asset(Res.ic_like_round,width: 50,height: 50,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text("Yes",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: AppConstant.fontBold),),
                        ),
                      ],
                    ),
                    Column(
                      children: [

                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Image.asset(Res.ic_unlike,width: 50,height: 50,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text("NO",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: AppConstant.fontBold),),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/feedback');
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                          borderRadius: BorderRadius.circular(13)),
                      margin: EdgeInsets.only(top: 25,left: 16,right: 16,bottom: 16),
                      child: Center(
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppConstant.fontBold,
                              fontSize: 12,
                              decoration: TextDecoration.none,
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget getItem(Choice choic) {
    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: Image.asset(choic.image,width: 50,height: 50,),
    );

  }
}
class Choice {
  Choice({this.image});

  String image;
}

List<Choice> choices = <Choice>[
  Choice(image: Res.ic_emoji_one),
  Choice(image: Res.ic_emoji_two),
  Choice(image: Res.ic_emoji_three),
  Choice(image: Res.ic_emoji_four),
  Choice(image: Res.ic_emoji_five),
];
