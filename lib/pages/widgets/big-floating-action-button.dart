import 'package:flutter/material.dart';

class BigFloatingActionButton extends StatelessWidget {
  String? text;
  VoidCallback? onPressed;
  IconData? icon;
  BigFloatingActionButton({
    Key? key,
    this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: FloatingActionButton.extended(
        icon: icon != null ? Icon(icon) : null,
        onPressed: () async {
          onPressed!();
        },
        label: Text(
          text!,
          style: const TextStyle(fontSize: 18),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
