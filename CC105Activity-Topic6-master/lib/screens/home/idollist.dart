import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topic6/models/newidol.dart';
import 'package:topic6/screens/home/idoltile.dart';

class IdolList extends StatefulWidget {
  @override
  _IdolListState createState() => _IdolListState();
}

class _IdolListState extends State<IdolList> {
  @override
  Widget build(BuildContext context) {
    final idol = Provider.of<List<Idol>>(context) ?? [];

    return ListView.builder(
      itemCount: idol.length,
      itemBuilder: (context, index) {
        return IdolTile(idol: idol[index]);
      },
    );
  }
}
