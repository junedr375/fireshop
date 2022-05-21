import 'dart:developer';

import 'package:fireshop/features/home/data/models/resturant_model.dart';
import 'package:http/http.dart' as http;

class HomeApiClient {
  Future<Resturant> fetchResturant() async {
    Resturant data = Resturant();
    try {
    final response = await http
          .get(Uri.parse('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad'))
          .timeout(const Duration(seconds: 60))
          .catchError((error) {
        log(error);
      });
      if (response.statusCode == 200) {
        data = resturantModelFromJson(response.body).first;
      }
    } catch (e) {
      log(e.toString());
    }
    return data;
  }
}
