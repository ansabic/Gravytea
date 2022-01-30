part of 'space_bloc.dart';

@immutable
abstract class SpaceState {
  final List<PlanetDTO> planets;
  final double forceFactor;
  final double newPlanetMass;
  final double forceDistanceFactor;
  final double newPlanetVelocityX;
  final double newPlanetVelocityY;
  final double ips;
  final double repel;
  final double wallDamp;
  final bool attractive;

  const SpaceState(
      {required this.ips,
      required this.forceFactor,
      required this.newPlanetMass,
      required this.forceDistanceFactor,
      required this.newPlanetVelocityX,
      required this.newPlanetVelocityY,
      required this.planets,
      required this.repel,
      required this.wallDamp,
      required this.attractive});
}

class SpaceInitial extends SpaceState {
  SpaceInitial()
      : super(
            ips: 300,
            planets: List.empty(),
            forceFactor: 4,
            forceDistanceFactor: 2,
            newPlanetMass: 10,
            newPlanetVelocityX: 0,
            newPlanetVelocityY: 0,
            repel: 0.5,
            wallDamp: 0.5,
            attractive: true);
}

class ActiveState extends SpaceState {
  const ActiveState(
      List<PlanetDTO> newPlanets,
      double ips,
      double forceFactor,
      double newPlanetMass,
      double forceDistanceFactor,
      double newPlanetVelocityX,
      double newPlanetVelocityY,
      double repel,
      double wallDamp,
      bool attractive)
      : super(
            ips: ips,
            planets: newPlanets,
            newPlanetVelocityY: newPlanetVelocityY,
            newPlanetVelocityX: newPlanetVelocityX,
            newPlanetMass: newPlanetMass,
            forceDistanceFactor: forceDistanceFactor,
            forceFactor: forceFactor,
            repel: repel,
            wallDamp: wallDamp,
            attractive: attractive);
}
