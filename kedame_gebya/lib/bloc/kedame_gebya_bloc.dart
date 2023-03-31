import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedame_gebya/model/model.dart';
import 'package:kedame_gebya/model/service.dart';
import '../model/repository.dart';
import 'kedame_gebya_state.dart';
import 'kedame_gebya_event.dart';

class KedameGebyaBloc extends Bloc<KedameGebyaEvent, KedameGebyaState> {
  final _apiServiceProvider = ApiServiceProvider();
  final _service = Service();

  List history = [];
  List historyLoaded = [];

  KedameGebyaBloc() : super(KedameGebyaInitialState()) {
    on<AsbezaFetchEvent>(
      (event, emit) async {
        emit(KedameGebyaLoadingState());
        try {
          final activity = await _apiServiceProvider.fetchActivity();
          await _service.readKedameGebya().then(
                (val) => {
                  history = val,
                },
              );

          historyLoaded = KedameGebya.historyList(history);

          emit(KedameGebyaSuccessState(
            kedameGebya: activity!,
            history: historyLoaded,
          ));
        } catch (e) {
          emit(KedameGebyaFailed());
        }
      },
    );

    on<HistoryEvent>(
      (event, emit) => {
        if (!historyLoaded.contains(event.data))
          {
            // _service.wipeDate(),
            historyLoaded.add(event.data),
            _service.saveKedameGebya(event.data),
          }
      },
    );
  }
}
