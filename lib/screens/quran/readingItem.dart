import 'package:flutter/material.dart';
import 'package:qurann/screens/quran/surahItem.dart';

Widget readingItem(Color color,List <verssModel> list,index) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Text(
      '${list[index].verss} ﴿ ${list[index].versCount} ﴾',
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: TextStyle(
          color: color,
          fontSize: 20,
          height: 2.8 ,
          letterSpacing: 1.2,

          fontWeight: FontWeight.bold,fontFamily: 'Amiri'),
    ),
  );
}
