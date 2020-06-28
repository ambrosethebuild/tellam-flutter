import 'package:shared_preferences/shared_preferences.dart';
import 'package:tellam/src/constants/tellam_keys.dart';
import 'package:tellam/src/database/models/tellam_user.dart';

class Client {
  //save data to sharedprefrence
  Future<bool> register(TellamUser tellamUser) async {
    bool success;
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      _sharedPreferences.setInt(TellamKeys.userId, tellamUser.id);
      _sharedPreferences.setString(
          TellamKeys.userFirstName, tellamUser.firstName);
      _sharedPreferences.setString(
          TellamKeys.userLastName, tellamUser.lastName);
      _sharedPreferences.setString(
          TellamKeys.userEmailAddress, tellamUser.emailAddress);
      _sharedPreferences.setString(
          TellamKeys.userPhoneNumber, tellamUser.phoneNumber);
      _sharedPreferences.setString(TellamKeys.userPhoto, tellamUser.photo);

      success = true;
    } catch (error) {
      print("Error Occurred while saving tellam user data");
      success = false;
    }
    return success;
  }

  //save data to sharedprefrence
  Future<bool> update(TellamUser tellamUser) async {
    bool success;
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      _sharedPreferences.setInt(TellamKeys.userId, tellamUser.id);
      _sharedPreferences.setString(
          TellamKeys.userFirstName, tellamUser.firstName);
      _sharedPreferences.setString(
          TellamKeys.userLastName, tellamUser.lastName);
      _sharedPreferences.setString(
          TellamKeys.userEmailAddress, tellamUser.emailAddress);
      _sharedPreferences.setString(
          TellamKeys.userPhoneNumber, tellamUser.phoneNumber);
      _sharedPreferences.setString(TellamKeys.userPhoto, tellamUser.photo);

      success = true;
    } catch (error) {
      print("Error Occurred while updating tellam user data");
      success = false;
    }
    return success;
  }

  //delete data to sharedprefrence
  Future<bool> delete() async {
    bool success;
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      _sharedPreferences.remove(TellamKeys.userId);
      _sharedPreferences.remove(TellamKeys.userFirstName);
      _sharedPreferences.remove(TellamKeys.userLastName);
      _sharedPreferences.remove(TellamKeys.userEmailAddress);
      _sharedPreferences.remove(TellamKeys.userPhoneNumber);
      _sharedPreferences.remove(TellamKeys.userPhoto);

      success = true;
    } catch (error) {
      print("Error Occurred while removing tellam user data");
      success = false;
    }
    return success;
  }

  //fetch tellam user saved in sharedprefrence
  Future<TellamUser> fetch() async {
    TellamUser tellamUser;
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final tellamUserId = _sharedPreferences.getInt(TellamKeys.userId);
    final tellamUserFirstName =
        _sharedPreferences.getString(TellamKeys.userFirstName);
    final tellamUserLastName =
        _sharedPreferences.getString(TellamKeys.userLastName);
    final tellamUserEmailAddress =
        _sharedPreferences.getString(TellamKeys.userEmailAddress);
    final tellamUserPhoneNumber =
        _sharedPreferences.getString(TellamKeys.userPhoneNumber);
    final tellamUserPhoto = _sharedPreferences.getString(TellamKeys.userPhoto);

    tellamUser = TellamUser(
      id: tellamUserId,
      firstName: tellamUserFirstName,
      lastName: tellamUserLastName,
      emailAddress: tellamUserEmailAddress,
      phoneNumber: tellamUserPhoneNumber,
      photo: tellamUserPhoto,
    );

    return tellamUser;
  }
}
