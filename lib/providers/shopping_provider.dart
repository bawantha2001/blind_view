
import 'dart:convert';

import 'package:blind_view/models/cartItem.dart';
import 'package:blind_view/models/item.dart';
import 'package:blind_view/repository/shopping_repo.dart';
import 'package:blind_view/services/voice_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingProvider with ChangeNotifier{

  ShoppingProvider();
  final ShoppingRepo _shoppingRepo = ShoppingRepo();

  List <Item> _items= [];
  Map<String,List <Item>> _categorizedItems = {};
  List<String> _categoryName = [];
  List<CartItem> _cart =[];
  bool isLoading = false;
  Response? _response;
  int _total=0;

  List<Item> get items => _items;
  List<String> get categoryName=>_categoryName;
  Map<String,List <Item>> get categorizedItems => _categorizedItems;
  List<CartItem> get cart => _cart;
  int get total => _total;


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
        _categorizedItems = {};
        _categoryName = [];
        var data = _response!.data;

        data.forEach((element){
          _items.add(Item.fromJson(element));
        });

        for(var item in _items){
          final category = item.itemCategory??"uncategorized";
          if(!_categorizedItems.containsKey(category)){
            _categorizedItems[category]=[];
          }
          _categorizedItems[category]!.add(item);
        }
        _categoryName.addAll(_categorizedItems.keys.toList());
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

  void addItemToCart(Item item,int quantity){
    if(_cart.isEmpty){

      Map<String,dynamic> data = {
        'itemCode':'${item.itemCode}',
        'itemName':'${item.itemName}',
        'itemQuantity':quantity,
        'itemPrice':item.itemPrice! * quantity,
        'itemImage':item.itemImage
      };

      _cart.add(CartItem.fromJson(data));
    }

    else{
      CartItem? foundItem;
      try{
        foundItem = _cart.firstWhere((element) => element.itemCode == item.itemCode,);
      }catch(e){
        print(e);
      }

      if(foundItem != null){
        int indexOfFoundItem = _cart.indexOf(foundItem);
        _cart[indexOfFoundItem].itemQuantity = (_cart[indexOfFoundItem].itemQuantity??0) + quantity!;
        _cart[indexOfFoundItem].itemPrice = (item.itemPrice??0) * _cart[indexOfFoundItem].itemQuantity!;
      }
      else{
        Map<String,dynamic> data ={
          'itemCode':'${item.itemCode}',
          'itemName':'${item.itemName}',
          'itemQuantity':quantity,
          'itemPrice':item.itemPrice! * quantity,
          'itemImage':item.itemImage
        };
        _cart.add(CartItem.fromJson(data));
      }
    }
    notifyListeners();
  }

  void calculateTotal(){
    _total =0;
    _cart.forEach((element) {
      _total += element.itemPrice!;
    },
    );
    notifyListeners();
  }

  void removeCart(int elementNo){
    if(_cart != null){
      VoiceService().speak("${_cart.elementAt(elementNo).itemName} removed from Cart");
      _cart.removeAt(elementNo);
      calculateTotal();
    }
   notifyListeners();
  }

  Future<void> saveCartinFav(List<CartItem> favCart) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartJson = jsonEncode(favCart.map((e) => e.toJson()).toList());
    await prefs.setString('favCart', cartJson).then((onValue){
      VoiceService().speak("Items added to favourite");
    });
    print("saved successfull");
  }

  Future<void> loadCartfav()async{
    final prefs = await SharedPreferences.getInstance();
    final favCartjson = prefs.getString("favCart");

    if(favCartjson !=null){
      final List<dynamic> cartList = jsonDecode(favCartjson);
      _cart = [];
      _total = 0;
      notifyListeners();

      cartList.forEach((element) {
        _cart.add(CartItem.fromJson(element));
      },);
      VoiceService().speak("Items loaded");
      notifyListeners();
      calculateTotal();
    }
    else{
      print("No Cart Items");
    }
  }

}