import 'dart:math';

import 'package:gravytea/model/velocity.dart';

class PlanetDTO {
  double mass;
  Point position;
  Velocity velocity;

  PlanetDTO({required this.mass, required this.position, required this.velocity});
}
