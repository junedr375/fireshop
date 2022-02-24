import 'package:fireshop/features/home/data/api_client/api_client.dart';
import 'package:fireshop/features/home/data/models/resturant_model.dart';

class HomeRepository {
  final HomeApiClient homeApiClient;

  HomeRepository({required this.homeApiClient});

  ///TO get the Resturnat Data
  Future<Resturant> getResturantData() async {
    return await homeApiClient.fetchResturant();
  }
}
