import 'package:chatbot_app/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('lib/asset/bot.json',
            width: 300,
            height: 400),
            const SizedBox(height: 20,),
        
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=> ChatPage()));
              },
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 151, 211, 238)
                ),
                child:const Center(child: Text('Let\'s Start!')),
              ),
            )
          ],
        ),
      ),
    );
  }
}