part of 'user_detail_bloc.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object> get props => [];
}

class UserDetailsEmpty extends UserDetailState {}

class UserDetailsLoading extends UserDetailState {}

class UserDetailsLoaded extends UserDetailState {
  final List<IssuedBookModel> issuedBooks;
  final int totalFine;
  final List<TransactionModel> transactions;
  final UserModel user;
  final List<FineHistoryModel> fineHistory;

  const UserDetailsLoaded(
      {required this.issuedBooks,
      required this.totalFine,
      required this.transactions,
      required this.user,
      required this.fineHistory});
}

class UserDetailsFailed extends UserDetailState {
  final String message;

  const UserDetailsFailed(this.message);
}
