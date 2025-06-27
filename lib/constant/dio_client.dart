import 'dart:async';
import 'dart:convert';

import 'package:afran/constant/app_strings.dart';
import 'package:afran/constant/secure_storage.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();

  // Public factory constructor for singleton
  factory DioClient() => _singleton;
  late Dio _dio;


  // Private constructor for singleton
  DioClient._internal() {

    _dio = Dio(BaseOptions(
      // baseUrl: Urls.baseUrl,
      connectTimeout: const Duration(seconds: 7),
      receiveTimeout: const Duration(seconds: 7),
      // headers:{
      //   'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
      // }
    ));
    _initializeInterceptors();
  }




  // Initialize Interceptors
  void _initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(

      onRequest: (options, handler) async{
        final secureStorage = SecureStorageService();
        String? accessToken = await secureStorage.read(userToken);
        print('...........${accessToken}');
        // options.headers['Authorization'] = 'Bearer $accessToken';
        // // options.headers['Content-Type'] = 'application/json';
        // options.headers['Accept'] = 'application/json';

        print('Requesting: ${options.method} ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response Status:  ${response.statusCode}');
        print('Response :  ${response.data}');

        return handler.next(response);
      },
      onError: (DioException exception, handler) async {
        // if (_shouldRetry(exception)) {
        //   await _retryRequest(exception, handler);
        // } else {
        //   _handleException(exception);
        //   return handler.next(exception);
        // }
        // print(exception.response?.statusCode);
        // print(exception.response);
        // print(exception.error);
        _handleException(exception);
        return handler.next(exception);
        // return exception.response;
      },
    ));
  }

  // prevent the same request from being made repeatedly within a short timeframe. _debouncedRequest wraps the main request with a Timer, adding a slight delay.
  Timer? _debounceTimer;
  CancelToken? _cancelToken;

  Future<dynamic> _debouncedRequest(Future<Response<dynamic>> Function() request) async {
    _debounceTimer?.cancel();
    _cancelToken?.cancel();

    _cancelToken = CancelToken();
    Completer<dynamic> completer = Completer();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        final response = await request();
        // completer.complete(jsonDecode(response.toString()));
        completer.complete({
          'statusCode': response.statusCode,
          'data': response.data,
        });
      } on DioException catch (e) {
        print(e);
        print('exception${e.response!.statusCode}');
        // completer.complete(e.response != null ? jsonDecode(e.response.toString()) : null);
        completer.complete({
          'statusCode': e.response?.statusCode ?? 500,
          'data': e.response?.data ?? {'error': 'Unexpected error'},
        });
      } catch (e) {
        // completer.complete(null);
        completer.completeError(e);
      }
    });
   print(completer.future);
    return completer.future;
  }
// Public GET method with debouncing
  @override
  Future<dynamic> getAPI(String path) async {
    final secureStorage = SecureStorageService();

    String? accessToken = await secureStorage.read(userToken);
    return await _debouncedRequest(() => _dio.get(
      path, cancelToken: _cancelToken,
      options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            // 'Content-Type': 'application/json',
            'Accept': 'application/json',


          }
      ),
    ));
  }

  @override
  Future<dynamic> postAPI(String path, dynamic data) async {
    final secureStorage = SecureStorageService();
    String? accessToken = await secureStorage.read(userToken);
    print('token:::::$accessToken');
    return await _debouncedRequest(() => _dio.post(
        options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
              // 'Content-Type': 'application/json',
              'Accept': 'application/json',


            }
        ),
        path, data: data, cancelToken: _cancelToken));
  }

  @override
  Future<dynamic> deleteAPI(String path,) async {
    final secureStorage = SecureStorageService();
    String? accessToken = await secureStorage.read(userToken);
    print('token:::::$accessToken');
    return await _debouncedRequest(() => _dio.delete(
        options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Accept': 'application/json',


            }
        ),
        path, cancelToken: _cancelToken));
  }

  void _handleException(DioException exception) {
    print('STATUS CODE: ${exception.response?.statusCode}');
    if (exception.type == DioExceptionType.connectionTimeout) {
      print('Connection timeout occurred');

    } else if (exception.type == DioExceptionType.receiveTimeout) {
      print('Receive timeout occurred');
    } else if (exception.response != null) {
      switch (exception.response?.statusCode) {
        case 400:
          print('Bad request: ${exception.response?.data}');
          break;
        case 422:
          print('nnnnnnnnnnnnnnn: ${exception.response?.statusCode}');
          break;
        case 401:
          print('Unauthorized: ${exception.response?.data}');
          break;
        case 403:
          print('Forbidden: ${exception.response?.data}');
          break;
        case 404:
          print('Not found: ${exception.response?.data}');
          break;
        case 500:
          print('Internal server error');
          break;
        default:
          print('Invalid status code: ${exception.response?.statusCode}');
      }
    } else {
      print('Unexpected error: ${exception.message}');
    }
  }







}





