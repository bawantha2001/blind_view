
import 'package:blind_view/models/item.dart';
import 'package:blind_view/repository/shopping_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ShoppingProvider with ChangeNotifier{

  ShoppingProvider();
  final ShoppingRepo _shoppingRepo = ShoppingRepo();

  List <Item> _items= [];
  bool isLoading = false;
  Response? _response;

  List<Item> get items => _items;

  Future<void> getItems({bool isRefresh = false}) async{

    isLoading = true;
    notifyListeners();

    if(isRefresh == true){
      _items = [];
      notifyListeners();
    }

    try{
      _response = await _shoppingRepo.getItem();
      if(_response!=null && _response!.statusCode == 200){
        _items = [];
        var data = _response!.data;
        data.forEach((element){
          _items.add(Item.fromJson(element));
        });
        notifyListeners();
      }
      else{
        print("${_response?.statusCode} = ${_response?.statusMessage}");
      }

      isLoading = false;
      notifyListeners();
    }catch(e){
      print(e);
      isLoading = false;
      notifyListeners();
    }

  }
}