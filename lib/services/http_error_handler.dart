import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response response) {
  final statusCode = response.statusCode;
  final reasonPharse = response.reasonPhrase;
  final String errorMessage =
      'Request failer\nStatus Code: $statusCode\nReason: $reasonPharse';
  return errorMessage;
}
