import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topic6/models/newidol.dart';
import 'package:topic6/models/user.dart';


class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //reference
  final CollectionReference idolCollection =
      Firestore.instance.collection('idols');

  Future updateUserData(String name, String idolname, int love) async {
    return await idolCollection.document(uid).setData(
      {
        'name': name,
        'idolname': idolname,
        'love': love,
      },
    );
  }

  //idol list snapshot

  List<Idol> _idolListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Idol(
        name: doc.data['name'] ?? '',
        love: doc.data['love'] ?? 0,
        idol: doc.data['idolname'] ?? '',
      );
    }).toList();
  }

  //userdata
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      idolname: snapshot.data['idolname'],
      love: snapshot.data['love'],
    );
  }

  //get stream
  Stream<List<Idol>> get idol {
    return idolCollection.snapshots().map(_idolListFromSnapshot);
  }

  //get user doc

  Stream<UserData> get userData {
    return idolCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
