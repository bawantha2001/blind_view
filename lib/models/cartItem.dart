class CartItem{
  final String? itemCode;
  final String? itemName;
  int? itemQuantity;
  int? itemPrice;
  final String? itemImage;

  CartItem({this.itemCode,this.itemName,this.itemPrice,this.itemQuantity,this.itemImage});

  factory CartItem.fromJson(Map<String,dynamic> data){
    return CartItem(
        itemCode: data['itemCode'],
        itemName: data['itemName'],
        itemQuantity: data['itemQuantity'],
        itemPrice: data['itemPrice'],
      itemImage: data['itemImage'],
    );
  }

  Map<String, dynamic> toJson() => {
    'itemCode': itemCode,
    'itemName': itemName,
    'itemPrice': itemPrice,
    'itemQuantity': itemQuantity,
    'itemImage':itemImage,
  };
}