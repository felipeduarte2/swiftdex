//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> irA(BuildContext context, String ruta,String arguments) async {
  Navigator.pop(context);
  Navigator.of(context).pushNamed(ruta,arguments: arguments);
}
