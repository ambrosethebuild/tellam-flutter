import 'package:floor/floor.dart';
import 'package:tellam/src/database/models/data_update.dart';

@dao
abstract class DataUpdateDao {
  @Query('SELECT * FROM updates ORDER BY id DESC')
  Future<List<DataUpdate>> findAll();

  @Query('SELECT * FROM updates ORDER BY id DESC LIMIT 1')
  Future<DataUpdate> findLast();

  @Query('SELECT * FROM updates WHERE id = :id')
  Stream<DataUpdate> findById(int id);

  @Query('SELECT * FROM updates ORDER BY id DESC')
  Stream<List<DataUpdate>> findAllStream();

  @insert
  Future<void> insertDataUpdate(DataUpdate dataUpdate);

  @Update(onConflict: OnConflictStrategy.REPLACE)
  Future<void> updateDataUpdate(DataUpdate dataUpdate);

  @delete
  Future<void> deleteDataUpdate(DataUpdate dataUpdate);

  @Query('DELETE FROM updates')
  Future<void> deleteAllDataUpdates();
}
