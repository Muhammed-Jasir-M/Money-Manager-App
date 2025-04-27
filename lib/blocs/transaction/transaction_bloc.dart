import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker_app/models/transaction/transaction_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final transactionBox = Hive.box<TransactionModel>('transactions');

  TransactionBloc() : super(TransactionInitial()) {
    on<LoadTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions = transactionBox.values.toList();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });

    on<AddTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await transactionBox.add(event.transaction);
        final transactions = transactionBox.values.toList();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });

    add(LoadTransaction());
  }
}
