import 'package:firebasetest/DevicesModel.dart';

import '../../../Providers/DevicesProvider.dart';
import '../../../utils/Consts.dart';

class ResetFun
{

static void reset(context)
  {
    context.read<DevicesProvider>().SetChanges(Consts.BUZZER, false);
  }

}
