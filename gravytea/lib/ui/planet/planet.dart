import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gravytea/common/constants.dart';
import 'package:gravytea/model/planet_dto.dart';
import 'package:gravytea/ui/space/space_bloc.dart';

import 'planet_bloc.dart';

class Planet extends StatelessWidget {
  final PlanetDTO planet;

  const Planet({Key? key, required this.planet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double x = planet.position.x.toDouble();
    double y = planet.position.y.toDouble();
    if (x.isNaN || x.isInfinite || y.isNaN || y.isInfinite) {
      x = BlocProvider.of<SpaceBloc>(context).dimensions.width / 2;
      y = BlocProvider.of<SpaceBloc>(context).dimensions.height / 2;
      BlocProvider.of<SpaceBloc>(context).add(ClearAll());
    }
    return Positioned(
      left: x,
      top: y,
      child: BlocProvider(
        create: (_) => PlanetBloc(),
        child: Image.asset("assets/ball.png", width: Constants.bodyRadius, height: Constants.bodyRadius),
      ),
    );
  }
}
