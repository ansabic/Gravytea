import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gravytea/ui/bottom_panel/bottom_panel.dart';
import 'package:gravytea/ui/planet/planet.dart';
import 'package:gravytea/ui/space/space_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Space extends StatelessWidget {
  const Space({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpaceBloc(),
      child: Scaffold(
        body: BlocBuilder<SpaceBloc, SpaceState>(
          builder: (blocContext, state) {
            BlocProvider.of<SpaceBloc>(blocContext).setDimensions(MediaQuery.of(blocContext).size);
            return SlidingUpPanel(
                minHeight: 40,
                collapsed: const Icon(Icons.keyboard_arrow_up),
                panel: const BottomPanel(),
                body: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTapDown: (details) {
                    BlocProvider.of<SpaceBloc>(blocContext).add(AddPlanet(tapDownDetails: details));
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: state.planets.map((e) => Planet(planet: e)).toList(),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
