import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

ElevatedButton navButton(Function switchFunction, String label){
  return ElevatedButton(
      onPressed: () {
        switchFunction();
      },
      child: Text(
        label
      ),
  );
}


Widget addHorizontalSpace(double width){
  return SizedBox(width: width);
}

Widget addVerticalSpace(double height){
  return SizedBox(height: height);
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Container(
      height: 60,
      width: 120,

      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      ),
    ),
  );
}