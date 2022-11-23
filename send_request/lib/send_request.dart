library send_request;

import 'dart:io';
import 'dart:convert';

Future<void> sendRequest(
    {required String url,
    required String method,
    Map<String, dynamic>? parameters,
    Map<String, Object>? headers,
    String format = 'application/json; charset=UTF-8'}) async {
  final client = _Client();
  int statusCode = 0;

  /// Calling HTTP request methods using _Client class instance
  switch (method.toLowerCase()) {
    case 'get':
      await client
          .get(url, headers: headers, format: format)
          .then((response) => statusCode = response.statusCode);
      break;
    case 'post':
      await client
          .post(url, parameters: parameters, headers: headers, format: format)
          .then((response) => statusCode = response.statusCode);
      break;
    case 'delete':
      await client
          .delete(url, headers: headers, format: format)
          .then((response) => statusCode = response.statusCode);
      break;
    case 'put':
      await client
          .put(url, parameters: parameters, headers: headers, format: format)
          .then((response) => statusCode = response.statusCode);
      break;
    default:
      throw Exception(
          'Undefined Method! "$method" not found in {get, post, delete, put}');
  }

  /// Show Status Code information of HTTP requests
  switch (statusCode) {
    case 200:
      print('Все прошло удачно');
      break;
    case 500:
      print('Произошла неизвестная ошибка');
      break;
    case 400:
      print('Данные не верны');
      break;
    case 403:
      print('У Вас нету доступа на данный сервис');
      break;
    default:
      print('HTTP Status Code $statusCode');
      break;
  }
}

/// _Client class with HTTP request methods: GET, POST, DELETE and PUT
class _Client {
  final HttpClient _httpClient;
  late HttpClientRequest _request;
  late HttpClientResponse _response;

  _Client() : _httpClient = HttpClient();

  /// Get response of HTTP requests
  Future<void> _getResponse(String method, Map<String, dynamic>? parameters,
      Map<String, Object>? headers, String format) async {
    headers?.forEach((header, value) => _request.headers.set(header, value));

    if (['get', 'delete'].contains(method)) {
      _request.headers.set(HttpHeaders.contentTypeHeader, format);
    } else {
      _request
        ..headers.set(HttpHeaders.contentTypeHeader, format)
        ..write(json.encode(parameters));
    }

    _response = await _request.close();
  }

  /// GET request method
  Future<HttpClientResponse> get(String url,
      {required Map<String, Object>? headers, required String format}) async {
    _request = await _httpClient.getUrl(Uri.parse(url));
    await _getResponse('get', null, headers, format);
    return _response;
  }

  /// POST request method
  Future<HttpClientResponse> post(String url,
      {required Map<String, dynamic>? parameters,
      required Map<String, Object>? headers,
      required String format}) async {
    _request = await _httpClient.postUrl(Uri.parse(url));
    await _getResponse('post', parameters, headers, format);
    return _response;
  }

  /// DELETE request method
  Future<HttpClientResponse> delete(String url,
      {required Map<String, Object>? headers, required String format}) async {
    _request = await _httpClient.deleteUrl(Uri.parse(url));
    await _getResponse('delete', null, headers, format);
    return _response;
  }

  /// PUT request method
  Future<HttpClientResponse> put(String url,
      {required Map<String, dynamic>? parameters,
      required Map<String, Object>? headers,
      required String format}) async {
    _request = await _httpClient.putUrl(Uri.parse(url));
    await _getResponse('put', parameters, headers, format);
    return _response;
  }
}
