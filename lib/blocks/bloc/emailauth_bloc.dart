import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'emailauth_event.dart';
part 'emailauth_state.dart';

class EmailauthBloc extends Bloc<EmailauthEvent, EmailauthState> {
  EmailauthBloc() : super(EmailauthInitial()) {
    on<EmailauthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
