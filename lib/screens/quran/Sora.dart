import 'package:flutter/cupertino.dart';
import 'package:qurann/screens/quran/SurahAndJuz2Item.dart';
import 'package:quran/quran.dart' as quran;
class SoraList extends StatefulWidget {

  @override
  State<SoraList> createState() => _SoraListState();
}

class _SoraListState extends State<SoraList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return surahItem(context, index,);
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
        itemCount: quran.totalSurahCount);
  }
}
