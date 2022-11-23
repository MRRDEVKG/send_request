import 'package:flutter_test/flutter_test.dart';

import 'package:send_request/send_request.dart';

import 'dart:async';

var printLog = [];

print(String s) => printLog.add(s);

void main() async {
  test('Sends HTTP GET request', () async {
    await sendRequest(
        url: 'http://192.168.22.52:8000/api/auth/22',
        method: 'get',
        /*
       parameters: {
         'user_id': '184121',
         'password': '18181818',
         'is_staff': true,
       },
       */
        headers: {
          'authorization': 'Token 745a48f85bb8366e477e3509cfc130828be704c4',
        },
        format: 'application/json; charset=UTF-8');

    //expect(printLog[0], contains('Все прошло удачно'));
  });

  test('Method validation', () async {
    try {
      await sendRequest(
          url: 'http://192.168.22.52:8000/api/auth/22',
          method: 'Patch',
          /*
       parameters: {
         'user_id': '184121',
         'password': '18181818',
         'is_staff': true,
       },
       */
          headers: {
            'authorization': 'Token 745a48f85bb8366e477e3509cfc130828be704c4',
          },
          format: 'application/json; charset=UTF-8');
    } catch (e) {
      print(e.toString());
      expect(e.toString(),
          'Exception: Undefined Method! "Patch" not found in {get, post, delete, put}');
    }

  });
}
