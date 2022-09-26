import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaitingMapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitCubeGrid(color: Theme.of(context).primaryColor),
          SizedBox(height: 20,),
          Text(
              'Please wait while the map is loading'
          )
        ],
      ),
    );
  }
}