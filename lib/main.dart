import 'package:flutter/material.dart';
import 'package:sqliteflutter/details.dart';
import 'package:sqliteflutter/edit.dart';
import 'package:sqliteflutter/model.dart';
import 'package:sqliteflutter/single.dart';
import 'package:sqliteflutter/userservice.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var user = userservice();
  int io = 0;
  var mo = model();
  late List<model> list;
  getDatas() async {
    list = <model>[];
    var op = await user.readAll();
    op.forEach((u1) {
      var m12 = model();
      setState(() {
        m12.id = u1['id'];
        m12.name = u1['name'];
        m12.description = u1['description'];
        m12.date = u1['date'];
        print('name is:${m12.name}');
        print('date is:${m12.date}');
        print('description is:${m12.description}');
        print('id is:${m12.id}');
        list.add(m12);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getDatas();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTES',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                child: ListView.separated(
                  physics: PageScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: SizedBox(
                        width: 50,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: ListTile(
                            onLongPress: () {
                              delete(context, list[index].id);
                            },
                            leading: Icon(Icons.note),
                            title: Text(
                              list[index].name.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              list[index].date.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                /*        IconButton(
                                    onPressed: () {
                                      delete(context, list[index].id);
                                    },
                                    icon: Icon(Icons.delete)),*/
                                SizedBox(
                                  width: 4,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => edit(
                                                    m: list[index],
                                                  ))).then((value) {
                                        if (value != null) {
                                          getDatas();
                                          showmessage('Updated Successfully');
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.edit)),
                              ],
                            ),
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => single(
                                    m1: list[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 9,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => detail()),
          ).then((value) {
            if (value != null) {
              setState(() {
                getDatas();
                showmessage('Added Successfully');
              });
            }
            print('Values of result is:${value}');
          });
        },
      ),
    );
  }

  delete(BuildContext context, id) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Do you want to delete this note?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    var result = await user.DeleteUser(id);
                    if (result != null) {
                      print('After Deleted');
                      print('Id is:${id}');
                      //print('Result is:${}');
                      setState(() {
                        getDatas();
                      });
                      showmessage('Deleted Successfully');
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Yes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)))
            ],
          );
        });
  }

  void showmessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
