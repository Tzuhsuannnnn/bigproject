import 'package:flutter/material.dart';
import 'package:view/constants/route.dart';
import 'package:view/models/Chat_Record.dart';
import 'package:view/services/chatrecord_svs.dart';
import 'package:quickalert/quickalert.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<ChatRecord> chatrecords = [];

  void createChatRecord(ChatRecord chatrecord) async {
    chatrecords.add(chatrecord);
    Chatrecord_SVS service = Chatrecord_SVS(chatrecords: chatrecords);
    await service.createChatRecord();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double placeholderWidth = (MediaQuery.of(context).size.width - 40) / 4; // Subtracting padding and margins

    List<Widget> iconPlaceholders = List.generate(8, (index) {
      return Container(
        width: placeholderWidth,
        height: placeholderWidth,
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(8), // Space around each placeholder
      );
    });
    return Scaffold(
      backgroundColor: Color(0xFFE9F5EF),
      body: Column(
        children: [
          // Top section with gradient background image
          Stack(
            children: [
              Image.asset(
                'assets/home_background.jpg', // Replace with your image
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 16,
                top: 100,
                child: Text(
                  'byebyesore.',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),

          // Spacer to fill the gap between sections
          Spacer(flex: 1),

          // Middle section with icons
          Container(
            padding: EdgeInsets.all(16),
            child: _buildIconWithBackground(iconPlaceholders),
          ),

          // Spacer to fill the gap between sections
          Spacer(flex: 2),

          // New Chat section
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () async {
                    late ChatRecord chatRecord;
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.custom,
                      barrierDismissible: true,
                      confirmBtnText: '確認新增',
                      title: '新增Chat Room',
                      confirmBtnColor: Colors.green,
                      widget: TextFormField(
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          hintText: '請輸入名稱',
                        ),
                        textInputAction: TextInputAction.next,
                        onChanged: (value) =>
                        chatRecord = ChatRecord(
                            id: "",
                            userId: "",
                            message: [],
                            suggestedVideoIds: [],
                            name: value,
                            timestamp: "",
                            finish: "no"),
                      ),
                      onConfirmBtnTap: () async {
                        if (chatRecord.name.length < 5) {
                          await QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            text: 'Please input something',
                          );
                          return;
                        }
                        if (chatrecords.any((element) =>
                        element.name == chatRecord.name)) {
                          await QuickAlert.show(
                            context: context,
                            type: QuickAlertType.warning,
                            text: '該名稱已存在!',
                            confirmBtnText: '確認',
                            title: '該名稱已存在!',
                            confirmBtnColor: Colors.green,
                          );
                          return;
                        }
                        Navigator.pop(context);
                        createChatRecord(chatRecord);
                        await Future.delayed(const Duration(milliseconds: 300));
                        Navigator.pushNamed(
                            context, Routes.chatView, arguments: chatRecord);
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green[50],
                        child: Icon(Icons.add, color: Color.fromRGBO(56, 107,
                            79, 1)),
                      ),
                      SizedBox(width: 70),
                      Center(
                        child: Text(
                          'New Chat',
                          style: TextStyle(color: Color.fromRGBO(
                              56, 107, 79, 1), fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Spacer(flex: 1),

        ],
      ),
    );
  }

  Widget _buildIconWithBackground(List<Widget> placeholders) {
    return Container(
      color: Colors.white, // White background container
      padding: EdgeInsets.all(8), // Optional padding
      child: Wrap(
        spacing: 8, // Space between items horizontally
        runSpacing: 8, // Space between lines vertically
        children: placeholders,
      ),
    );
  }

  Widget _buildIconPlaceholder() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(8), // Space around each placeholder
    );
  }
}
