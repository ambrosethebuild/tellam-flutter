import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/state_data_model.dart';
import 'package:tellam/src/utils/app_paddings.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/tellam.dart';

class PageStateView extends StatefulWidget {
  final StateDataModel stateDataModel;
  final double topMargin;
  PageStateView({Key key, @required this.stateDataModel, this.topMargin = 0})
      : super(key: key);

  @override
  _PageStateViewState createState() => _PageStateViewState();
}

class _PageStateViewState extends State<PageStateView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPaddings.defaultPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: widget.topMargin),

          //Show Icon Data
          (widget.stateDataModel.assetName.isEmpty)
              ? Icon(
                  widget.stateDataModel.iconData,
                  color: widget.stateDataModel.iconColor,
                  size: 32,
                )
              : SizedBox.shrink(),

          //Show image view
          (widget.stateDataModel.assetName.isNotEmpty)
              ? Image.asset(
                  widget.stateDataModel.assetName,
                  width: widget.stateDataModel.assetWidth,
                  height: widget.stateDataModel.assetHeight,
                )
              : SizedBox.shrink(),

          SizedBox(
            height: 20,
          ),
          Text(
            "${widget.stateDataModel.title}",
            textAlign: TextAlign.center,
            style: TellamTextStyles.h3TitleTextStyle(),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${widget.stateDataModel.description}",
            textAlign: TextAlign.center,
            style: TellamTextStyles.h5TitleTextStyle(),
          ),
          SizedBox(
            height: 10,
          ),
          (widget.stateDataModel.showActionButton)
              ? RaisedButton(
                  elevation: 2,
                  color: Tellam.uiConfiguration.accentColor,
                  onPressed: widget.stateDataModel.actionFunction,
                  child: Text(
                    widget.stateDataModel.actionButtonTitle,
                    style: TellamTextStyles.h6TitleTextStyle(),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
