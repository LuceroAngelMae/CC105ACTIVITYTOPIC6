import 'package:flutter/material.dart';

import 'package:topic6/models/user.dart';
import 'package:topic6/services/database.dart';
import 'package:topic6/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:topic6/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> idols = [
    'Monkey D. Luffy',
    'Roronoa Zoro',
    'Nami',
    'Usopp',
    'Vinsmoke Sanji',
    'Tony Tony Chopper',
    'Nico Robin',
    'Cutty Flam',
    'Brook',
    'Jinbei',
    'Carrot',
    'Minato',
    'Caribou',
    'Vivi',
    'Carue',
    'None'
  ];

  String _currentName;
  String _currentIdol;
  int _currentLove;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Preference',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  //dropdown

                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentIdol ?? userData.idolname,
                    items: idols.map((idols) {
                      return DropdownMenuItem(
                        value: idols,
                        child: Text('Choose $idols'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentIdol = val),
                  ),
                  Slider(
                    value: (_currentLove ?? userData.love).toDouble(),
                    activeColor: Colors.cyan[_currentLove ?? userData.love],
                    inactiveColor: Colors.cyan[_currentLove ?? userData.love],
                    //inactive remove on purpose
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentLove = val.round()),
                  ),
                  RaisedButton(
                      color: Colors.orangeAccent,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentIdol ?? userData.idolname,
                            _currentLove ?? userData.love,
                          );
                          Navigator.pop(context);
                        } else {}
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
