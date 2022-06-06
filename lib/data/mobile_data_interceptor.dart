import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MobileDataInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isMobile = connectivityResult == ConnectivityResult.mobile;
    final isLargeFile = request.url.contains(RegExp(r'(/large|/video)'));

    if (isLargeFile) {
      throw MobileDataException();
    }
    return request;
  }
}

class MobileDataException implements Exception {
  final message =
      'Downloading large files over data connections may incur costs';
  @override
  String toString() => message;
}
