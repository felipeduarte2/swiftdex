import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: <Widget>[
        // const SizedBox(width: 100,),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed("/user_info"),//, '/user_info'),
          //Navigator.of(context).pushNamed("/viaje",arguments: "0");
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
            child: Container(
              width: double.infinity,
              height: 100,
              // height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey[200],
                borderRadius: const BorderRadius.all(Radius.circular(10)), 
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 150,
                height: 100,
                // height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(10)), 
                ),
              ),
              Container(
                width: 150,
                height: 100,
                // height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(10)), 
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
          child: Container(
            width: double.infinity,
            height: 250,
            // height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueGrey[200],
              borderRadius: const BorderRadius.all(Radius.circular(10)), 
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
          child: Container(
            width: double.infinity,
            height: 60,
            // height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueGrey[200],
              borderRadius: const BorderRadius.all(Radius.circular(10)), 
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
          child: Container(
            width: double.infinity,
            height: 200,
            // height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueGrey[200],
              borderRadius: const BorderRadius.all(Radius.circular(10)), 
            ),
          ),
        ),
        // ListView.builder(
        //   itemCount: 25,
        //   itemBuilder: (context, index) {
        //     return ListTile(
        //       title: Text('Item $index'),
        //     );
        //   },
        // ),
        // FloatingActionButton(
        //   onPressed: (){},
        //   child: const Icon(Icons.add),
        // )
      ],
    );
  }
}