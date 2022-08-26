import 'package:flutter/cupertino.dart';
import 'package:qurann/screens/quran/SurahAndJuz2Item.dart';
import 'package:quran/quran.dart' as quran;
class Juz2List extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return JuzaItem(context, index);
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 1,
              color: Color.fromARGB(255, 87, 89, 116),
            ),
          );
        },
        itemCount: quran.totalJuzCount);
  }
}
