import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/app-body/screens/LabComponant/Devices.dart';
import 'package:firebasetest/app-body/screens/LabComponant/ResetFun.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/DevicesProvider.dart';
import '../../utils/Consts.dart';
import 'LabComponant/AIR-Condation.dart';
import 'LabComponant/Curtain.dart';
import 'LabComponant/Data-Show.dart';
import 'LabComponant/Door.dart';
import 'LabComponant/LED.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            context.read<DevicesProvider>().SetChanges(Consts.LOGOUT, true);
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 00, 0),
                  child: Column(children: const [
                    Text(
                      "Welcome to Smart Lab",
                      style: TextStyle(fontSize: 25),
                    ),
                  ])),

              ///
              const SizedBox(height: 10),

              ///
              SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    ///air condation
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 109, 233, 220)),
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              child: Icon(
                                Icons.ac_unit_outlined,
                                size: 35,
                              ),
                              radius: 25,
                              backgroundColor: Colors.white,
                            ),
                            Text(
                              "AIR CONDITION",
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AirCondation()));
                        },
                      ),
                    ),

                    ///curtain
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 184, 243, 184)),
                      height: MediaQuery.of(context).size.height * .2,
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              child: Icon(
                                Icons.percent,
                                size: 35,
                              ),
                              radius: 25,
                              backgroundColor: Colors.white,
                            ),
                            Text("CURTAINS")
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Curtain()));
                        },
                      ),
                    ),

                    ///data show
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 238, 163, 225)),
                      height: MediaQuery.of(context).size.height * .2,
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              child: Icon(
                                Icons.slideshow,
                                size: 35,
                              ),
                              radius: 25,
                              backgroundColor: Colors.white,
                            ),
                            Text("DATA SHOW")
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DataShow()));
                        },
                      ),
                    ),

                    ///Door
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 255, 249, 163)),
                      height: MediaQuery.of(context).size.height * .2,
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              child: Icon(
                                Icons.door_front_door_outlined,
                                size: 35,
                              ),
                              radius: 25,
                              backgroundColor: Colors.white,
                            ),
                            Text("DOOR")
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const Door()));
                        },
                      ),
                    ),

                    ///Lights
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 250, 185, 147)),
                      height: MediaQuery.of(context).size.height * .2,
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              child: Icon(
                                Icons.light,
                                size: 35,
                              ),
                              radius: 25,
                              backgroundColor: Colors.white,
                            ),
                            Text("LIGHTS")
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const LED()));
                        },
                      ),
                    ),

                    ///devices
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 252, 108, 108)),
                      height: MediaQuery.of(context).size.height * .2,
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              child: Icon(
                                Icons.device_hub,
                                size: 35,
                              ),
                              radius: 25,
                              backgroundColor: Colors.white,
                            ),
                            Text("DEVICES")
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Devices()));
                        },
                      ),
                    ),
                    ///mute_Buzzer
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(130, 0, 255, 0)),
                      height: MediaQuery.of(context).size.height * .2,
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              child: Icon(
                                Icons.volume_off_outlined,
                                size: 35,
                              ),
                              radius: 25,
                              backgroundColor: Colors.white,
                            ),
                            Text("MUTE_BUZZER")
                          ],
                        ),
                        onTap: () {

                          context.read<DevicesProvider>().SetChanges(Consts.BUZZER, false);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
