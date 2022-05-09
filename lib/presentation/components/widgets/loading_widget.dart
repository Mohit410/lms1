import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blueGrey),
        ),
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: const [
            CircularProgressIndicator(
              backgroundColor: Colors.greenAccent,
            ),
            SizedBox(height: 12),
            Text(
              'Please Wait ...',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
