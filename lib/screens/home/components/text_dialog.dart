import 'package:flutter/material.dart';

import '../../../constants.dart';

class TextDialog extends StatelessWidget {
  final String input;
  String title;
  TextDialog(this.input, {this.title = "Lowercase text"});

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textController.text = input;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultRounded)),
      child: Padding(
        padding: EdgeInsets.only(top: kDefaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: kTextSufaceColor)),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: kContentPadding, vertical: 0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Update Info",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: kContentPadding, vertical: 0)),
                controller: _textController,
              ),
            ),
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                Navigator.pop(context, _textController.text);
              },
            )
          ],
        ),
      ),
    );
  }
}
