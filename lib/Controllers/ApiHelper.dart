
import 'package:flutter/services.dart';
import 'package:food_app/Modals/FoodModal.dart';

class ApiHelper{
  ApiHelper._();
  static final ApiHelper apiHelper =  ApiHelper._();

  Future<FoodModal> getData()async{
    String jsonData = await rootBundle.loadString('assets/food.json');
    FoodModal foodModal = foodModalFromJson(jsonData);
    return foodModal;
  }
}