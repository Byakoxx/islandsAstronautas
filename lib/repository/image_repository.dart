import 'dart:developer';

import 'package:Islands/provider/islands_provider.dart';
import 'package:http/http.dart' as http;

import '../model/image_model.dart';

Future<Map<String, dynamic>> fetchImages(IslandsProvider islandsProvider) async {
  Map<String, dynamic> callback = {};

  try {

    var url = Uri.parse('https://api.giphy.com/v1/gifs/search?q=${islandsProvider.query}&api_key=sPYHdKcHTPU33roqNueD5GH0iNQuUG4m&limit=20');
    var response = await http.get( url ).timeout(
      const Duration(seconds: 20), onTimeout:
      () {
        return http.Response('Error', 408);
      }
    );

    switch (response.statusCode) {
      case 200: {
        final imageModel = ImageModel.fromJson(response.body);

        callback['status'] = true;
        callback['body'] = imageModel;
        callback['error'] = null;
        break;
      }
      case 408: {
        callback['status'] = false;
        callback['body'] = null;
        callback['error'] = "TIME_OUT";
        break;
      }
      default: {
        callback['status'] = false;
        callback['body'] = null;
        callback['error'] = "ENDPOINT_ERROR";
        break;
      }
    }

  } catch (e,s) {

    log("Endpoint Error ==> Exception $e");
    log("Endpoint Error ==> StackTrace $s");

    callback['status'] = false;
    callback['body'] = null;
    callback['error'] = "EXCEPTION_ERROR";

  }

  return callback;
}


Future<List<Datum>> searchGif(String query) async {
  var url = Uri.parse('https://api.giphy.com/v1/gifs/search?q=$query&api_key=sPYHdKcHTPU33roqNueD5GH0iNQuUG4m&limit=20');

  final response = await http.get(url);

  final searchResponse = ImageModel.fromJson(response.body);

  return searchResponse.data;

}