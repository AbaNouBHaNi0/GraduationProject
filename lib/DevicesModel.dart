import 'package:firebasetest/utils/Consts.dart';

class Devices {
  final AirCondtion;
  final Curtains;
  final DataShow;
  final Pcs;
  final Lights;
  final Door;
  final Buzzer;
  final Logout;

  Devices(
      {this.AirCondtion,
      this.Curtains,
      this.DataShow,
      this.Pcs,
      this.Lights,
      this.Door,
      this.Buzzer,
      this.Logout});

  factory Devices.fromJson(json) {
    return Devices(
      AirCondtion: json[Consts.AIR_CONDITION],
      Curtains: json[Consts.CURTAINS],
      DataShow: json[Consts.DATA_SHOW],
      Lights: json[Consts.LIGHTS],
      Pcs: json[Consts.PCS],
      Door: json[Consts.DOOR],
      Buzzer: json[Consts.BUZZER],
      Logout: json[Consts.LOGOUT],
    );
  }
}
