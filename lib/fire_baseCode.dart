import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import 'DevicesModel.dart';

class firebase_ops {
  DatabaseReference? ref;
  static String objpath = "devices";

  firebase() {
    ref = FirebaseDatabase.instance.ref();
  }

  GetDevicesData() {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref(objpath);
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      //print(data);
      if (data != null) {
        final jsonEncoder = JsonEncoder();
        var c = jsonEncoder.convert(data);
        Devices devices = Devices.fromJson(jsonDecode(c));
        //print(devices.AirCondtion);
      }
    });
  }
}
