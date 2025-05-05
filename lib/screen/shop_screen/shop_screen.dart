import 'package:blind_view/providers/shopping_provider.dart';
import 'package:blind_view/screen/shop_screen/mobileScanner_Screen/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:voice_to_text/voice_to_text.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Welcome to Shopeyes",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800)),
      ),
      body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async{
              refresh();
            },
            child: ListView(
              children: [
                Container(
                  color: Color.fromRGBO(248, 249, 250, 1),
                  padding: EdgeInsets.symmetric(horizontal:20,vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Padding(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4),blurRadius: 1,offset: Offset(-4, 4))],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.spatial_audio_off ,size: 30,color: Colors.blue,),
                                      SizedBox(width: 5,),
                                      Column(
                                        children: [
                                          Text("Available Commands",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.circle,size: 8,color: Colors.grey),
                                            SizedBox(width: 5,),
                                            Text("\"Add  [item] to cart\"",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Icon(Icons.circle,size: 8,color: Colors.grey),
                                            SizedBox(width: 5,),
                                            Text("\"Create new list\"",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Icon(Icons.circle,size: 8,color: Colors.grey),
                                            SizedBox(width: 5,),
                                            Text("\"Show my lists\"",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 150,
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4),blurRadius: 1,offset: Offset(-4, 4))],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Speak Clearly",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                        SizedBox(height: 10,),
                                        Text("Use a clear voice and speak at a normal nace",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Flexible(
                                  child: Container(
                                    height: 150,
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4),blurRadius: 1,offset: Offset(-4, 4))],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Be Specific",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                        SizedBox(height: 10,),
                                        Text("Mention item names and quantities clearly",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
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
