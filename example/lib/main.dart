import 'dart:async';

import 'package:api_call_manager/api_call_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _post;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Api Manager example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Posts:  ${_post ?? "No Data"}',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    getPost();
                  },
                  child: const Text("Click Me"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPost() async {
    final data = await ApiManager()
        .getData(apiUrl: "https://jsonplaceholder.typicode.com/todos/1");
    setState(() => _post = data);
  }
}
