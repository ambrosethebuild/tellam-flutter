import 'package:flutter/material.dart';
import 'package:tellam/src/constants/tellam_assets.dart';
import 'package:tellam/tellam.dart';

class PoweredBy extends StatelessWidget {
  const PoweredBy({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(
              TellamAssets.tellamPoweredByAsset,
              package: "tellam",
            ),
            height: 50,
            color: Tellam.uiConfiguration.accentColor,
          ),
          Text("powered by"),
        ],
      ),
    );
  }
}
