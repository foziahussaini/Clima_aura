import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utilities/constants.dart';

class loadingWidget extends StatelessWidget {
  const loadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KLightColor,
      body: Center(
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitPouringHourGlassRefined(
              color: Colors.white54,
              size: 100,
            )
          ],
        ),
      ),
    );
  }
}
