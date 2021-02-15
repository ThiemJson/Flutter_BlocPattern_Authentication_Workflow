import 'package:uuid/uuid.dart';
import 'models/model.dart';

class UserRepository {
  User _user;

  Future<User> getUser() async {
    if (_user != null) {
      return _user;
    }
    return Future.delayed(
      Duration(milliseconds: 1000),
      () => _user = User(id: Uuid().v4()),
    );
  }
}
