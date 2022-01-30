import 'dart:developer';
import 'dart:math';

import 'package:Gravytea/model/vector.dart';

class Velocity extends Vector {
  Velocity(double x, double y) : super(x: x, y: y);

  Velocity.newRandom() : super(x: Random(Timeline.now).nextDouble() * 10, y: Random(Timeline.now).nextDouble() * 10);
}
