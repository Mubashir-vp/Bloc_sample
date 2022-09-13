import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/model/memeModel.dart';
import 'package:bloc_sample/services/api_services.dart';
import 'package:meta/meta.dart';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/blocks/todos/todos_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as mubs;
import '../../../model/weatherModel.dart';
import '/model/todoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'apibloc_event.dart';
part 'apibloc_state.dart';

class ApiblocBloc extends Bloc<ApiblocEvent, ApiblocState> {
  ApiblocBloc() : super(DataLoading()) {
    on<LoadData>(_loadData);
  }
  _loadData(
    LoadData event,
    Emitter<ApiblocState> emit,
  ) async {
    try {
   var data=await ApiServices().loadData();
        emit(DataLoaded(weather: data));
    } on SocketException {
      emit(const ErrorState(errorMessage: "Network Error"));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
