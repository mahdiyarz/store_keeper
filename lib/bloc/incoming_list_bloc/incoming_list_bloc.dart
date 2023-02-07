import 'dart:developer' show log;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:store_keeper/helpers/db_helper.dart';

import '../../models/import_models.dart';

part 'incoming_list_event.dart';
part 'incoming_list_state.dart';

class IncomingListBloc extends Bloc<IncomingListEvent, IncomingListState> {
  IncomingListBloc() : super(const IncomingListInitial()) {
    List<IncomingListModel> allIncomingLists;

    on<FetchAllIncomingLists>((event, emit) async {
      log('start FetchAllIncoming on bloc');

      allIncomingLists = await DBHelper.instance.fetchIncomingListData();

      emit(DisplayAllIncomingList(allIncomingLists: allIncomingLists));
    });

    on<AddIncomingLists>(_onAddIncomingLists);
  }
}

void _onAddIncomingLists(
    AddIncomingLists event, Emitter<IncomingListState> emit) async {
  log('run AddIncomingLists');

  final addIncome = event.addIncomingList;

  await DBHelper.instance.insertIncomingList(IncomingListModel(
    brandId: addIncome.brandId,
    numOfBoxes: addIncome.numOfBoxes,
    incomingListDate: addIncome.incomingListDate,
  ));
}
