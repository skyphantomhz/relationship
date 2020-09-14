import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage("https://image.freepik.com/free-vector/cartoon-monster-face-avatar-halloween-monster_6996-1164.jpg"),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
