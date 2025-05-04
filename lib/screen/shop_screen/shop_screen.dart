import 'package:blind_view/providers/shopping_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
      Provider.of<ShoppingProvider>(context,listen: false).getItems();
    });

  }

  void refresh(){
    Provider.of<ShoppingProvider>(context,listen: false).getItems(isRefresh: true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async{
              refresh();
            },
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height,
                  color: Color.fromRGBO(248, 249, 250, 1),
                  padding: EdgeInsets.symmetric(horizontal:20,vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.camera_alt_outlined,color: Colors.white,),
                                SizedBox(width: 5,),
                                Text("Scan Item",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),

                          SizedBox(width: 20,),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.mic_none_rounded,color: Colors.white,),
                                SizedBox(width: 5,),
                                Text("Voice Search",style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text("Featured Items",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800)),
                      SizedBox(height: 10,),
                      Consumer<ShoppingProvider>(builder: (context, shop_item, child) {
                        return shop_item.items != null && shop_item.isLoading != true? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 220,
                          child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: shop_item.items.length ,itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  width: 180,
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
                                      Flexible(child: ClipRRect(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),child: Image.asset("assets/images/test.jpg",fit: BoxFit.cover))),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Column(
                                          children: [
                                            Text("${shop_item.items[index].itemName}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                            Text("Rs.${shop_item.items[index].itemPrice}",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500),),
                                          ],
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                              },
                          ),
                        ): Container(
                          width: MediaQuery.of(context).size.width,
                          height: 220,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.blue,)
                            ],
                          ),
                        );
                      },
                      ),
                      SizedBox(height: 20,),
                      Text("Shopping Tips",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800)),
                      SizedBox(height: 30,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4),blurRadius: 1,offset: Offset(-4, 4))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Voice Commands",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                            SizedBox(height: 10,),
                            Text("Say \"Add to cart \" to quickly add items to your shopping list",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4),blurRadius: 1,offset: Offset(-4, 4))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Shake to Access Lists",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                            SizedBox(height: 10,),
                            Text("Shake your device to quickly access your frequently bought items.",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
