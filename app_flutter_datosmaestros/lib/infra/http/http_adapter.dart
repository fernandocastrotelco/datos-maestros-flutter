import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'http_client.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future request(
      {@required Uri url,
      @required String method,
      Map body,
      Map headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ??
        {'content-type': 'application/json'}
      ..addAll({
        'content-type': 'application/json; charset=utf-8',
        'accept': 'application/json'
      });
    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    Future<Response> futureResponse;
    try {
      if (method == 'post') {
        futureResponse =
            client.post(url, headers: defaultHeaders, body: jsonBody);
      } else if (method == 'get') {
        futureResponse = client.get(url, headers: defaultHeaders);
      } else if (method == 'put') {
        futureResponse =
            client.put(url, headers: defaultHeaders, body: jsonBody);
      } else if (method == 'delete') {
        futureResponse = client.delete(url, headers: defaultHeaders);
      }
      if (futureResponse != null) {
        response = await futureResponse.timeout(Duration(seconds: 20));
      }
    } catch (error) {
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    print(response.body);
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty
            ? null
            : jsonDecode(
                utf8.decode(
                  response.bodyBytes,
                ),
              );
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
