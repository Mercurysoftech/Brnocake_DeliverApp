import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/earning.dart';
import 'package:task1/modelclass/EarningResponse.dart';
import 'package:task1/modelclass/accetped_order.dart';

import 'package:task1/modelclass/basic_details.dart';
import 'package:task1/modelclass/completeorder.dart';
import 'package:task1/modelclass/deliverorder.dart';
import 'package:task1/modelclass/earninghistory.dart';
import 'package:task1/modelclass/homecheck.dart';
import 'package:task1/modelclass/orderlist.dart';
import 'package:task1/modelclass/rejectedorder.dart';

import '../modelclass/orederstatuscout.dart';

class Apiservices {
  final _dio = Dio();
  String baseUrl = 'https://srv751071.hstgr.cloud/api/';
  Future<Map<String, dynamic>> sendSms({
    required String phoneNumber,
    required String message,
  }) async {
    String smsApiUrl = 'http://site.ping4sms.com/api';
    try {
      Response response = await _dio.post(
        smsApiUrl,
        //data: FormData.fromMap(body),
        queryParameters: {
          "key": "11ac642b5cd66a65bb0e636a0441619c",
          "route": "2",
          "sender": "MERSOF",
          "number": phoneNumber,
          "sms":
              "Your Login Verification code:$message Don't share this code with others -MERCURY",
          "templateid": '1607100000000339284'
        },
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        print('vvvvvvvv${response.data}');
        return {
          "success": true,
          "message": "SMS sent successfully",
          "data": response.data,
        };
      } else {
        print('noooooooooooo');
        return {
          "success": false,
          "error": "Failed to send SMS: ${response.statusMessage}",
        };
      }
    } on DioException catch (e) {
      return {
        "success": false,
        "error": "Error sending SMS: ${e.message}",
      };
    }
  }

  Future enterDetails() async {
    final endpoint = baseUrl + "delivery_register.php";
    final form = UserFormData();

    try {
      final response = await _dio.post(endpoint,
          data: FormData.fromMap(form.data()),
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));
      if (response.statusCode == 200) {
        final res = response.data;
        print("First name: ${UserFormData().name}");
        print('token1${response.data['token']}');
        String token = response.data['token'];
        String userid = response.data['user_id'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('registertoken', res['token']);
        await prefs.setString('registeruserid', res['user_id'].toString());

        await prefs.setString('id', userid);

        print('resonps${response.data['token']}');
        print('resonps$token');
      }
    } catch (e) {
      print('vvvvvvvvv$e');
    }
  }

  Future deliverstatus(status) async {
    String endpoint = baseUrl + 'delivery_online_status.php';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('token$token');
    String? token1 = prefs.getString('logintoken');
    String? token2 = prefs.getString('registertoken');
    //print('token: $token');
    String? deliverytoken = token1 ?? token2;
    print('token: $token');

    Map<String, dynamic> data = {"status": status ? 1 : 0};

    print('mmmmmmmmmmmmmmm$data');

    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $deliverytoken",
            //"Content-Type": "application/json", // optional
          },
          responseType: ResponseType.plain,
        ),
      );
      print('Raw response: ${response.data}');
      print('Status Code: ${response.statusCode}');

      // Check if response statusCode is OK (200)
      if (response.statusCode == 200) {
        print('Response: ${response.data}');

        return data;
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Catch network or other errors
      print('Error: $e');
    }
  }

  Future wallet() async {
    String endpoint = baseUrl + 'wallet.php';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('token: $token');

    try {
      final response = await _dio.post(
        endpoint,
        data: ({
          'balance': 100,
        }), // Encode data as JSON
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);

        print('Response Data: $data');
        print('Balance: ${data['balance']}');
      } else if (response.statusCode == 401) {
        print(' Unauthorized. Token may be expired or invalid.');
      } else {
        print(' Unexpected status: ${response.statusCode}');
      }
    } catch (e) {
      print(' Error: $e');
    }
  }

  Future login(String number) async {
    final endpoint = 'https://srv751071.hstgr.cloud/api/delivery_login.php';

    final data = {'mobile': number};

    print('bbbbbbbb$data');

    try {
      final res = await _dio.post(
        endpoint,
        data: data,
      );

      if (res.statusCode == 200) {
        print('Raw response: ${res.data}');

        var res1 = res.data;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('logintoken', res1['token']);
        await prefs.setString('loginruserid', res1['user_id'].toString());
        //await prefs.setString('status', res1['status']);

        print('mmmmmmmmmmmmmm${res1['status']}');

        return res1['status'];
      }
    } catch (e) {
      print('error111111$e');
    }
  }

  Future todayearning() async {
    String endpoint = baseUrl + 'delivery_get_earnings.php';
    final prefs = await SharedPreferences.getInstance();

    String? token1 = prefs.getString('logintoken');
    String? token2 = prefs.getString('registertoken');
    //print('token: $token');
    String? token = token1 ?? token2;
    print('token: $token');

    try {
      final response = await _dio.post(endpoint,
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));

      if (response.statusCode == 200) {
        var data = response.data;
        print('Full response: $data');
        return EarningResponse.fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Exception: 1212$e');
      rethrow;
    }
  }

  Future<Orederstatuscout?> orderstatuscound() async {
    String endpoint = baseUrl + 'delivery_order_status_count.php';
    final prefs = await SharedPreferences.getInstance();

    String? token1 = prefs.getString('logintoken');
    String? token2 = prefs.getString('registertoken');
    //print('token: $token');
    String? token = token1 ?? token2;
    print('token: $token');

    try {
      final response = await _dio.post(endpoint,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        var data = response.data;
        print('codeeeeee$data');
        return Orederstatuscout.fromJson(data);
      }
    } catch (e) {
      print('erooooooor11111$e');
    }
    return null;
  }

  Future completeorderapi() async {
    List details = [];
    final prefs = await SharedPreferences.getInstance();
    String? token1 = prefs.getString('logintoken');
    String? token2 = prefs.getString('registertoken');
    //print('token: $token');
    String? token = token1 ?? token2;
    print('token: $token');

    final endpoint = baseUrl + 'delivery_complete_order.php';
    try {
      final response = await _dio.post(endpoint,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        var res = response.data;
        print('data111111111111$res');
        for (var v in res) {
          v.add(details);
        }
        return Completeorder.completedOrdersList(details);
      }
    } catch (e) {
      print('vvvvvvv1$e');
    }
  }

  Future orderlist() async {
    List details = [];
    final prefs = await SharedPreferences.getInstance();
    String? token1 = prefs.getString('logintoken');
    String? token2 = prefs.getString('registertoken');
    //print('token: $token');
    String? token = token1 ?? token2;
    print('token: $token');

    final endpoint = baseUrl + 'delivery_order_list.php';
    try {
      final response = await _dio.post(endpoint,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        var res = response.data;
        print('data111111111111$res');

        return OrderResponse.fromJson(res);
      }
    } catch (e) {
      print('vvvvvvv11122222$e');
    }
  }

  Future accetptorder() async {
    final endpoint = baseUrl + 'delivery_accept_order.php';
    final prefs = await SharedPreferences.getInstance();
    String? token1 = prefs.getString('logintoken');
    String? token2 = prefs.getString('registertoken');
    //print('token: $token');
    String? token = token1 ?? token2;
    print('token: $token');

    try {
      final response = await _dio.post(endpoint,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        var data = response.data;
        print('codeeeeee$data');
        return OrderStatusResponse.fromJson(data); // ✅ Correct
      }
    } catch (e) {
      print('ffffffffffe');
    }
    return OrderStatusResponse(
      status: false,
      message: 'Something went wrong',
      data: [],
    );
  }

  Future<Rejectedorder> rejectedorder() async {
    final endpoint = baseUrl + 'delivery_reject_order.php';
    final prefs = await SharedPreferences.getInstance();
    String? token1 = prefs.getString('logintoken');
    String? token2 = prefs.getString('registertoken');
    //print('token: $token');
    String? token = token1 ?? token2;
    print('token: $token');

    try {
      final response = await _dio.post(endpoint,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        var data = response.data;
        print('codeeeeee........$data');
        return Rejectedorder.fromJson(data); // ✅ Correct
      }
    } catch (e) {
      print('ffffffffffe');
    }
    return Rejectedorder(
      status: false,
      message: 'Something went wrong',
      data: [],
    );
  }

  Future homecheck() async {
    final prefs = await SharedPreferences.getInstance();
    String? token1 = prefs.getString('logintoken');
    String? token2 = prefs.getString('registertoken');
    //print('token: $token');
    String? token = token1 ?? token2;
    print('token: $token');
    final endpoint = baseUrl + 'delivery_homecheck.php';
    try {
      final response = await _dio.post(endpoint,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        var homechackdata = response.data;
        print('homecheckdata$homechackdata');
        return HomeCheck.fromJson(homechackdata);
      }
    } catch (e) {
      print('homechecerorrrrr$e');
    }
    return HomeCheck(
      status: false,
      data: HomeCheckData(
        verifyStatus: 0,
        city: null,
        location: null,
        state: null,
        balance: "0.00",
        createdAt: "",
        updatedAt: "",
      ),
    );
  }

  Future deliverorderlist() async {
    final endpoint = baseUrl + 'delivery_order_list.php';
    final prefs = await SharedPreferences.getInstance();
    String? token1 = prefs.getString('logintoken');
    String? token2 = prefs.getString('registertoken');
    //print('token: $token');
    String? token = token1 ?? token2;
    print('token: $token');
    try {
      final response = await _dio.post(endpoint,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        var deliverdata = response.data;
        return DeliverOrder.fromJson(deliverdata);
      }
    } catch (e) {
      print('delivererror$e');
    }
    return DeliverOrder(status: false, message: 'data not fount', data: []);
  }

  Future locationupdate(String location) async {
    final endpoint = baseUrl + 'delivery_location_update.php';
    final prefs = await SharedPreferences.getInstance();
    String? token1 = prefs.getString('logintoken');
    String? token2 = prefs.getString('registertoken');
    //print('token: $token');
    String? token = token1 ?? token2;
    print('token: $token');
    if (token == null || token.isEmpty) {
      print("Token is null or empty");
      return;
    }
    final data = {'location': location};

    try {
      final response = await _dio.post(endpoint,
          data: data,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        final res = response.data;
        print('ok');
        return res['status'];
      }
    } catch (e) {
      print("oooooooooovvvv$e");
    }
  }
}
