import 'dart:math';

class Vector {
  double x;
  double y;

  Vector({required this.x, required this.y});

  double size() => sqrt(pow(x, 2) + pow(y, 2));

  void add(Vector another) {
    x = x + another.x;
    y = y + another.y;
  }
}
