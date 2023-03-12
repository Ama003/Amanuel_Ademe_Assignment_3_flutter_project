import 'package:equatable/equatable.dart';

abstract class KedameGebyaState extends Equatable {
  const KedameGebyaState();

  @override
  List<Object> get props => [];
}

class KedameGebyaInitialState extends KedameGebyaState {}

class KedameGebyaLoadingState extends KedameGebyaState {}

class KedameGebyaSuccessState extends KedameGebyaState {
  final List kedameGebya;
  final List history;
  const KedameGebyaSuccessState(
      {required this.kedameGebya, required this.history});
}
