part of 'space_bloc.dart';

@immutable
abstract class SpaceEvent {}

class AddPlanet extends SpaceEvent {
  final TapDownDetails tapDownDetails;

  AddPlanet({required this.tapDownDetails});
}

class Refresh extends SpaceEvent {}

class SubmitChanges extends SpaceEvent {}

class ClearAll extends SpaceEvent {}

class SwitchChange extends SpaceEvent {
  final bool state;

  SwitchChange(this.state);
}
