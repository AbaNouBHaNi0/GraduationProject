import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasetest/utils/Consts.dart';
import 'package:flutter/material.dart';
import '../DevicesModel.dart';

class DevicesProvider extends ChangeNotifier {
  bool airCondtion = false;
  bool curtains = true;
  bool dataShow = true;
  bool device = true;
  bool lights = true;
  bool pcs = true;
  bool door = true;
  bool buzzer = true;
  static String objpath = "devices";

  DevicesProvider() {
    DatabaseReference ref = FirebaseDatabase.instance.ref(objpath);
    GetDevicesData(ref);
  }
  //DatabaseReference? ref;
  // ignore: non_constant_identifier_names
  GetDevicesData(DatabaseReference ref) {
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      //print(data);
      if (data != null) {
        const jsonEncoder = JsonEncoder();
        var c = jsonEncoder.convert(data);
        Devices devices = Devices.fromJson(jsonDecode(c));
        //print("event changed");
        airCondtion = devices.AirCondtion;
        curtains = devices.Curtains;
        dataShow = devices.DataShow;
        lights = devices.Lights;
        pcs = devices.Pcs;
        door = devices.Door;
        buzzer = devices.Buzzer;
      }
      notifyListeners();
    });
  }

  // ignore: non_constant_identifier_names
  Future<bool> UpdateStream(String streamValue) async {
    DatabaseReference streamRef =
        FirebaseDatabase.instance.ref(Consts.STREAM_REF);
    await streamRef.update({
      Consts.STATE: streamValue,
    }).then((_) {
      // Data saved successfully!
      return true;
    }).catchError((error) {
      //  failed...
    });
    return false;
  }

  // ignore: non_constant_identifier_names
  void SetChanges(String Device, state) async {
    String streamValue = "";
    switch (Device) {
      case Consts.AIR_CONDITION:
        if (state) {
          streamValue = "f";
        } else {
          streamValue = "e";
        }
        break;
      case Consts.DATA_SHOW:
        if (state) {
          streamValue = "g";
        } else {
          streamValue = "h";
        }
        break;
      case Consts.LIGHTS:
        if (state) {
          streamValue = "c";
        } else {
          streamValue = "d";
        }
        break;
      case Consts.DOOR:
        if (state) {
          streamValue = "a";
        } else {
          streamValue = "b";
        }
        break;
      case Consts.CURTAINS:
        if (state) {
          streamValue = "i";
        } else {
          streamValue = "j";
        }
        break;
      case Consts.PCS:
        if (state) {
          streamValue = "k";
        } else {
          streamValue = "l";
        }
        break;
      case Consts.BUZZER:
        if (state) {
          streamValue = "x";
        } else {
          streamValue = "y";
        }
        break;
      case Consts.LOGOUT:
        if (state) {
          streamValue = "v";
        } else {
          streamValue = "";
        }
        break;
    }

    DatabaseReference ref = FirebaseDatabase.instance.ref(Consts.DEVICES_REF);
    await ref.update({
      Device: state,
    }).then((_) async {
      if (Device == Consts.CURTAINS) {
        await UpdateStream(streamValue);
      }
      // Data saved successfully!
      else {
        await UpdateStream(streamValue);
      }
    }).catchError((error) {
      // The write failed...
    });
  }
}
