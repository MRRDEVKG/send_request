# send_request
A simple, Future-based library for making HTTP requests.

Usage:
sendRequest(
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
         'authorization':
             'Token 745a48f85bb8366e477e3509cfc130828be704c4',
       },
       format: 'application/json; charset=UTF-8');
