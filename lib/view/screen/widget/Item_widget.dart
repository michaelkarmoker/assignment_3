import 'package:assignment_3/data/model/response/university_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../util/styles.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.university});
  final University  university ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white10
      ),
      child: Column(
        children: [
          Text("${university.name}",textAlign: TextAlign.center,style: akatabRegular.copyWith(fontSize: 18,color: Colors.grey[300]),),
          SizedBox(height: 10,),
          Divider(
            height: 1,color: Colors.white,
          ),
          SizedBox(height: 10,),

          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text("Country ",style: robotoMedium.copyWith(fontSize: 13,color: Colors.grey[300]) )),
              Expanded(
                  flex: 7,
                  child: Text(": ${university.country }",style: akatabRegular.copyWith(fontSize: 13,color: Colors.grey[300]),)),
            ],

          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Text("Web Pages ",style: robotoMedium.copyWith(fontSize: 13,color: Colors.grey[300]) )),
              Expanded(
                  flex: 7,
                  child: Text(": ${university.webPages ??""}",style: akatabRegular.copyWith(fontSize: 13,color: Colors.grey[300]),)),
            ],

          ),


        ],
      ),
    );
  }
}
