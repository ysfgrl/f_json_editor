import 'dart:convert';

import 'package:f_json_editor/f_json_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FJSONController _fjsonController = FJSONController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("widget.title"),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 400,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: FJSONEditor(
                    controller: _fjsonController,
                    title: Text("FJSON Example"),
                    actionCallback: (actionKey, jsonData) async {
                      if(actionKey == "copy"){
                        await Clipboard.setData(
                          ClipboardData(text: jsonEncode(jsonData)),
                        );
                      }
                    },
                    valueChanged: (key, val) {
                      debugPrint(_fjsonController.getJsonData.toString());
                    },
                    topActions: [
                      FJSONAction(
                          key: "copy",
                          icon: Icon(Icons.copy, size: 20),
                          label: "Copyy"
                      ),
                      FJSONAction(
                          key: "save",
                          icon: Icon(Icons.save, size: 20),
                          label: "Save"
                      )
                    ],
                    isEditable: true,
                    jsonData: {
                      "key1":"value1",
                      "key2":2,
                      "key3": {
                        "key4": "value4",
                        "key5": false,
                        "key6": [
                          "1",
                          "iki"
                        ]
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _fjsonController.setJsonData(
                {
                  "key1":"value1",
                  "key2":2,
                  "key3": {
                    "key4": "value5",
                    "key5": false,
                    "key6": [
                      "1",
                      "iki"
                    ]
                  }
                }
            );
            _fjsonController.setError(true);
          },
          child: Icon(Icons.edit),
        ),// This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

