import 'package:flutter/material.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';

class splach extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/images/ic.png",
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'ISLAMY',
                    style: TextStyle(
                        color:appCubit.get(context).isDark? Colors.white:
                        Colors.black,
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Amiri'),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Made by',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 8,
                      fontFamily: 'Amiri'),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'AMR KHALED - OMAR ELMANSY',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Amiri',
                    fontSize: 8,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
