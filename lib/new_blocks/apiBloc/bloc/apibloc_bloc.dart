import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/model/memeModel.dart';
import 'package:meta/meta.dart';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/blocks/todos/todos_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as mubs;
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
    const url = "https://api.imgflip.com/get_memes";
    var pathUrl = Uri.parse(url);
    try {
      var response = await mubs.get(
        pathUrl,
      );
      log("dataaaaaaaa${response.body}");
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        String responseString = response.body;
        MemeModel data = memeModelFromJson(responseString);
        emit(DataLoaded(meme: data));
        // return memeModelFromJson(responseString);
      }
    } on SocketException {
      emit(const ErrorState(errorMessage: "Network Error"));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
