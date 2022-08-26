import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

// Import the firebase_core plugin

class Application extends StatefulWidget {
  //lib core
  // ignore: use_key_in_widget_constructors
  const Application({this.app});

  final FirebaseApp? app;

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
// lib database
  final referenceDatase = FirebaseDatabase.instance;
  bool status7 = false;

  DatabaseReference ref = FirebaseDatabase.instance.ref("stream/state");

  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    Stream<DatabaseEvent> stream = ref.onValue;
    stream.listen((DatabaseEvent event) {
      print('Event Type: ${event.type}'); // DatabaseEventType.value;
      print('Snapshot: ${event.snapshot}');
      // DataSnapshot
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatase.reference();

    return Scaffold(

        ///app bar
        appBar: AppBar(
          backgroundColor: const Color(0xE36D1900),
          title: const Text(
            "Control Room",
            style: TextStyle(
                fontSize: 45,
                color: Color(0xE1E9E5E3),
                fontStyle: FontStyle.italic),
          ),
        ),

        ///body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0x00a9867a),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text("statue:$status7"),

                      ///the button
                      FlutterSwitch(
                        width: 150.0,
                        height: 70.0,
                        toggleSize: 50.0,
                        value: status7,
                        borderRadius: 30.0,
                        padding: 2.0,
                        activeToggleColor: const Color(0xFF952907),
                        inactiveToggleColor: const Color(0xFFE7A261),
                        activeSwitchBorder: Border.all(
                          color: const Color(0xFFAC2F09),
                          width: 6.0,
                        ),
                        inactiveSwitchBorder: Border.all(
                          color: const Color(0xFFE7A261),
                          width: 6.0,
                        ),
                        activeColor: const Color(0xFFC8A989),
                        inactiveColor: Colors.white,
                        activeIcon: const Icon(
                          Icons.lightbulb,
                          color: Color(0xFFFBC513),
                        ),
                        inactiveIcon: const Icon(
                          Icons.lightbulb,
                          color: Color(0xFF908865),
                        ),
                        onToggle: (val) {
                          setState(() {
                            status7 = val;

                            if (val) {
                              ref
                                  .child(
                                      'DOOR') //ادخال بيانات باسم رئيسي(اب) للبيانات الفرعية

                                  .child('state') //عمل اسم متفرع(ابن)
                                  .set('on') //قيمة للابن من الادخال
                                  .asStream();
                            } else {
                              ref //استخدام كائن من كلاس الداتا نفسة علشان ادخل بيانات
                                  .child(
                                      'DOOR') //ادخال بيانات باسم رئيسي(اب) للبيانات الفرعية

                                  .child('state') //عمل اسم متفرع(ابن)
                                  .set('off') //قيمة للابن من الادخال
                                  .asStream();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
