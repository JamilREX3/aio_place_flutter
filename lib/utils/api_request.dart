import 'dart:io';
import 'package:aio_place/component/custom_snacbar.dart';
import 'package:aio_place/constants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ApiRequest {
  final _dio = dio.Dio();

  Future<dio.Response> get(
      {authRequire = true,
      @required path,
      dynamic body,
      Map<String, dynamic>? query,
      bool showSnackBar = true}) async {
    dio.Response finalResponse;
    try {
      dio.Options options = dio.Options();
      if (authRequire == true) {
        String token = await GetStorage().read('token');
        options = dio.Options(headers: {'Authorization': 'Bearer $token'});
      }
      dio.Response response = await _dio.get(
        KConstants.baseUrl + path,
        data: body,
        queryParameters: query,
        options: options,
      );
      finalResponse = response;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        finalResponse = e.response!;
      } else {
        finalResponse = dio.Response(
          statusCode: 500,
          data: {'message': 'An error occurred'},
          requestOptions: dio.RequestOptions(path: KConstants.baseUrl + path),
        );
      }
    }
    if (showSnackBar == true) {
      CustomSnackbar.show(response: finalResponse);
    }
    return finalResponse;
  }

  Future<dio.Response> post(
      {authRequire = true,
      @required path,
      dynamic body,
      Map<String, dynamic>? params}) async {
    dio.Response finalResponse;
    try {
      dio.Options options = dio.Options();
      if (authRequire == true) {
        String token = await GetStorage().read('token');
        options = dio.Options(headers: {'Authorization': 'Bearer $token'});
      } else {}
      dio.Response response = await _dio.post(
        KConstants.baseUrl + path,
        data: body,
        queryParameters: params,
        options: options,
      );

      finalResponse = response;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        finalResponse = e.response!;
      } else {
        finalResponse = dio.Response(
          statusCode: 500,
          data: {'message': 'An error occurred'},
          requestOptions: dio.RequestOptions(path: KConstants.baseUrl + path),
        );
      }
    }
    CustomSnackbar.show(response: finalResponse);
    return finalResponse;
  }

  Future<dio.Response> put(
      {authRequire = true,
      @required path,
      dynamic body,
      Map<String, dynamic>? params}) async {
    dio.Response finalResponse;
    try {
      dio.Options options = dio.Options();
      if (authRequire == true) {
        String token = await GetStorage().read('token');
        options = dio.Options(headers: {'Authorization': 'Bearer $token'});
      }
      if (body != null) {
        bool hasFileData = false;
        dio.FormData formData = dio.FormData.fromMap(body);

        body.forEach((key, value) async {
          if (value is File || value is XFile) {
            hasFileData = true;
            final mimeType = lookupMimeType(value.path);
            formData.files.add(MapEntry(
                key,
                await dio.MultipartFile.fromFile(value.path,
                    filename: key, contentType: MediaType.parse(mimeType!))));
          }
        });
        if (hasFileData) {
          body = formData;
        }
      }
      dio.Response response = await _dio.put(
        KConstants.baseUrl + path,
        data: body,
        queryParameters: params,
        options: options,
      );

      finalResponse = response;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        finalResponse = e.response!;
      } else {
        finalResponse = dio.Response(
          statusCode: 500,
          data: {'message': 'An error occurred'},
          requestOptions: dio.RequestOptions(path: KConstants.baseUrl + path),
        );
      }
    }
    CustomSnackbar.show(response: finalResponse);
    return finalResponse;
  }

  Future<dio.Response> delete(
      {authRequire = true,
      @required path,
      Map<String, dynamic>? params}) async {
    dio.Response finalResponse;
    try {
      dio.Options options = dio.Options();
      if (authRequire == true) {
        String token = await GetStorage().read('token');
        options = dio.Options(headers: {'Authorization': 'Bearer $token'});
      }
      dio.Response response =
          await _dio.delete(KConstants.baseUrl + path, options: options);

      finalResponse = response;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        finalResponse = e.response!;
      } else {
        finalResponse = dio.Response(
          statusCode: 500,
          data: {'message': 'An error occurred'},
          requestOptions: dio.RequestOptions(path: KConstants.baseUrl + path),
        );
      }
    }

    CustomSnackbar.show(response: finalResponse);
    return finalResponse;
  }
}
