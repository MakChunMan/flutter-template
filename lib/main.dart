import 'package:flutter/material.dart';
import 'util/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // A widget which will be started on application startup
      home: MyHomePage(title: 'Flutter Demo Jason Page 2'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text(title),
      ),
      body: Center(
          child: ElevatedButton(
        child: Text('Open route'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NextPage(title: '2nd Page')),
          );
        },
      )),
    );
  }
}

class NextPage extends StatefulWidget {
  //const NextPage({Key? key}) : super(key: key);
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State(NextPage){
  
  late Future<String> responseStr;

  const NextPage({@required this.title});

  @override
  void initState() {
    super.initState();
    this.responseStr = sendHttpRequest("https://www.google.com");
    debugPrint("http response:" + this.responseStr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Hello, Jason!',
        ),
      ),
    );
  }
}
