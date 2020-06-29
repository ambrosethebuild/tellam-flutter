import 'package:tellam/src/database/models/tellam_user.dart';
import 'package:tellam/tellam.dart';

class Client {
  //save data to sharedprefrence
  Future<bool> register(TellamUser tellamUser) async {
    bool success;
    try {
      Tellam.appDatabase.userDao.replaceUser(tellamUser);
      Tellam.tellamDatabaseReference
          .child(
            "users/${tellamUser.id}",
          )
          .set(
            tellamUser.getMappedObject(),
          );
      success = true;
    } catch (error) {
      print("Error Occurred while saving tellam user data $error");
      success = false;
    }
    return success;
  }

  //save data to sharedprefrence
  Future<bool> update(TellamUser tellamUser) async {
    bool success;
    try {
      Tellam.appDatabase.userDao.updateUser(tellamUser);
      success = true;
    } catch (error) {
      print("Error Occurred while updating tellam user data");
      success = false;
    }
    return success;
  }

  //delete data from database
  Future<bool> logout() async {
    bool success;
    try {
      Tellam.appDatabase.userDao.deleteAllUsers();
      success = true;
    } catch (error) {
      print("Error Occurred while removing tellam user data");
      success = false;
    }
    return success;
  }

  //fetch tellam user saved in sharedprefrence
  Future<TellamUser> fetch() => Tellam.appDatabase.userDao.getCurrentUser();
}
