
import 'package:get/get.dart';

import 'package:flutter/foundation.dart' as Foundation;

import '../model/response/error_response.dart';



class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;


  String? token;
  Map<String, String>? _mainHeaders;

  ApiClient({required this.appBaseUrl,  }) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8'

    };
  }


  Future<Response> getData(String uri, {Map<String, dynamic>? query, String? contentType,
    Map<String, String>? headers, Function(dynamic)? decoder,
  }) async {
    try {

      Response response = await get(
        uri,
        contentType: contentType,
        query: query,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
      );
      response = handleResponse(response);
      if(Foundation.kDebugMode) {
        print('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, dynamic>? query, String? contentType,
    Map<String, String>? headers, Function(dynamic)? decoder, Function(double)? uploadProgress,
  }) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> GetX Body: $body');

      }
      Response response = await post(
        uri, body,
        query: query,
        contentType: contentType,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );
      response = handleResponse(response);
      if(Foundation.kDebugMode) {
        print('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    }catch (e) {

      return Response(statusCode: 2, statusText: e.toString());
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, dynamic>? query, String? contentType,
    Map<String, String>? headers, Function(dynamic)? decoder, Function(double)? uploadProgress,
  }) async {
    try {
      if(Foundation.kDebugMode) {

        print('====> GetX Body: $body');
      }
      Response response = await put(
        uri, body,
        query: query,
        contentType: contentType,
        headers: headers ?? _mainHeaders,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );
      response = handleResponse(response);
      if(Foundation.kDebugMode) {
        print('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri, {Map<String, dynamic>? query, String? contentType,
    Map<String, String>? headers, Function(dynamic)? decoder,
  }) async {
    try {

      Response response = await delete(
        uri,
        headers: headers ?? _mainHeaders,
        contentType: contentType,
        query: query,
        decoder: decoder,
      );
      response = handleResponse(response);
      if(Foundation.kDebugMode) {
        print('====> GetX Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Response handleResponse(Response response) {
    Response _response = response;
    if(_response.hasError && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    }else if(_response.hasError && _response.body == null) {
      _response = Response(statusCode: 0, statusText: 'Connection to API server failed due to internet connection');
    }
    return _response;
  }
}