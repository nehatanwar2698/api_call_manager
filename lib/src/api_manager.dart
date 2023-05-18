import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:api_call_manager/src/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'app_exception.dart';

class ApiManager {
  // post method-------
  Future postData(
      {required Map<String, String> headers,
      required String apiUrl,
      required Map<String, dynamic> body,
      token}) async {
    try {
      printData("api url => ${apiUrl}");
      printData("api body => ${json.encode(body)}");
      printData("token  => $token");

      // Loader.show(context!);

      var getRaw = await http
          .post(Uri.parse(apiUrl), headers: headers, body: json.encode(body))
          .timeout(Duration(seconds: 25), onTimeout: () {
        return Future.value(http.Response("Error", 408));
      }).timeout(Duration(seconds: 30));

      printData("api response => ${getRaw.body}");

      if (getRaw.statusCode == 200) {
        return getRaw.body;
      } else {
        return getRaw.body;
      }
    } on SocketException {
      throw FetchDataException(
          'No Internet Connection', Uri.parse(apiUrl).toString());
    } on TimeoutException {
      EasyLoading.dismiss();
      throw ApiNotRespondingException(
          'Api not respond in time', Uri.parse(apiUrl).toString());
    }
  }

//get method----------

  Future<String> getData(
      {Map<String, String>? headers, required String apiUrl}) async {
    try {
      printData("api url => ${apiUrl}");
      Loader().showLoader();

      final Response getRaw = await http
          .get(Uri.parse(apiUrl), headers: headers)
          .timeout(Duration(seconds: 20));
      printData("api response => ${getRaw.body}");

      if (getRaw.statusCode == 200) {
        Loader().hideLoader();

        return getRaw.body;
      } else {
        Loader().hideLoader();

        return getRaw.body;
      }
    } on SocketException {
      throw FetchDataException(
          'No Internet Connection', Uri.parse(apiUrl).toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not respond in time', Uri.parse(apiUrl).toString());
    }
  }
}

void printData(String text) {
  print('\x1B[33m$text\x1B[0m');
}
