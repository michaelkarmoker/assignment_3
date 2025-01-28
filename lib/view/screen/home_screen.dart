
import 'package:assignment_3/controller/home_controller.dart';
import 'package:assignment_3/view/screen/widget/Item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';




import '../../util/colors.dart';
import '../../util/styles.dart';

import '../base/custom_search_textfield.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0,left: 8,right: 8, ),
          child: RefreshIndicator(

            onRefresh: homeController.getUniversityList,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  toolbarHeight: 110,
                  pinned: true,
                  stretch: true,
                  backgroundColor: bgColor,
                  title:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("University List of Bangladesh",style: robotoMedium.copyWith(fontSize: 20,color: textColor),),
                      SizedBox(height: 20,),
                      CustomSearchTextField(controller: homeController.searchCtr,
                          focusNode: homeController.searchFcs,color: textColor,
                          sufixIconFun: (){
                            homeController.searchCtr.clear();
                          },
                          suffixIcon:  Icons.close
                      )
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                        color: bgColor
                    ),
                  ),

                ),

                SliverToBoxAdapter(
                  child:Obx(
                      () {
                  if(homeController.isLoading.value){
                    return Center(child: CircularProgressIndicator());
                  }else if(homeController.filteredUniversities.value.isEmpty){
                    return Center(child: Container(
                      child: Text("Data Not found",style: robotoMedium.copyWith(fontSize: 20,color: Colors.red),),
                    ));
                  }else{
                    return Column(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemCount:homeController.filteredUniversities.value.length ,
                            shrinkWrap: true,
                            itemBuilder: (context,index){
                              return ItemWidget(university: homeController.filteredUniversities.value[index], );

                            })
                      ],
                    );
                  }
                      }
                  ) ,
                )
              ],


            ),
          ),
        ),
      ),
    );
  }
}

 


