import 'package:floor/floor.dart';
import 'package:tellam/src/database/models/faq_topic.dart';

@dao
abstract class FAQTopicDao {
  @Query('SELECT * FROM faq_topics ORDER BY id DESC')
  Future<List<FAQTopic>> findAll();

  @Query('SELECT * FROM faq_topics WHERE id = :id')
  Stream<FAQTopic> findById(int id);

  @Query('SELECT * FROM faq_topics ORDER BY id DESC')
  Stream<List<FAQTopic>> findAllStream();

  @transaction
  Future<void> replaceFAQTopics(List<FAQTopic> faqTopics) async {
    await deleteAllFAQTopics();
    await insertFAQTopics(faqTopics);
  }

  @insert
  Future<void> insertFAQTopic(FAQTopic faqTopic);

  @insert
  Future<List<int>> insertFAQTopics(List<FAQTopic> faqTopics);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateFAQTopic(FAQTopic faqTopic);

  @delete
  Future<void> deleteFAQTopic(FAQTopic faqTopic);

  @Query('DELETE FROM faq_topics')
  Future<void> deleteAllFAQTopics();
}
