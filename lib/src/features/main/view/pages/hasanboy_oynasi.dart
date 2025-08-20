
import 'package:flutter/material.dart';
import 'package:stream_game_app/src/features/main/view/pages/1.dart';
import 'package:stream_game_app/src/features/main/view/pages/2.dart';


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final List<Map<String, dynamic>> messages = [
    {
      "image": true,
      "time": "06:20 PM",
      "isMe": false,
    },
    {
      "text": "Thanks Jackson",
      "time": "06:23 PM",
      "isMe": true,
    },
    {"label": "Today"},
    {
      "text": "Hey",
      "time": "02:40 PM",
      "isMe": false,
    },
    {
      "text": "Are you there?",
      "time": "02:40 PM",
      "isMe": false,
    },
    {
      "text": "Hello Jackson",
      "time": "02:45 PM",
      "isMe": true,
    },
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final now = TimeOfDay.now();
    final timeString =
        '${now.hourOfPeriod.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.period == DayPeriod.am ? 'AM' : 'PM'}';

    setState(() {
      messages.add({
        "text": _controller.text.trim(),
        "time": timeString,
        "isMe": true,
      });
      _controller.clear();
    });

    // Scroll pastga tushirish
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Container(
              height: 45,
              width: 45,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwTqEGOxarAmCTJky-hkmKiKm-1WPpgxLO-w&s"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jackson",
                      style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                  Text("Online",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.call_outlined, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => salom()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.videocam, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Haha()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];

                if (msg.containsKey('label')) {
                return Center(
                child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                msg['label'],
                style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                ),
                ),
                ),
                );
                }

                if (msg.containsKey('image')) {
                return Align(
                alignment: Alignment.centerLeft,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                image: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwTqEGOxarAmCTJky-hkmKiKm-1WPpgxLO-w&s"),
                fit: BoxFit.cover,
                ),
                ),
                ),
                Text(msg['time'], style: TextStyle(fontSize: 12)),
                ],
                ),
                );
                }

                return Align(
                alignment: msg['isMe']
                ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Column(
                crossAxisAlignment: msg['isMe']
                ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                color: msg['isMe'] ? Colors.blue : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                msg['text'],
                style: TextStyle(
                color: msg['isMe'] ? Colors.white : Colors.black),
                ),
                ),
                Text(msg['time'], style: TextStyle(fontSize: 12)),
                ],
                ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 70,
            color: Colors.white,
            child: Row(
              children: [
                Icon(Icons.mic, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type Here...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.image, color: Colors.grey),
                SizedBox(width: 10),
                Icon(Icons.emoji_emotions, color: Colors.grey),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}