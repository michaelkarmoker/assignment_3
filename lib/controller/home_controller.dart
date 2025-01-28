import 'dart:async';
import 'dart:convert';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:assignment_3/data/repository/home_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/model/response/university_list_response.dart';

import '../util/debouncer.dart';
import '../view/base/custom_snackbar.dart';

class HomeController extends GetxController  {
    final HomeRepo homeRepo;
    HomeController({required this.homeRepo});

 RxBool   isLoading = false.obs;
    RxBool   isConnectInternet = true.obs;
 TextEditingController searchCtr=new TextEditingController();
 FocusNode searchFcs=new FocusNode();
 String searchText="Bangladesh";
 RxList<University> universityList =new RxList();
 var filteredUniversities = <University>[].obs;
 final Debouncer debouncer = Debouncer(milliseconds: 300);
 StreamSubscription? _internetConnectionSteam;
  @override
  void onInit() {

  /// internet checking listener
      _internetConnectionSteam = InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          isConnectInternet.value=true;
          showCustomSnackBar("Internet is connected",isPositionTop:false,isFloating: false,isError: false);
          break;
        case InternetStatus.disconnected:
          isConnectInternet.value=false;
          showCustomSnackBar("Internet is disconnected",isError: true,isPositionTop:false,isFloating: false );
          break;
      }
    });
      //api call
    getUniversityList();

    //on page search listener
    searchCtr.addListener(() {
      //  debouncer for delay on search
      debouncer.run(() {
        filterUniversities(searchCtr.text);
      });

    });
    super.onInit();

  }

    @override
    void dispose() {

      _internetConnectionSteam?.cancel();
      super.dispose();
    }

///Get university list from api
    Future<void> getUniversityList() async {

       isLoading.value = true;
       /// checking internet connection
       if(isConnectInternet.value){
         Response response = await homeRepo.getUniversityList(countryName: searchText);
         if (response.statusCode == 200) {
           try{
             universityList.value=(response.body as List).map((data)=>University.fromJson(data)).toList();

             filteredUniversities.value=universityList;

             ///save api data to local database
             homeRepo.insertUniversityIntoDatabase( universityList);

           }catch(e){
             showCustomSnackBar(e.toString());
           }
         } else {
           // ApiChecker.checkApi(jsonDecode(response.statusCode));
           showCustomSnackBar(response.statusCode!.toString());
         }
       }else{
          /// getting data from local SQLite database
         universityList.value=await homeRepo.getUniversityListFromDatabase();
         filteredUniversities.value=universityList.value;
       }

       isLoading.value = false;

    }
///filter university list by search text
    void filterUniversities(String query) {
      if (query.isEmpty) {
         print("no text--------");
        filteredUniversities.value=universityList;
      } else {
        print("text is ${query}");
        filteredUniversities.value=[];
        universityList.map((d){
          if(d.name!.toLowerCase().contains(query.toLowerCase())){
            filteredUniversities.value.add(d);
          }
        } ).toList();
      }
    }

    /// Debouncer for delaying search
    Map<Function, Timer> _timeouts = {};
    void debounce(Duration timeout, Function target, [List arguments = const []]) {
      if (_timeouts.containsKey(target)) {
        _timeouts[target]?.cancel();
      }

      Timer timer = Timer(timeout, () {
        Function.apply(target, arguments);
      });

      _timeouts[target] = timer;
    }
}