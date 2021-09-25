import 'package:flutter/material.dart';
import 'package:sheet_actions_test/action_sheet.dart';

void main() {
  runApp(Test());
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("sheet_actions"),
        ),
        body: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("showBottomActionSheet"),
        onPressed: () {
          showBottomActionSheet(
            context: context,
            widgetPositioning: WidgetPositioning.mainAxis,
            children: [
              Icon(
                Icons.class_,
                color: Colors.white,
              ),
              Icon(
                Icons.folder,
                color: Colors.white,
              ),
              Icon(
                Icons.note_add,
                color: Colors.white,
              ),
            ],
            descriptions: [
              Text("Class"),
              Text("Folder"),
              Text("Note"),
            ],
            actions: [],
            titleText: Text(
              "Add",
              style: TextStyle(fontSize: 25),
            ),
          );
        },
      ),
    );
  }
}
