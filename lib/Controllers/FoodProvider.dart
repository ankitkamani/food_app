import 'package:flutter/material.dart';
import 'package:food_app/Controllers/ApiHelper.dart';
import 'package:food_app/Modals/FoodModal.dart';

class FoodProvider extends ChangeNotifier {

  FoodModal? foodData;
  String Options = '';
  String size = '';
  List<bool> toppings = [
    false,
    false,
    false,
  ];

  double total = 0.0;
  int itemCount=1;

  void increment(int index){
    itemCount = index;
    notifyListeners();
  }

  void decrement(int index){
    itemCount = index;
    notifyListeners();
  }

  void addAmount(
      {required int mainIndex,
        required FoodModal foodModal,
        int sizeIndex = 0,
        int optionIndex = 0}) {
    double tempAmount = 0.0;
    tempAmount +=
        foodModal.foods?[mainIndex].sizes?[sizeIndex].discountedPrice ?? 0.0;
    tempAmount +=
        foodModal.foods?[mainIndex].options?[optionIndex].discountedPrice ??
            0.0;

    for(int i=0;i<toppings.length;i++){
      if(toppings[i]==true){
        tempAmount+=foodModal.foods?[mainIndex].toppings?[i].discountedPrice??0.0;
      }
    }

    total = tempAmount;
    notifyListeners();
  }

  void optionsChange(String value){
    Options = value;
    notifyListeners();
  }
  void sizeChange(String value){
    size = value;
    notifyListeners();
  }

  void getFoodList()async{
     foodData =await ApiHelper.apiHelper.getData();
     notifyListeners();
  }

  void changecheck(int index){
    toppings[index] = !toppings[index];
    notifyListeners();
  }



}