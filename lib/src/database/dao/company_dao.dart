import 'package:floor/floor.dart';
import 'package:tellam/src/database/models/company.dart';

@dao
abstract class CompanyDao {
  @Query('SELECT * FROM companies LIMIT 1')
  Future<Company> getCurrentCompany();

  @Query('SELECT * FROM companies LIMIT 1')
  Stream<Company> getCurrentCompanyStream();

  @transaction
  Future<void> replaceCompany(Company company) async {
    await deleteAllCompanies();
    await insertCompany(company);
  }

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertCompany(Company company);

  @Update(onConflict: OnConflictStrategy.REPLACE)
  Future<void> updateCompany(Company company);

  @delete
  Future<void> deleteCompany(Company company);

  @Query('DELETE FROM companies')
  Future<void> deleteAllCompanies();
}
