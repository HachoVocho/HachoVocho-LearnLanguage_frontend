import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../failures/failures.dart';

var dio = Dio();

class ApiHelperDio {
 ApiHelperDio() {
    // text =
    setOptions();
  }
  setOptions() async {

    dio.options.connectTimeout = Duration(milliseconds: 5000);
    dio.options.headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    print('base_url');
    print(dio.options.baseUrl);
  }

  Future getDioMethod({
    required String endpoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // _prefs.clear();
    String token = prefs.getString('') ?? '';
    String userID = prefs.getString('') ?? '';

    if (userID != '') {
      dio.options.headers.addAll({"Authorization": "Bearer $token"});
    }
    if (headers != null) {
      dio.options.headers.addAll(headers);
    }

    // Add your custom header to the headers map
    headers ??= {};

    var responseJson;
    try {
      Response response = await dio.get(endpoint, queryParameters: params,
        );
      responseJson = _response(response);
    } on SocketException {
      return InternetFailure(message: 'Internet Connection Error !!!');
    }
    return responseJson;
  }

  Future postDioMethod({
    required String endpoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    bool isInFormData = false,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.options.baseUrl = prefs.getString('development_base_url')!;
    print(dio.options.baseUrl);
    print("Params: $params");
    print("Endpoint: $endpoint");

    Options options = Options(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        if (headers != null) ...headers, // Merge additional headers
      },
    );

    try {
      Response response;
      if (isInFormData) {
        FormData formData = FormData.fromMap(params!);
        response = await dio.post(endpoint, data: formData, options: options);
      } else {
        response = await dio.post(endpoint, data: params, options: options);
      }

      // Debug the response
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      return _response(response);
    } on DioException catch (e) {
      if (e.response != null) {
        print('DioError Response Status Code: ${e.response?.statusCode}');
        print('DioError Response Data: ${e.response?.data}');
        print('DioError Headers: ${e.response?.headers}');
        throw Exception(e.response?.data);
      } else {
        print('DioError Message: ${e}');
        throw Exception('Network Error: ${e.message}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      print('General Error: $e');
      throw Exception('An error occurred: $e');
    }
  }


  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
//accepted //data might be null
      case 202:
        return response.data;
      case 404:
        throw ServerFailure(message: response.statusMessage);
      case 400:
        print(response.statusMessage);
        throw BadRequestFailure(message: response.statusMessage);
      case 401:
        throw UnauthorizedFailure(message: response.statusMessage);
      // case 403:
      //   throw UnauthorisedException();
      // case 500:
      default:
        throw FailureMessage(message: response.statusMessage);
    }
  }
}