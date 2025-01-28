
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floor/floor.dart';
import 'package:floor/floor.dart';



import '../../data/model/response/university_list_response.dart';
import '../dao/universityDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';



@Database(version: 1, entities: [University])

abstract class Assignment3Database extends FloorDatabase {
   UniversityDao get universityDao;


}
