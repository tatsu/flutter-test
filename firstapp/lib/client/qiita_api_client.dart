import 'dart:io';
import 'dart:async';
import 'dart:convert' show UTF8, LineSplitter;


class QiitaClient {

  static const String _api_root = "http://qiita.com/api/";

  Future<String> get() async {

    var completer = new Completer<String>();

    var client = new HttpClient();
    var request = await client.getUrl(Uri.parse(_api_root + "/v2/items"));

    var response = await request.close();
    var result = "";
    await for (var contents in response.transform(UTF8.decoder).transform(const LineSplitter())) {
      result += contents;
    }

    completer.complete(result);

    return completer.future;
  }
}