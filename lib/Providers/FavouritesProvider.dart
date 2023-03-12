
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:zema_multimedia/Shared/Data.dart';

class FavouritesProvider extends ChangeNotifier{

    // Get New Albums
    Future<dynamic> getFavoritesAPI() async {
      try {
        final response = await http.get(Uri.parse('http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/favourites'),headers: header);
        if (response.statusCode == 200) {
          final result = json.decode(response.body);
          //print(result['results']);
          return result['results'];
        } else {
          print('Error: ${response.reasonPhrase} --------------------- ${response.statusCode}');
          return null;
        }
      } catch (e) {
        print('Error fetching JSON from : $e -------');
        return null;
      }
    }

      Future<dynamic> addToFavoritesAPI(String userFUI, String trackID) async {
        try {
            var data = '{\n  "user_FUI": "${userFUI}",\n  "track_id": ${trackID}\n}';
            var url = Uri.parse('https://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/favourites');
            var res = await http.post(url, headers: headers, body: data);
            //print(res.body);
            if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
        } catch (e) {
          print('Error fetchin JSON from: $e');
          return null;
        }
      }
  //
      Future<dynamic> deleteToFavoritesAPI(String trackID) async {
        try {
            var url = Uri.parse('https://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/favourites/6');
            print('${url.data} ${url}');
            var res = await http.delete(url, headers: headers);
            if (res.statusCode != 200) throw Exception('http.posts error: statusCode= ${res.statusCode}');
        } catch (e) {
          print('Error fetching JSON froms: $e');
          return null;
        }
      }

}