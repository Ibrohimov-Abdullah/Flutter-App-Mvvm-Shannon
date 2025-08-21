import 'package:flutter/material.dart';

class Haha extends StatefulWidget {
  const Haha({super.key});

  @override
  State<Haha> createState() => _HahaState();
}

class _HahaState extends State<Haha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 950,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwTqEGOxarAmCTJky-hkmKiKm-1WPpgxLO-w&s",
            ),
            fit: BoxFit.cover,
          ),
          color: Colors.blue,
        ),
        child: Column(
          children: [
            SizedBox(height: 50,),
                    Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  SizedBox(width: 10,),
                  Text("End-to-end Encrypted",style: TextStyle(fontSize: 20,color: Colors.white)),
                  Spacer()
                ]
            ),
            SizedBox(height:20),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwTqEGOxarAmCTJky-hkmKiKm-1WPpgxLO-w&s"), fit: BoxFit.cover),
                  color: Colors.blue
              ),
            ),
            SizedBox(height:20),
            Text("Jackson\nRinging..", style: TextStyle(color: Colors.white),),
            SizedBox(height: 400,),
            Container(
              height: 85,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(100),
                  bottom: Radius.circular(100),
                ),

              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:Row(
                children:[
              IconButton(
              icon :Icon(Icons.videocam,size: 50.0, color: Colors.grey),
                    onPressed: () {
                      Navigator.pop(context);
                          },
                       ),
                      IconButton(
                        icon : Icon(Icons.mic_off,size: 50.0, color: Colors.grey),
                          onPressed: () {
                            Navigator.pop(context);
                                },
                               ),
                        IconButton(
                          icon :  Icon(Icons.volume_up,size: 50.0,color: Colors.grey),
                            onPressed: () {
                              Navigator.pop(context);
                                       },
                                    ),
                          IconButton(
                            icon : Icon(Icons.call_outlined,size: 50.0, color: Colors.red),
                              onPressed: () {
                                Navigator.pop(context);
                   },
                  ),
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}