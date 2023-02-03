import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  Function addItem;
  Function removeItem;
  List<String> items;

  PostScreen(this.items, this.addItem, this.removeItem);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String text = ''; // Input Text State
  final textController = TextEditingController(); // Input Controller

  // Initial State and Listener
  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    textController.addListener(() {
      setState(() {
        text = textController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                controller: textController,
                autofocus: true,
                style: const TextStyle(fontSize: 20),
              )),
              IconButton(
                  icon: const Icon(Icons.add_circle_rounded),
                  iconSize: 40,
                  tooltip: 'Add',
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      // if the input is not empty add item to the item list
                      if (text.isNotEmpty) {
                        widget.addItem(text);
                        textController.text = '';
                      }
                    });
                  })
            ],
          )),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: widget.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return IntrinsicHeight(
                          child: Row(children: [
                        Expanded(
                            child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(5),
                          child: Center(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical, //.horizontal
                                  child: Text(
                                    widget.items[index],
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ))),
                          height: 50,
                        )),
                        IconButton(
                            icon: const Icon(Icons.remove_circle_rounded),
                            iconSize: 40,
                            tooltip: 'Remove',
                            color: Colors.red,
                            onPressed: () async {
                              setState(() {
                                widget.removeItem(index);
                              });
                            }),
                      ]));
                    }),
              )))
    ]));
  }
}
