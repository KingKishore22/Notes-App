import 'package:flutter/material.dart';
import 'package:sqliteflutter/main.dart';
import 'package:sqliteflutter/model.dart';

class single extends StatefulWidget {
  final model m1;
  const single({super.key, required this.m1});

  @override
  State<single> createState() => _singleState();
}

class _singleState extends State<single> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          )),
      body: SafeArea(
        // child: Expanded(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.m1.name ?? 'INPUT TITLE',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.m1.date ?? '',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Divider(
                thickness: 2.0,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.m1.description ?? 'DESCRIPTION',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        //),
      ),
    );
  }
}
