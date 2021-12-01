class BeanSearchData {
  bool status;
  String message;
  List<Data> data;

  BeanSearchData({this.status, this.message, this.data});

  BeanSearchData.fromJson(Map<String, dynamic> json) {
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
  List<RecentSearch> recentSearch;
  List<Trending> trending;
  List<KitchenRecommandation> kitchenRecommandation;

  Data({this.recentSearch, this.trending, this.kitchenRecommandation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recent_search'] != null) {
      recentSearch = new List<RecentSearch>();
      json['recent_search'].forEach((v) {
        recentSearch.add(new RecentSearch.fromJson(v));
      });
    }
    if (json['trending'] != null) {
      trending = new List<Trending>();
      json['trending'].forEach((v) {
        trending.add(new Trending.fromJson(v));
      });
    }
    if (json['kitchen_recommandation'] != null) {
      kitchenRecommandation = new List<KitchenRecommandation>();
      json['kitchen_recommandation'].forEach((v) {
        kitchenRecommandation.add(new KitchenRecommandation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recentSearch != null) {
      data['recent_search'] = this.recentSearch.map((v) => v.toJson()).toList();
    }
    if (this.trending != null) {
      data['trending'] = this.trending.map((v) => v.toJson()).toList();
    }
    if (this.kitchenRecommandation != null) {
      data['kitchen_recommandation'] =
          this.kitchenRecommandation.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentSearch {
  String keyword;

  RecentSearch({this.keyword});

  RecentSearch.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyword'] = this.keyword;
    return data;
  }
}

class Trending {
  String kitchenname;

  Trending({this.kitchenname});

  Trending.fromJson(Map<String, dynamic> json) {
    kitchenname = json['kitchenname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchenname'] = this.kitchenname;
    return data;
  }
}

class KitchenRecommandation {
  String id;
  String kitchenname;
  String image;
  String foodtype;
  String totalReview;
  int avgReview;
  String time;

  KitchenRecommandation(
      {this.id,
        this.kitchenname,
        this.image,
        this.foodtype,
        this.totalReview,
        this.avgReview,
        this.time});

  KitchenRecommandation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kitchenname = json['kitchenname'];
    image = json['image'];
    foodtype = json['foodtype'];
    totalReview = json['total_review'];
    avgReview = json['avg_review'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kitchenname'] = this.kitchenname;
    data['image'] = this.image;
    data['foodtype'] = this.foodtype;
    data['total_review'] = this.totalReview;
    data['avg_review'] = this.avgReview;
    data['time'] = this.time;
    return data;
  }
}