part of 'collect_fine_bloc.dart';

abstract class CollectFineState extends Equatable {
  const CollectFineState();

  @override
  List<Object> get props => [];
}

class CollectFineInitial extends CollectFineState {}

class CollectFineLoading extends CollectFineState {}

class CollectFineSuccess extends CollectFineState {
  final String message;

  const CollectFineSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class FineDetailsLoaded extends CollectFineState {
  final FineDataModel fineData;
  final List<FineHistoryModel> fineHistory;

  const FineDetailsLoaded(this.fineData, this.fineHistory);

  @override
  List<Object> get props => [fineData];
}

class CollectFineFailed extends CollectFineState {
  final String message;

  const CollectFineFailed(this.message);

  @override
  List<Object> get props => [message];
}
