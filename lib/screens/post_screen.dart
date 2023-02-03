import 'package:flutter/material.dart';

enum ConfirmAction { Cancel, Accept }

class PostScreen extends StatefulWidget {
  // const PostScreen({Key? key}) : super(key: key);

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
                      } else {
                        showAlertDialog(context);
                      }
                    });
                  })
            ],
          )),
      Expanded(
          child: Container(
              padding: const EdgeInsets.all(8),
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
                        final ConfirmAction? action =
                            await _asyncConfirmDialog(context);
                        if (action == ConfirmAction.Accept) {
                          setState(() {
                            widget.removeItem(index);
                          });
                        }
                      },
                    ),
                  ]));
                },
              )))
    ]));
  }
}

// alert dialog when adding empty item
showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: const Text("This field is required."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// confirmation dialog when removing the item
Future<ConfirmAction?> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm'),
        content: const Text('Are you sure to delete this item?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Cancel);
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Accept);
            },
          )
        ],
      );
    },
  );
}
