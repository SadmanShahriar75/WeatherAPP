

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_apps/model/weather_model.dart';


class FutureForcastListItem extends StatelessWidget {
  final Forecastday? forcastday;
  const FutureForcastListItem({super.key,this.forcastday});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24, borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(vertical: 8),
        margin: EdgeInsets.all(8),
        width: double.infinity,
        child: Row(
          children: [
            Image.network("https:${forcastday?.day?.condition?.icon??""}"),
            
            
             Expanded(
               child: Text(DateFormat.MMMEd().format(DateTime.parse(forcastday?.date.toString() ?? "")),
               style: TextStyle(color: Colors.white),
               ),
             ),

                Expanded(
               child: Text(
               forcastday?.day?.condition?.text.toString() ?? "",
               style: TextStyle(color: Colors.white),
               ),
             ),

               Expanded(
               child: Text(
                   "^${forcastday?.day?.maxtempC?.round()}/${forcastday?.day?.mintempC?.round()}",
               style: TextStyle(color: Colors.white),
               ),
             ),
          ],
        ),
      
    );
  }
}