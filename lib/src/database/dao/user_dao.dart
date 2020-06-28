import 'package:floor/floor.dart';
import 'package:tellam/src/database/models/tellam_user.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM users LIMIT 1')
  Future<TellamUser> getCurrentUser();

  @Query('SELECT * FROM users WHERE id = :id')
  Stream<TellamUser> findUserById(int id);

  @Query('SELECT * FROM users WHERE token IS NOT NULL LIMIT 1')
  Stream<TellamUser> getCurrentUserStream();

  @insert
  Future<void> insertUser(TellamUser user);

  @Update(onConflict: OnConflictStrategy.REPLACE)
  Future<void> updateUser(TellamUser user);

  @delete
  Future<void> deleteUser(TellamUser user);

  @Query('DELETE FROM users')
  Future<void> deleteAllUsers();
}
