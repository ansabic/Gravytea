
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'planet_event.dart';
part 'planet_state.dart';

class PlanetBloc extends Bloc<PlanetEvent, PlanetState> {
  PlanetBloc() : super(PlanetInitial()) {
    on<PlanetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
