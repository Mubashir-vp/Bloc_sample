part of 'emailauth_bloc.dart';

@immutable
abstract class EmailauthState {
  const EmailauthState();
  @override
  List<Object?> get props => [];
}

class EmailauthInitial extends EmailauthState {
  @override
  List<Object?> get props => [];
}

class EmaiAuthenticationSuccess extends EmailauthState {
  final String? displayName;
  const EmaiAuthenticationSuccess({this.displayName});
  @override
  List<Object?> get props => [displayName];
}

class EmaiAuthenticationFailure extends EmailauthState {
  @override
  List<Object?> get props => [];
}
