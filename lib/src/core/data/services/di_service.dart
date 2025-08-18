import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

enum ApiResult{
  success,
  error,
}

enum RequestMethod{
  GET,
  POST,
  PUT,
  DELETE,
}

@immutable
sealed class ApiConstants{
  /// Properties
  static bool isTester = true;
  static const duration = Duration(seconds: 30);
  static const contentType = "application/json";
  static bool validate(int? statusCode) => statusCode! <= 205;
  static const SERVER_DEVELOPMENT = "https://pytech.uz/api";
  static const SERVER_DEPLOYMENT = "https://pytech.uz/api";
  static String getServer(){
    if(isTester) return SERVER_DEVELOPMENT;
    return SERVER_DEPLOYMENT;
  }

  /// Api
  static const String apiCompanies = "/companies/";
  static const String apiRegistration = "/auth/dj-rest-auth/registration/";
  static const String apiLogin   = "/auth/dj-rest-auth/login/";
}


@immutable
sealed class DioService{

  /// Options
  static BaseOptions _options = BaseOptions();

  static Dio _dio = Dio();

  static Dio init(){
    _options = BaseOptions(
      connectTimeout: ApiConstants.duration,
      receiveTimeout: ApiConstants.duration,
      sendTimeout: ApiConstants.duration,
      baseUrl: ApiConstants.getServer(),
      contentType: ApiConstants.contentType,
      validateStatus: ApiConstants.validate,
    );
    _dio = Dio(_options);
    return _dio;
  }

  /// method
  static Future<String?>getData( String api, [Map<String, dynamic>? param])async{
    try{
      Response response = await init().get(api, queryParameters: param);
      return jsonEncode(response.data);
    } on DioException catch(e){
      log("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}");
      Future.delayed(Duration.zero).then((value) {
        // Utils.fireSnackBar("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}", context);
      });
      return null;
    }
  }

  static Future<String?>postData( String api, Map<String, Object?> data, [Map<String, dynamic>? param])async{
    try{
      Response response = await init().post(api, data: jsonEncode(data));
      return jsonEncode(response.data);
    } on DioException catch(e){
      log("DioException: Error at ${e.requestOptions.uri}. Because of ${e.response?.data}");
      Future.delayed(Duration.zero).then((value) {
        // Utils.fireSnackBar("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}", context);
      });
      return null;
    }
  }

  static Future<String?>updateData( String api, String id, Map<String, Object?> data, [Map<String, dynamic>? param])async{
    try{
      Response response = await init().put("$api/$id", data: jsonEncode(data), queryParameters: param);
      return jsonEncode(response.data);
    } on DioException catch(e){
      log("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}");
      Future.delayed(Duration.zero).then((value) {
        // Utils.fireSnackBar("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}", context);
      });
      return null;
    }
  }

  static Future<String?>deleteData( String api, String id, Map<String, Object?> data, [Map<String, dynamic>? param])async{
    try{
      Response response = await init().delete("$api/$id", data: data);
      return jsonEncode(response.data);
    } on DioException catch(e){
      log("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}");
      Future.delayed(Duration.zero).then((value) {
        // Utils.fireSnackBar("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}", context);
      });
      return null;
    }
  }

  static Future<String?>request( String api, RequestMethod method, [Map<String, dynamic>? param, Map<String, Object?> data = const {}, String? id])async{

    try{
      Response response = await init().request(
          id == null
              ?api
              :"$api/$id",
          data: jsonEncode(data),
          options: Options(
            method: method.name,
          )
      );
      return jsonEncode(response.data);
    } on DioException catch(e){
      log("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}");
      Future.delayed(Duration.zero).then((value) {
        // Utils.fireSnackBar("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}", context);
      });
      return null;
    }
  }





}