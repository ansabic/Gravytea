import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gravytea/model/planet_dto.dart';
import 'package:gravytea/model/velocity.dart' as velocity;
import 'package:gravytea/physics/physics.dart';

part 'space_event.dart';
part 'space_state.dart';

class SpaceBloc extends Bloc<SpaceEvent, SpaceState> {
  TextEditingController ipsController = TextEditingController(text: "300");
  TextEditingController forceDistanceFactorController = TextEditingController(text: "2");
  TextEditingController forceFactorController = TextEditingController(text: "4");
  TextEditingController newPlanetMassController = TextEditingController(text: "10");
  TextEditingController newVelocityXController = TextEditingController(text: "0");
  TextEditingController newVelocityYController = TextEditingController(text: "0");
  TextEditingController repelController = TextEditingController(text: "0.5");
  TextEditingController wallDampController = TextEditingController(text: "0.5");
  Size dimensions = const Size(0, 0);

  void init() {
    Timer.periodic(Duration(milliseconds: 1000 ~/ state.ips), (timer) {
      add(Refresh());
    });
  }

  void setDimensions(Size dimensions) {
    this.dimensions = dimensions;
  }

  SpaceBloc() : super(SpaceInitial()) {
    on<Refresh>((event, emit) {
      emit(
        ActiveState(
            Physics.calculateNextState(state.planets, state.ips, state.forceFactor, state.forceDistanceFactor,
                state.repel, dimensions, state.wallDamp, state.attractive),
            state.ips,
            state.forceFactor,
            state.newPlanetMass,
            state.forceDistanceFactor,
            state.newPlanetVelocityX,
            state.newPlanetVelocityY,
            state.repel,
            state.wallDamp,
            state.attractive),
      );
    });
    on<AddPlanet>((event, emit) {
      List<PlanetDTO> newList = state.planets.toList(growable: true);
      PlanetDTO newPlanet = PlanetDTO(
          mass: state.newPlanetMass,
          position: Point(event.tapDownDetails.globalPosition.dx, event.tapDownDetails.globalPosition.dy),
          velocity: velocity.Velocity(state.newPlanetVelocityX, state.newPlanetVelocityY));
      newList.add(newPlanet);
      emit(ActiveState(newList, state.ips, state.forceFactor, state.newPlanetMass, state.forceDistanceFactor,
          state.newPlanetVelocityY, state.newPlanetVelocityY, state.repel, state.wallDamp, state.attractive));
    });
    on<SubmitChanges>((event, emit) {
      emit(
        ActiveState(
            state.planets,
            double.parse(ipsController.text),
            double.parse(forceFactorController.text),
            double.parse(newPlanetMassController.text),
            double.parse(forceDistanceFactorController.text),
            double.parse(newVelocityXController.text),
            double.parse(newVelocityYController.text),
            double.parse(repelController.text),
            double.parse(wallDampController.text),
            state.attractive),
      );
    });
    on<SwitchChange>((event, emit) => emit(ActiveState(
        state.planets,
        state.ips,
        state.forceFactor,
        state.newPlanetMass,
        state.forceDistanceFactor,
        state.newPlanetVelocityX,
        state.newPlanetVelocityY,
        state.repel,
        state.wallDamp,
        event.state)));
    on<ClearAll>((event, emit) => emit(ActiveState(
        List.empty(),
        state.ips,
        state.forceFactor,
        state.newPlanetMass,
        state.forceDistanceFactor,
        state.newPlanetVelocityX,
        state.newPlanetVelocityY,
        state.repel,
        state.wallDamp,
        state.attractive)));
    init();
  }
}
