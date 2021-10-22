import 'package:flutter/material.dart';

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