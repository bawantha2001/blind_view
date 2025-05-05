import 'package:flutter/material.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}


class _VoiceScreenState extends State<VoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text("Voice Commands",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w800)),
            Spacer(),
            Icon(Icons.help_outline_sharp,size: 30,color: Colors.blue,)
          ],
        ),
      ),
      body: Container(
        color: Color.fromRGBO(248, 249, 250, 1),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  height: 250,
                  child: Stack(
                      children: [
                    Image.asset("assets/images/voice_command.jpg",fit: BoxFit.cover,height: 250,),
                    Align(
                      alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 70,
                          width: 70,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue
                          ),
                          child: Icon(Icons.mic_none_rounded,size: 40,color: Colors.white,),
                        )
                    )
                  ]
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
            )
          ],
        ),
      ),
    );
  }
}
