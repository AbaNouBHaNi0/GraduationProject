import 'package:firebasetest/Providers/DevicesProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../../utils/Consts.dart';

// Import the firebase_core plugin
class Devices extends StatelessWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool pcsStatus = context.watch<DevicesProvider>().pcs;

    return Scaffold(

        ///app bar
        appBar: AppBar(
          backgroundColor: const Color(0xE36D1900),
          title: const Text(
            "Devices",
            style: TextStyle(
                fontSize: 45,
                color: Color(0xE1E9E5E3),
                fontStyle: FontStyle.italic),
          ),
        ),

        ///body
        body: Provider(
          create: (context) => DevicesProvider(),
          child: SingleChildScrollView(
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
                        Text("statue:${pcsStatus ? "on" : "off"}"),

                        ///the button
                        FlutterSwitch(
                          value: pcsStatus,
                          width: 150.0,
                          height: 70.0,
                          toggleSize: 50.0,
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
                            Icons.ac_unit_outlined,
                            color: Color(0xFFFBC513),
                          ),
                          inactiveIcon: const Icon(
                            Icons.ac_unit_outlined,
                            color: Color(0xFF908865),
                          ),
                          onToggle: (val) {
                            context
                                .read<DevicesProvider>()
                                .SetChanges(Consts.PCS, val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
