import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String lable;
  final BuildContext context;
  final Color color;
  final Icon? icon;
  final Color? textColor;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.lable,
    required this.context,
    required this.color,
    this.textColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? Container(),
          const SizedBox(width: 10),
          Text(lable, textAlign: TextAlign.center),
        ],
      ),
      style: ButtonStyle(
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.all(color),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: MaterialStateProperty.all(
            const EdgeInsets.fromLTRB(20, 15, 20, 15)),
        elevation: MaterialStateProperty.all(5.0),
        foregroundColor: MaterialStateProperty.all(textColor),
      ),
    );

    /* return Material(
      elevation: 5,
      color: color,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () => onPressed(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? Container(),
            const SizedBox(width: 10),
            Text(
              lable,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    ); */
  }
}
