import 'package:flutter/material.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';

class azkarreading extends StatefulWidget {
  List<List> SSS = [];
  int index1;
  List list;

  azkarreading(this.SSS, this.index1,this.list);

  @override
  State<azkarreading> createState() => _azkarreadingState();
}

class _azkarreadingState extends State<azkarreading> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          backgroundColor: appCubit.get(context).isDark
              ? Color.fromARGB(255, 22, 31, 87)
              : Color.fromARGB(255, 251, 228, 189),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(widget.list[widget.index1],style: TextStyle(
                color: appCubit.get(context).isDark
                    ? Colors.white
                    : Color.fromARGB(255, 45, 37, 20),
                fontSize: 18,
                fontFamily: 'Amiri',
                fontWeight: FontWeight.bold),),
            backgroundColor: appCubit.get(context).isDark
                ? Color.fromARGB(255, 22, 31, 87)
                : Color.fromARGB(255, 150, 121, 89),
            iconTheme: IconThemeData(
              color: appCubit.get(context).isDark
                  ? Colors.white
                  : Color.fromARGB(255, 45, 37, 20),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: appCubit.get(context).isDark
                              ? Color.fromARGB(255, 16, 15, 54)
                              : Color.fromARGB(255, 150, 121, 89)
                              .withOpacity(0.75)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12.0),
                        child: Text(
                          appCubit.get(context).LIST[index],
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: appCubit.get(context).isDark
                                ? Colors.white
                                : Color.fromARGB(255, 45, 37, 20),
                            fontSize: 18,
                            height: 2.8,
                            wordSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: widget.SSS[widget.index1].length),
          ),
        ),
      ],
    );
  }
}
