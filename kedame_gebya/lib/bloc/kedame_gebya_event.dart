import 'package:equatable/equatable.dart';

import '../model/model.dart';

class KedameGebyaEvent extends Equatable {
  const KedameGebyaEvent();

  @override
  List<Object> get props => [];
}

class AsbezaFetchEvent extends KedameGebyaEvent {
  const AsbezaFetchEvent();

  @override
  List<Object> get props => [];
}

class HistoryEvent extends KedameGebyaEvent {
  final KedameGebya kedameGebya;
  const HistoryEvent({required this.kedameGebya});

  @override
  List<Object> get props => [];

  get data => kedameGebya;
}
