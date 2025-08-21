import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stream_game_app/src/features/main/view/pages/hasanboy_oynasi.dart';


class BlinkApp extends StatelessWidget {
  const BlinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blink',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1EA0FF)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1EA0FF),
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          labelSmall: TextStyle(fontSize: 12, color: Colors.black45),
        ),
      ),
      home: const ChatsPage(),
    );
  }
}

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final List<ChatItem> chats = [
    ChatItem(
      name: 'Jackson',
      message: 'Are you there?',
      time: '02:40 PM',
      avatarUrl:
          'https://miro.medium.com/v2/resize:fit:785/0*Ggt-XwliwAO6QURi.jpg',
      unread: true,
    ),
    ChatItem(
      name: 'Aryan',
      message: "How's your day going?",
      time: '12:20 PM',
      avatarUrl:
          'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?s=612x612&w=0&k=20&c=kPvoBm6qCYzQXMAn9JUtqLREXe9-PlZyMl9i-ibaVuY=',
      unread: true,
    ),
  ];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              _Header(),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: chats.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return ChatTile(item: chats[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1EA0FF),
        onPressed: _addContact,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  void _addContact() {
    final nameController = TextEditingController();
    final messageController = TextEditingController();
    File? pickedImage;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text("Add Contact"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final XFile? img = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (img != null) {
                        setStateDialog(() => pickedImage = File(img.path));
                      }
                    },
                    child: CircleAvatar(
                      radius: 36,
                      backgroundImage: pickedImage != null
                          ? FileImage(pickedImage!)
                          : null,
                      child: pickedImage == null
                          ? const Icon(Icons.camera_alt, size: 32)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.trim().isEmpty) return;
                    setState(() {
                      chats.add(
                        ChatItem(
                          name: nameController.text.trim(),
                          message: messageController.text.isNotEmpty
                              ? messageController.text
                              : "",
                          time: TimeOfDay.now().format(context),
                          avatarUrl: pickedImage?.path ?? '',
                          unread: true,
                          isLocal: pickedImage != null,
                        ),
                      );
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Blink', style: Theme.of(context).textTheme.titleLarge),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF1EA0FF), width: 2),
          ),
          child: const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://static.vecteezy.com/system/resources/thumbnails/020/765/399/small_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg',
            ),
          ),
        ),
      ],
    );
  }
}

class ChatItem {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final bool unread;
  final bool isLocal;

  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    required this.unread,
    this.isLocal = false,
  });
}

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.item});

  final ChatItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyWidget()),
          );
        },

        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: item.avatarUrl.isNotEmpty
                    ? (item.isLocal
                          ? FileImage(File(item.avatarUrl))
                          : NetworkImage(item.avatarUrl) as ImageProvider)
                    : null,
                child: item.avatarUrl.isEmpty ? const Icon(Icons.person) : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.time,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 10),
                  if (item.unread) const _UnreadDot(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnreadDot extends StatelessWidget {
  const _UnreadDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B30),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}


