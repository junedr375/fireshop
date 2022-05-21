import 'package:fireshop/features/home/data/api_client/api_client.dart';
import 'package:fireshop/features/home/data/models/resturant_model.dart';


///Repository Will FullFill the contract and Fetch The Data from Data Layer
///And send it back to UseCase/Controller
class HomeRepository {
  final HomeApiClient homeApiClient;

  HomeRepository({required this.homeApiClient});

  ///TO get the Resturnat Data
  Future<Resturant> getResturantData() async {
    return await homeApiClient.fetchResturant();
  }
}
