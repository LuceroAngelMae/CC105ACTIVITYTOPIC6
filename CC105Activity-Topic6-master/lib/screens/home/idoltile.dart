import 'package:flutter/material.dart';
import 'package:topic6/models/newidol.dart';

class IdolTile extends StatelessWidget {
  final Idol idol;
  IdolTile({this.idol});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.orange[idol.love],
          ),
          title: Text(idol.name),
          subtitle: Text('Loves ${idol.idol}'),
        ),
      ),
    );
  }
}
