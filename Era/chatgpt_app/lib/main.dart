import 'package:chatgpt_app/screen/frame/frame_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: ChatGPTApp()));
}

class ChatGPTApp extends StatelessWidget {
  const ChatGPTApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPTApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.roboto().fontFamily),
      home: FrameScreen(),
    );
  }
}
