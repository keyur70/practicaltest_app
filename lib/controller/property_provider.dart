import 'package:flutter/cupertino.dart';
import 'package:practical_app/api_provider/product_api.dart';
import 'package:practical_app/model/property_data_model.dart';
import 'package:practical_app/model/response_model.dart';

class PropertyController extends ChangeNotifier {
  //---------------------------- Api Instant--------------------------------//
  PropertyApiProvider propertyApiProvider = PropertyApiProvider();

  //---------------------------- Model Instant--------------------------------//
  ResponseModel<PropertyDataModel> fetchPropertyData =
      ResponseModel<PropertyDataModel>();

  //---------------------------- Functions --------------------------------//
  Future<ResponseModel<PropertyDataModel>> propertyController() async {
    fetchPropertyData = await propertyApiProvider.getPropertyApi();
    notifyListeners();
    return fetchPropertyData;
  }
}
