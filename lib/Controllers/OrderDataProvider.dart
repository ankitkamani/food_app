import 'package:flutter/material.dart';
import 'package:food_app/Modals/OrderDataModal.dart';

class OrderDataProvider extends ChangeNotifier {
  List<OrderDataModal> orderDataList = [];
  double tips=0.0;
  int tipsType=4;

  void selectTipsType(int index){
    tipsType=index;
    notifyListeners();
  }

  void addTips(double value){
    tips=value;
    notifyListeners();
  }


  void addOrderData(
      {required String name,
      required List<Options> toppings,
      required Options options,
      required Sizes sizes,
      required bool inStock,
      required bool isVegetarian,
      required String img,
      required int totalQuantity,
      required int id}) {
    orderDataList.add(OrderDataModal(
        food: Food(
            name: name,
            toppings: toppings,
            options: options,
            sizes: sizes,
            inStock: inStock,
            isVegetarian: isVegetarian,
            img: img),
        totalQuantity: totalQuantity,
        id: id));
    notifyListeners();
  }

  int get total {
    int quantity = 0;
    for (var element in orderDataList) {
      quantity += element.totalQuantity;
    }
    return quantity;
  }

  double totalPrizeWithIngredient(int id) {
    double tempAmount = 0.0;
     orderDataList.forEach((element) {
      if(element.id == id){
        double tempTopping=0.0;
        element.food.toppings.forEach((element) {
          tempTopping+=element.discountedPrice;
        });
       tempAmount = (element.food.sizes.discountedPrice+element.food.options.discountedPrice+tempTopping)*element.totalQuantity;
      }
    });
    return tempAmount;
  }

  double get totalAmount {
    double amount = 0;
    for (int i = 0; i < orderDataList.length; i++) {
      double tempTopping = 0.0;
      for (var element2 in orderDataList[i].food.toppings) {
        tempTopping += element2.discountedPrice;
      }
      amount += (orderDataList[i].food.sizes.discountedPrice +
              orderDataList[i].food.options.discountedPrice +
              tempTopping) *
          orderDataList[i].totalQuantity;
    }
    return amount;
  }

  void increment(int id) {
    orderDataList.forEach((element) {
      if (element.id == id) {
        element.totalQuantity++;
      }
    });
    notifyListeners();
  }

  int getItemCount(int id){
    int count=0;
    orderDataList.forEach((element) {
      if(element.id==id){
        count=element.totalQuantity;
      }
    });
    return count;
  }

  void decrement(int id) {
    List ids = [];
    orderDataList.forEach((element) {
      if (element.id == id) {
        if (element.totalQuantity > 1) {
          element.totalQuantity--;
        }else{
          ids.add(id);
        }
      }
    });
    orderDataList.removeWhere((element) => ids.contains(element.id));
    notifyListeners();
  }
}
