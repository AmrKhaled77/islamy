import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qurann/MainCubit/AppCubit/AppCubit.dart';

Widget salaItem(
    {@required context,
      @required String Estring,
      @required String Tstring,
      @required String Astring}) {
  return SingleChildScrollView(
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.075,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.335,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      appCubit.get(context).isDark?
                      'assets/images/M-design-rotated.png': 'assets/images/M-design-light.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.335,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(8)),
                ),
                Text(
                  Estring,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontFamily: 'Amiri',
                      color: appCubit.get(context).isDark
                          ? Colors.white
                          : Color.fromARGB(255, 251, 228, 189),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              child: Center(
                child: Text(
                  Tstring,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: appCubit.get(context).isDark
                          ? Colors.white
                          : Color.fromARGB(255, 45, 37, 20)),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.335,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      appCubit.get(context).isDark?
                      'assets/images/M-design-rotated.png': 'assets/images/M-design-light.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.335,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(8)),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.335,
                    child: Center(
                      child: Text(
                        Astring,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            color: appCubit.get(context).isDark
                                ? Colors.white
                                : Color.fromARGB(255, 251, 228, 189),
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
