// import '../../services/http.dart' as http;
import 'package:http/http.dart' as http;

class SerpApi {

    static getSerp(String domain, String path) {
    print('sending request for ebay auth');
    var uri = Uri.https(domain, path);
    printRequest(uri);
    http.get(uri).then((response) => {
      printResponse(response, endpoint: 'my server')
    });
  }

  static printRequest(Uri uri) {
    print('sending request Uri: $uri');
  }

  static printResponse(http.Response response, {String endpoint = 'endpoint'}) {
    print('testing $endpoint endpoint response status: ${response.statusCode}\n and body: ${response.body}');
  }
  
}