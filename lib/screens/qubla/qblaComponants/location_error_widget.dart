import 'package:flutter/material.dart';

class LocationErrorWidget extends StatelessWidget {
  final String error;
  final Function callback;

  const LocationErrorWidget({Key key, this.error, this.callback})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final box = SizedBox(height: 32);
    final errorColor = Colors.white;

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_off,
              size: 150,
              color: errorColor,
            ),
            box,
            Text(
              error,
              style: TextStyle(fontSize: 20,
                  color: errorColor, fontWeight: FontWeight.bold),
            ),
            box,
            RaisedButton(
              child: Text('RETRY',style: TextStyle(fontSize: 15,
                  color: Color.fromARGB(255, 23, 21, 81), fontWeight: FontWeight.w800),),
              onPressed: () {
                if (callback != null) callback();
              },
              elevation: 0,
            )
          ],
        ),
      ),
    );
  }
}