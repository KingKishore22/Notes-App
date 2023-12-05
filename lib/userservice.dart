import 'package:sqliteflutter/model.dart';
import 'package:sqliteflutter/repository.dart';

class userservice {
  late repository rep;
  userservice() {
    rep = repository();
  }
  saveUser(model m) async {
    return await rep.InsertData('users', m.map1());
  }

  readAll() async {
    return await rep.ReadAll('users');
  }

  UpdateUser(model m) async {
    return await rep.UpdateData('users', m.map1());
  }

  DeleteUser(index) async {
    return await rep.DeleteData('users', index);
  }
}
