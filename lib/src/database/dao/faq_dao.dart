import 'package:floor/floor.dart';
import 'package:tellam/src/database/models/faq.dart';

@dao
abstract class FAQDao {
  @Query('SELECT * FROM faqs ORDER BY id DESC')
  Future<List<FAQ>> findAll();

  @Query('SELECT * FROM faqs WHERE id = :id')
  Stream<FAQ> findById(int id);

  @Query('SELECT * FROM faqs WHERE topicId = :topicId')
  Stream<List<FAQ>> findByTopicId(int topicId);

  @Query('SELECT * FROM faqs ORDER BY id DESC')
  Stream<List<FAQ>> findAllStream();

  @Query('SELECT * FROM faqs ORDER BY id DESC LIMIT 4')
  Stream<List<FAQ>> findPopularStream();

  @transaction
  Future<void> replaceFAQs(List<FAQ> faqs) async {
    await deleteAllFAQs();
    await insertFAQs(faqs);
  }

  @insert
  Future<void> insertFAQ(FAQ faq);

  @insert
  Future<List<int>> insertFAQs(List<FAQ> faqs);

  @Update(onConflict: OnConflictStrategy.REPLACE)
  Future<void> updateFAQ(FAQ faq);

  @delete
  Future<void> deleteFAQ(FAQ faq);

  @Query('DELETE FROM faqs')
  Future<void> deleteAllFAQs();
}
