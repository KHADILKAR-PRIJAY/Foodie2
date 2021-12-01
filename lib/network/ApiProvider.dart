import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:food_app/Menu/menu_bean.dart';
import 'package:food_app/model/AddOffer.dart';
import 'package:food_app/model/BeanAddCard.dart';
import 'package:food_app/model/BeanAddPackage.dart';
import 'package:food_app/model/BeanApplyPromo.dart';
import 'package:food_app/model/BeanClearRecentsearch.dart';
import 'package:food_app/model/BeanConfirmLocation.dart';
import 'package:food_app/model/BeanFavKitchen.dart';
import 'package:food_app/model/BeanForgotPassword.dart';
import 'package:food_app/model/BeanGetCard.dart';
import 'package:food_app/model/BeanGetPackages.dart';
import 'package:food_app/model/BeanKitchenDetail.dart';
import 'package:food_app/model/BeanLogin.dart';
import 'package:food_app/model/BeanRemoveKitchen.dart';
import 'package:food_app/model/BeanSearchData.dart';
import 'package:food_app/model/BeanSignUp.dart';
import 'package:food_app/model/BeanUpdateSetting.dart';
import 'package:food_app/model/BeanVerifyOtp.dart';
import 'package:food_app/model/GetAccountDetail.dart';
import 'package:food_app/model/GetActiveOrder.dart';
import 'package:food_app/model/GetAddressList.dart';
import 'package:food_app/model/GetArchieveOffer.dart';
import 'package:food_app/model/GetCartCount.dart';
import 'package:food_app/model/GetCartDetail.dart';
import 'package:food_app/model/GetDashBoard.dart';
import 'package:food_app/model/GetFeedback.dart';
import 'package:food_app/model/GetHomeData.dart';
import 'package:food_app/model/GetLiveOffer.dart';
import 'package:food_app/model/GetMenu.dart';
import 'package:food_app/model/GetOrderHistory.dart';
import 'package:food_app/model/GetOrderHistoryDetail.dart';
import 'package:food_app/model/GetOverAllReview.dart';
import 'package:food_app/model/GetProfile.dart';
import 'package:food_app/model/GetReview.dart';
import 'package:food_app/model/GetUserAddress.dart';
import 'package:food_app/model/SocialLogin.dart';
import 'package:food_app/model/UpdateMenuDetails.dart';
import 'package:food_app/network/EndPoints.dart';
import 'package:food_app/utils/DioLogger.dart';

class ApiProvider {
  static const _baseUrl =
      "https://nohungkitchen.notionprojects.tech/api/foodies/";
  static const String TAG = "ApiProvider";

  Dio _dio;
  DioError _dioError;

  ApiProvider() {
    BaseOptions dioOptions = BaseOptions()..baseUrl = ApiProvider._baseUrl;
    _dio = Dio(dioOptions);
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.headers = {
        'Content-Type': 'multipart/form-data',
      };
      DioLogger.onSend(TAG, options);
      return options;
    }, onResponse: (Response response) {
      DioLogger.onSuccess(TAG, response);
      return response;
    }, onError: (DioError error) {
      DioLogger.onError(TAG, error);
      return error;
    }));
  }

  Future registerUser(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.register, data: params);
      return BeanSignUp.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanLogin> loginUser(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.login, data: params);
      return BeanLogin.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanVerifyOtp> verifyOtp(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.verify_otp, data: params);
      return BeanVerifyOtp.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanSearchData> searchData(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.search, data: params);
      return BeanSearchData.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanClearRecentSearch> clearRecentSearch(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.clear_recent_search, data: params);
      return BeanClearRecentSearch.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanFavKitchen> favKitchen(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.add_favorite_kitchen, data: params);
      return BeanFavKitchen.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanRemoveKitchen> removeKitchen(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.removeKitchen, data: params);
      return BeanRemoveKitchen.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetAddressList> getAddress(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.search_location, data: params);
      return GetAddressList.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanForgotPassword> forgotPassword(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.forgot_password, data: params);
      return BeanForgotPassword.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanAddCard> beanAddcard(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.add_card_detail, data: params);
      return BeanAddCard.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanGetCard> beanGetCard(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_cards, data: params);
      return BeanGetCard.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetProfile> getProfile(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_my_profile, data: params);
      return GetProfile.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<KitchenDetail> kitchenDetail(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.KitchenDetail, data: params);
      return KitchenDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetDashBoard> getDashboard(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.dashboard, data: params);
      return GetDashBoard.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanHomeData> getHomeData(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.search_kitchen, data: params);
      return BeanHomeData.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetCartDetail> getCartDetail(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_cart_details, data: params);
      return GetCartDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetCartCount> getCartCount(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_cart_items_count, data: params);
      return GetCartCount.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanApplyPromo> applyPromo(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.apply_coupon_code, data: params);
      return BeanApplyPromo.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetOrderHistory> getOrderHistory(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_order_history, data: params);
      return GetOrderHistory.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetOrderHistoryDetail> getOrderHistoryDetail(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_order_history_details, data: params);
      return GetOrderHistoryDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetUserAddress> getUserAddress(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_address_list, data: params);
      return GetUserAddress.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetActiveOrder> getActiveOrder(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_active_orders, data: params);
      return GetActiveOrder.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<SocailLogin> socailLogin(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.social_login, data: params);
      return SocailLogin.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanConfirmLocation> confirmlocation(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.confirm_location, data: params);
      return BeanConfirmLocation.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getArchieveOffer(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_archive_offer, data: params);
      return GetArchieveOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetReview> getFeedback(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_received_reviews, data: params);
      return GetReview.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetOverAllReview> getoverallreview(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_overall_received_reviews, data: params);
      return GetOverAllReview.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getMenu(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_menu, data: params);
      return MenuBean.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future updateSetting(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.update_settings, data: params);
      return BeanUpdateSetting.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future updateMenuSetting(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.update_account_detail, data: params);
      return UpdateMenuDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getLiveOffers(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_live_offer, data: params);
      return GetLiveOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getPackages(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_package, data: params);
      return BeanGetPackages.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future addPackage(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.add_package, data: params);
      return BeanAddPackage.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getAccountDetails(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_account_detail, data: params);
      return GetAccountDetails.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future addOffer(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.add_offer, data: params);
      return AddOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  void throwIfNoSuccess(String response) {
    throw new HttpException(response);
  }
}
