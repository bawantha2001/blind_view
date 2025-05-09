import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

import '../../providers/shopping_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}


class _CartScreenState extends State<CartScreen> {
  ShakeDetector? shakeDetector;


  void shakeStarter(){
    shakeDetector?.stopListening();

    shakeDetector = ShakeDetector.autoStart(
        onPhoneShake: (event) {
          switch (event.direction){
            case ShakeDirection.x:
              Provider.of<ShoppingProvider>(context,listen: false).loadCartfav();
              break;
            case ShakeDirection.y:
              print("left right detected");
              break;
            case ShakeDirection.z:
              print("left right detected");
              break;
            case ShakeDirection.undefined:
              print("left right detected");
              break;
          }
        },
        useFilter: false,
        shakeThresholdGravity: 1.1
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      shakeStarter();
      Provider.of<ShoppingProvider>(context,listen: false).calculateTotal();
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    shakeDetector?.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text("Your Cart",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800)),
            Spacer(),
            Consumer<ShoppingProvider>(builder: (BuildContext context, shopping, Widget? child) {
              return Row(
                children: [
                  shopping.cart.isNotEmpty?GestureDetector(
                      child: Icon(Icons.favorite_border),
                    onTap: (){
                        Provider.of<ShoppingProvider>(context,listen: false).saveCartinFav(shopping.cart);
                    },
                  ):SizedBox(),
                  SizedBox(width: 10,),
                  Text("Total: ${shopping.total.toDouble().toStringAsFixed(2)}",style: TextStyle(color: Colors.red),),
                ],
              );
            }),

            // GestureDetector(
            //   onTap: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => ScannerScreen(),));
            //   },
            //     child: Icon(Icons.qr_code,size: 30,color: Colors.blue,)
            // )

          ],
        ),
      ),
      body: Container(
        color: Color.fromRGBO(248, 249, 250, 1),
        padding: EdgeInsets.symmetric(horizontal:20,vertical: 15),
        child: Consumer<ShoppingProvider>(builder: (context, shopping, child) {
          return shopping.cart.isNotEmpty?GridView.builder(itemCount: shopping.cart.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.4),blurRadius: 1,offset: Offset(-4, 4)),
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(child:
                    Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                          child: CachedNetworkImage(
                            imageUrl: shopping.cart.elementAt(index).itemImage.toString(),
                            placeholder: (context, url) => Image.asset("assets/images/load.gif",fit: BoxFit.cover),
                            errorWidget: (context, url, error) => Image.asset("assets/images/no_item.png",fit: BoxFit.fill),
                            fit: BoxFit.cover,
                          ),),
                    )),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text("${shopping.cart.elementAt(index).itemName}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                              Text("Rs.${shopping.cart.elementAt(index).itemPrice}",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500),),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Text("${shopping.cart.elementAt(index).itemQuantity}",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w800),),
                              SizedBox(width: 10,),
                              GestureDetector(
                                onTap: (){
                                  Provider.of<ShoppingProvider>(context,listen: false).removeCart(index);
                                },
                                  child: Icon(Icons.delete,size: 30,))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ):Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/item_added.png",width: 250,height: 250,),
              ],
            ),
          );
        },
        ),
      ),
    );
  }
}
