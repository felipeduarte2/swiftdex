import 'package:flutter/material.dart';

Center notActiviti(BuildContext context){
  return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 60, left: 60, top: 60),
            child: const SizedBox(
                child: Image(image: AssetImage('assets/images/empty.png'))
            ),
          ),
          const SizedBox(height: 20),
          const Text(
              "Sin Actividades",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400
              )
          ),
        ],
      )
  );
}