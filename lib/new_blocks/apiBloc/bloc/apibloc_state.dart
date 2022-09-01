part of 'apibloc_bloc.dart';

@immutable
abstract class ApiblocState extends Equatable {
  const ApiblocState();
  @override
  List<Object> get props => [];
}

class DataLoading extends ApiblocState {}

class DataLoaded extends ApiblocState {
  final MemeModel meme;
  const DataLoaded({required this.meme});
  @override
  List<Object> get props => [meme];
}

class ErrorState extends ApiblocState {
  final String errorMessage;
  const ErrorState({required this.errorMessage});
}
