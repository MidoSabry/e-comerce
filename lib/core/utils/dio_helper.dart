import 'package:dio/dio.dart';

import '../constants/end_points.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(baseUrl: EndPoints.BASE_URL, receiveDataWhenStatusError: true),
  );
  DioHelper();

//////////////get data///////////////
  // static Future<Response> getData(
  //     {required String url,
  //     Map<String, dynamic>? query,
  //     String? tokenId}) async {
  //   dio!.options.headers = {
  //     'Authorization': tokenId ?? '',
  //     'Content-Type': 'application/json',
  //   };

  //   // return await dio!.get(
  //   //   url,
  //   //   queryParameters: query,
  //   // );
  //   return await dio!.get(url,
  //       queryParameters: query,

  //       options: Options(headers: {"Authorization": "Bearer " + tokenId!}));
  // }

  static Future<Response> getDataWithToken(
      {required String path,
      Map<String, dynamic>? query,
      required String tokenid}) async {
    return await dio.get(path,
        queryParameters: query,
        options: Options(headers: {"Authorization": "Bearer " + tokenid}));
  }

  static Future<Response> getData(
      {required String path, Map<String, dynamic>? query}) async {
    return await dio.get(path, queryParameters: query);
  }

/////////////post data///////////////////
  // static Future<Response> postData(
  //     {required String url,
  //     Map<String, dynamic>? query,
  //     Map<String, dynamic>? data,
  //     String? tokenId}) async {
  //   dio.options.headers = {
  //     'Authorization': tokenId ?? '',
  //     'Content-Type': 'application/json',
  //   };

  //   return await dio.post(url, queryParameters: query, data: data);
  // }

  static Future<Response> postImageDataWithToken(
      {required String path,
      required FormData data,
      required String tokenid}) async {
    // dio.options.headers = {
    //   'Authorization': tokenid ?? '',
    // };
    return await dio.post(path,
        data: data,
        options: Options(headers: {"Authorization": "Bearer " + tokenid}));
  }

  static Future<Response> PostDataWithToken({
    required String path,
    Map<String, dynamic>? data,
    required String tokenid,
  }) async {
    return await dio.post(path,
        data: data,
        options: Options(headers: {"Authorization": "Bearer " + tokenid}));
  }

//
  static Future<Response> postDataWithToken(
      {required String path,
      required Map<String, dynamic> data,
      required String tokenid}) async {
    return await dio.post(path,
        data: data,
        options: Options(headers: {"Authorization": "Bearer " + tokenid}));
  }
/////////////////put data//////////////////////
  // static Future<Response> putData(
  //     {required String url,
  //     Map<String, dynamic>? query,
  //     Map<String, dynamic>? data,
  //     String? tokenId}) async {
  //   dio!.options.headers = {
  //     'Authorization': tokenId ?? '',
  //     'Content-Type': 'application/json',
  //   };

  //   return await dio!.put(url, queryParameters: query, data: data);
  // }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? data,
    required String tokenid,
  }) async {
    print("dio  " + path.toString());
    print(data.toString());
    print(tokenid);
    return await dio.put(path,
        data: data,
        options: Options(headers: {"Authorization": "Bearer " + tokenid}));
  }
}
