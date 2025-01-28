import 'package:assignment_3/data/model/response/university_list_response.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../database/db/database.dart';
import '../../util/app_constants.dart';
import '../api/api_client.dart';

class HomeRepo{
  HomeRepo({required this.database, required this.apiClient});
  final ApiClient apiClient;
  final Assignment3Database database;

// get data from api
  Future<Response> getUniversityList({
    required String  countryName,

  }) async {


    Response _response = await apiClient.getData(AppConstants.UNIVERSITY_SEARCH ,query: {"country":countryName});
    return _response;
  }

  //save api data to local database
  Future<void> insertUniversityIntoDatabase( List<University> universityList) async {

      await database.universityDao.insertUniversityList(universityList);
  }

//get university list from local database
  Future<List<University>> getUniversityListFromDatabase( ) async {

    return await database.universityDao.getUniversityList();
  }
}