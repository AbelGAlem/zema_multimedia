
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ArtistProvider extends ChangeNotifier{

    var header = {
      'accept': 'application/json',
      'X-CSRFToken': 'jIgxc8zID18s8GDz8VGYQGHzKzApGF2QXFTfN52nK6ft8F3NBO0Xq1fukLdvpQx1',
    };

    // Get New Albums
    Future<dynamic> getNewArtistsAPI() async {
      try {
        final response = await http.get(Uri.parse('http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/artists?page=2&page_size=5'),headers: header);
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

}