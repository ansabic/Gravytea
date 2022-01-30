import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gravytea/ui/space/space_bloc.dart';

class BottomPanel extends StatelessWidget {
  const BottomPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SpaceBloc bloc = BlocProvider.of<SpaceBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "PHYSICS:",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(width: 180, child: Text("Attractive:")),
                    ),
                    BlocBuilder<SpaceBloc, SpaceState>(
                      builder: (context, state) {
                        return Switch(value: state.attractive, onChanged: (switchState) =>
                            bloc.add(SwitchChange(switchState)),);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(width: 180, child: Text("Impulses per second:")),
                    ),
                    SizedBox(
                        width: 60,
                        child: TextField(
                          controller: bloc.ipsController,
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(width: 180, child: Text("Wall damp factor (0 - 1):")),
                    ),
                    SizedBox(
                        width: 60,
                        child: TextField(
                          controller: bloc.wallDampController,
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(width: 180, child: Text("Repel factor (0 - 1):")),
                    ),
                    SizedBox(
                        width: 60,
                        child: TextField(
                          controller: bloc.repelController,
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(width: 180, child: Text("Force factor (10 ^ x):")),
                    ),
                    SizedBox(
                        width: 60,
                        child: TextField(
                          controller: bloc.forceFactorController,
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(width: 180, child: Text("Force distance factor (r ^ x):")),
                    ),
                    SizedBox(
                        width: 60,
                        child: TextField(
                          controller: bloc.forceDistanceFactorController,
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 10),
                  child: Text(
                    "NEXT BODY:",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(width: 180, child: Text("Mass:")),
                    ),
                    SizedBox(
                        width: 60,
                        child: TextField(
                          controller: bloc.newPlanetMassController,
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(width: 180, child: Text("Velocity x component:")),
                    ),
                    SizedBox(
                        width: 60,
                        child: TextField(
                          controller: bloc.newVelocityXController,
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(width: 180, child: Text("Velocity y component:")),
                    ),
                    SizedBox(
                        width: 60,
                        child: TextField(
                          controller: bloc.newVelocityYController,
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextButton(
                          onPressed: () => bloc.add(ClearAll()),
                          child: const Text(
                            "Clear all bodies",
                            style: TextStyle(color: Colors.red),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextButton(onPressed: () => bloc.add(SubmitChanges()), child: const Text("Submit")),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
