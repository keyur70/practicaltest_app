import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:practical_app/model/property_data_model.dart';
import 'package:practical_app/model/response_model.dart';

class PropertyApiProvider {
  //---------------------------- Property Api Provider--------------------------------//
  Future<ResponseModel<PropertyDataModel>> getPropertyApi() async {
    var response =
        await rootBundle.loadString('assets/json/property_response.json');
    return ResponseModel(
      isStatus: true,
      responseData: PropertyDataModel.fromJson(
        json.decode(response),
      ),
    );
  }
}
