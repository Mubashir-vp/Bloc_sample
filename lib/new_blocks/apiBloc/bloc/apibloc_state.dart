part of 'apibloc_bloc.dart';

@immutable
abstract class ApiblocState extends Equatable {
  const ApiblocState();
  @override
  List<Object> get props => [];
}

class DataLoading extends ApiblocState {}

class DataLoaded extends ApiblocState {
  final Weather weather;
  const DataLoaded({required this.weather});
  @override
  List<Object> get props => [weather];
}

class ErrorState extends ApiblocState {
  final String errorMessage;
  const ErrorState({required this.errorMessage});
}
