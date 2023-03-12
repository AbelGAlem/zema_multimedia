
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:zema_multimedia/Shared/Data.dart';

class AlbumProvider extends ChangeNotifier{
    // Get New Albums
    Future<dynamic> getNewAlbumAPI() async {
      try {
        final response = await http.get(Uri.parse('http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/albums'),headers: header);
        if (response.statusCode == 200) {
          final result = json.decode(response.body);
          
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

}