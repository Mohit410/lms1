part of 'collect_fine_bloc.dart';

abstract class CollectFineEvent extends Equatable {
  const CollectFineEvent();

  @override
  List<Object> get props => [];
}

class FetchFineDetails extends CollectFineEvent {
  final String email;

  const FetchFineDetails(this.email);

  @override
  List<Object> get props => [email];
}

class CollectFineClicked extends CollectFineEvent {
  final String email;
  final List<String> bookId;
  final String amount;
  final String purpose;

  const CollectFineClicked(this.email, this.bookId, this.amount, this.purpose);

  @override
  List<Object> get props => [email, bookId,amount, purpose];
}
