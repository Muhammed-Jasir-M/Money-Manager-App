part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTransaction extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final TransactionModel transaction;

  AddTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}
