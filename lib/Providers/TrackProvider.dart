
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:zema_multimedia/Shared/Data.dart';

class MusicProvider extends ChangeNotifier{

    // Get New Albums
    Future<dynamic> getNewMusicAPI() async {
      try {
        final response = await http.get(Uri.parse('http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/tracks'),headers: header);
        if (response.statusCode == 200) {
          final result = json.decode(response.body);
          //print(result['results']);
          return result['results'];
        } else {
          print('Error: ${response.reasonPhrase}');
          return null;
        }
      } catch (e) {
        print('Error fetching JSON from the: $e');
        return null;
      }
    }

}