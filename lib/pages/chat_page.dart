import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Gemini gemini=Gemini.instance;
  ChatUser currentUser= ChatUser(id: '0',firstName: 'see me');
  ChatUser geminiUser=ChatUser(id:'1',firstName: 'Gemini',profileImage:  "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png",);
  List<ChatMessage> messages=[];
  List<ChatUser> typingUser=<ChatUser> [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Gemini',
      ),
        centerTitle: true,
      
      ),
      backgroundColor:Colors.grey[200],
      body: DashChat(
        currentUser: currentUser,
         onSend: sendMessage,
          messages: messages,
          typingUsers:typingUser,),
    );
  }
  void sendMessage(ChatMessage m){
    setState(() {
    
      messages=[m,...messages];
      typingUser.add(geminiUser);
    });
    try{ List<Uint8List>? images;
      if (m.medias?.isNotEmpty ?? false) {
        images = [
          File(m.medias!.first.url).readAsBytesSync(),
        ];
      }
      String question=m.text;
          gemini.streamGenerateContent(question).listen((event){
            
              ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(
            () {
              messages = [lastMessage!, ...messages];
            },
          );
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
          });
    }
    catch(e){
      print(e);
    }
    finally {
    setState(() {
      typingUser.remove(geminiUser);
    });
  }
}}