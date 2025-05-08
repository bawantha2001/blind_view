class CartItem{
  final String? itemCode;
  final String? itemName;
  int? itemQuantity;
  int? itemPrice;

  CartItem({this.itemCode,this.itemName,this.itemPrice,this.itemQuantity});

  factory CartItem.fromJson(Map<String,dynamic> data){
    return CartItem(
        itemCode: data['itemCode'],
        itemName: data['itemName'],
        itemQuantity: data['itemQuantity'],
        itemPrice: data['itemPrice']
    );
  }

  Map<String, dynamic> toJson() => {
    'itemCode': itemCode,
    'itemName': itemName,
    'itemPrice': itemPrice,
    'itemQuantity': itemQuantity,
  };
}