import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/features/chatbot/presentation/widgets/chat_input_box.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';

//TODO: Terjadi error ketika chat lebih dari 2x
//TODO: kayanya ubah package kaya AI Buddy jadinya
// TODO: flutter build apk --split-per-abi --release --obfuscate --split-debug-info=./symbols/
class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final controller = TextEditingController();
  late Gemini gemini;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);
  final List<Content> chats = [];

  @override
  void initState() {
    safeRebuild(() {
      gemini = Gemini.init(
          apiKey: "AIzaSyANwYBDnOPQG7Dg_I9yfKxwFilDN7DHlZo",
          enableDebugging: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F3FAFD"),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          margin: EdgeInsets.only(left: 10.w, bottom: 8.h),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.grey,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Assets.images.botProfile.image(
                width: 45.w,
                height: 45.h,
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Milio",
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Asisten Kehamilanmu",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
        // Add Divider after AppBar content
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1.0, // Adjust height as needed
            color: Colors.grey.withOpacity(0.3), // Adjust color as needed
          ), // Set preferred height
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              reverse: true,
              child: ListView.builder(
                itemBuilder: chatItem,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chats.length,
                reverse: false,
              ),
            ),
          )),
          if (loading) const CircularProgressIndicator(),
          ChatInputBox(
            controller: controller,
            onSend: () {
              if (controller.text.isNotEmpty) {
                final searchedText = controller.text;
                chats.add(
                    Content(role: 'user', parts: [Parts(text: searchedText)]));
                controller.clear();
                loading = true;

                gemini.streamChat(chats).listen((value) {
                  loading = false;
                  setState(() {
                    if (chats.isNotEmpty &&
                        chats.last.role == value.content?.role) {
                      chats.last.parts!.last.text =
                          '${chats.last.parts!.last.text}${value.output}';
                    } else {
                      chats.add(Content(
                          role: 'model', parts: [Parts(text: value.output)]));
                    }
                  });
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget chatItem(BuildContext context, int index) {
    final Content content = chats[index];

    return Container(
      margin: EdgeInsets.only(
          left: content.role == 'model' ? 10 : 60,
          right: 10,
          bottom: 10,
          top: 10),
      decoration: BoxDecoration(
        color: content.role != 'model' ? Colors.blue.shade800 : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(content.role == 'model' ? 0 : 12), // model
          topRight: Radius.circular(content.role == 'model' ? 12 : 0), // model
          bottomRight: const Radius.circular(12),
          bottomLeft: const Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: content.role != 'model' ? Colors.blue.shade800 : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Markdown(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      color:
                          content.role != 'model' ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                    listBullet: TextStyle(
                      color:
                          content.role != 'model' ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  data: content.parts?.lastOrNull?.text ??
                      'Terjadi kesalahan, mohon coba lagi!'),
            ],
          ),
        ),
      ),
    );
  }
}
