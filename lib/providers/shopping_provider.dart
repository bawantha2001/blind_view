
import 'package:blind_view/models/cartItem.dart';
import 'package:blind_view/models/item.dart';
import 'package:blind_view/repository/shopping_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ShoppingProvider with ChangeNotifier{

  ShoppingProvider();
  final ShoppingRepo _shoppingRepo = ShoppingRepo();

  List <Item> _items= [];
  Map<String,List <Item>> _categorizedItems = {};
  List<String> _categoryName = [];
  List<CartItem> _cart =[];
  bool isLoading = false;
  Response? _response;

  List<Item> get items => _items;
  List<String> get categoryName=>_categoryName;
  Map<String,List <Item>> get categorizedItems => _categorizedItems;
  List<CartItem> get cart => _cart;


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
    Map<String,dynamic> data ={
      'itemCode':'${item.itemCode}',
      'itemName':'${item.itemName}',
      'itemQuantity':quantity,
      'itemPrice':item.itemPrice! * quantity
    };
    _cart.add(CartItem.fromJson(data));
    print(_cart.length);
    notifyListeners();
  }
}