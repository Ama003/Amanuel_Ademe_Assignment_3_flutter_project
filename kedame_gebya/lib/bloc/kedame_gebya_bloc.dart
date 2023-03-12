import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/repository.dart';
import 'kedame_gebya_state.dart';
import 'kedame_gebya_event.dart';

class KedameGebyaBloc extends Bloc<KedameGebyaEvent, KedameGebyaState> {
  final _apiServiceProvider = ApiServiceProvider();
  List history = [];
  KedameGebyaBloc() : super(KedameGebyaInitialState()) {
    on<KedameGebyaEvent>((event, emit) async {
      emit(KedameGebyaLoadingState());
      try {
        final activity = await _apiServiceProvider.fetchActivity();
        emit(KedameGebyaSuccessState(kedameGebya: activity!, history: history));
      } catch (e) {
        emit(KedameGebyaInitialState());
      }
    });
    on<HistoryEvent>((event, emit) => {history.add(event.data)});
  }
}
