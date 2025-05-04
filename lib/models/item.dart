import 'dart:core';

class Item{
  final String? itemCode;
  final String? itemName;
  final String? itemCategory;
  final int? itemPrice;
  final int? itemQuantity;

  Item({this.itemCode,this.itemName,this.itemCategory,this.itemPrice,this.itemQuantity});

  factory Item.fromJson(Map<String,dynamic> json){
    return Item(
        itemCode: json['itemCode'],
        itemName: json['itemName'],
        itemCategory: json['itemCategory'],
        itemQuantity: json['itemQuantity'],
        itemPrice: json['itemPrice']
    );
  }

}