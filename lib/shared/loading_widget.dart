import 'package:ewallet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget {
  BuildContext context;
  LoadingWidget(this.context);
  Future<dynamic> loadingUtils(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
                width: 60,
                height: 60,
                color: transparentColor,
                child: const LoadingIndicate()),
          );
        });
  }

  void loading(bool isOn) {
    if (isOn) {
      loadingUtils(context);
    } else {
      Navigator.pop(context);
    }
  }
}

class LoadingIndicate extends StatelessWidget {
  const LoadingIndicate({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            LoadingIndicator(
              strokeWidth: 20,
              indicatorType: Indicator.ballRotateChase,
              colors: [redColor],
            ),
            SizedBox(
              width: 16,
            ),
            Text('Please wait...'),
          ],
        ),
      ),
    );
  }
}
