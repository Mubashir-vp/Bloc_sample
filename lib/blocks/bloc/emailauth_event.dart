part of 'emailauth_bloc.dart';

@immutable
abstract class EmailauthEvent extends Equatable {
  const EmailauthEvent();
   @override
  List<Object> get props => [];
}
class EmailAuthStarted extends EmailauthEvent {
      @override
  List<Object> get props => [];
}
class AuthenticationSignedOut extends EmailauthEvent {
      @override
  List<Object> get props => [];
}