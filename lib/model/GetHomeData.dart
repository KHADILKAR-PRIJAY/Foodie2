class BeanHomeData {
  bool status;
  String message;
  List<Data> data;

  BeanHomeData({this.status, this.message, this.data});

  BeanHomeData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String kitchenname;
  String itemname;
  String address;
  String mealfor;
  String cuisinetype;
  String mealtype;
  String mealplan;
  String price;
  String discount;
  String image;
  String averageRating;
  String totalReview;
  String time;

  Data(
      {this.kitchenname,
        this.itemname,
        this.address,
        this.mealfor,
        this.cuisinetype,
        this.mealtype,
        this.mealplan,
        this.price,
        this.discount,
        this.image,
        this.averageRating,
        this.totalReview,
        this.time});

  Data.fromJson(Map<String, dynamic> json) {
    kitchenname = json['kitchenname'];
    itemname = json['itemname'];
    address = json['address'];
    mealfor = json['mealfor'];
    cuisinetype = json['cuisinetype'];
    mealtype = json['mealtype'];
    mealplan = json['mealplan'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    averageRating = json['average_rating'];
    totalReview = json['total_review'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchenname'] = this.kitchenname;
    data['itemname'] = this.itemname;
    data['address'] = this.address;
    data['mealfor'] = this.mealfor;
    data['cuisinetype'] = this.cuisinetype;
    data['mealtype'] = this.mealtype;
    data['mealplan'] = this.mealplan;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['average_rating'] = this.averageRating;
    data['total_review'] = this.totalReview;
    data['time'] = this.time;
    return data;
  }
}