import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseMessaging messaging;
  List<String> messageList = [];
  @override
  void initState() {
    super.initState();
    print('init state');
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("conti");
    messaging.getToken().then((value) {
      print('app tokes id: $value');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      print(event.data.values);
      setState(() {
        messageList.add(event.notification!.body ?? '--');
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      setState(() {
        messageList.add(message.notification!.body ?? '--');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push notifi demo'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('hola mundo'),
            Column(
              children: messageList.map((e) => Text(e)).toList(),
            )
          ],
        ),
      ),
    );
  }
}
