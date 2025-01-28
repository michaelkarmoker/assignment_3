

import 'package:assignment_3/data/model/response/university_list_response.dart';
import 'package:floor/floor.dart';

@dao
abstract class UniversityDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertUniversityList(List<University> universityList);

  @Query('SELECT * FROM University')
  Future<List<University>> getUniversityList();

  @Query('DELETE FROM University WHERE productId = :id')
  Future<University?> deleteUniversity(String id);

  @Update()
  Future<int> updateUniversity(University university);

  @Query('DELETE FROM University')
  Future<void> cleanUniversityTable();

}