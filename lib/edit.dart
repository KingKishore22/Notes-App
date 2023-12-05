import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqliteflutter/model.dart';
import 'package:sqliteflutter/userservice.dart';

import 'main.dart';

class edit extends StatefulWidget {
  final model m;
  const edit({
    super.key,
    required this.m,
  });
  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  var _texttitle = TextEditingController();
  var _textdesc = TextEditingController();
  bool _validate = false;
  bool _validate1 = false;
  var result;
  var u1 = userservice();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _texttitle.text = widget.m.name ?? '';
      _textdesc.text = widget.m.description ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    _texttitle.dispose();
    _textdesc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.black,
            ),
            onPressed: () async {
              setState(() {
                _texttitle.text.isEmpty ? _validate = true : _validate = false;
                _textdesc.text.isEmpty ? _validate1 = true : _validate1 = false;
              });
              if (_validate == false && _validate1 == false) {
                var m1 = model();
                // m1.id = '1';
                m1.id = widget.m.id;
                m1.date = DateFormat.yMMMEd().format(DateTime.now());
                m1.name = _texttitle.text;
                m1.description = _textdesc.text;
                result = await u1.UpdateUser(m1);
                print('records=$result');
                print('time${m1.date}');
                print('name${m1.name}');
                print('description${m1.description}');
                //  print('time${m1.date}');
              }
            },
          )
        ],
        leading: IconButton(
            color: Colors.black,
            icon: Icon(
              Icons.arrow_circle_left,
            ),
            onPressed: () {
              Navigator.pop(context, result);
            }),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: 'INPUT TITLE',
                  errorText: _validate ? "Please enter a valid text" : '',
                ),
                controller: _texttitle,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                    hintText: 'ADD DESCRIPTION',
                    errorText: _validate1 ? "Please enter a valid text" : '',
                    border: InputBorder.none),
                controller: _textdesc,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
