import 'package:flutter/material.dart';
import 'package:topic6/models/newidol.dart';
import 'package:topic6/screens/home/settingsform.dart';
import 'package:topic6/services/auth.dart';
import 'package:topic6/services/database.dart';
import 'package:provider/provider.dart';
import 'package:topic6/screens/home/idollist.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Idol>>.value(
      value: DatabaseService().idol,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Molten Fox'),
          backgroundColor: Colors.orangeAccent,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/image3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: IdolList(),
        ),
      ),
    );
  }
}
