part of 'apibloc_bloc.dart';

@immutable
abstract class ApiblocEvent {
    const ApiblocEvent();
  @override
  List<Object> get props => [];

}
class LoadData extends ApiblocEvent {
   final Weather? meme;
 const LoadData({this.meme} );
 @override
  List<Object> get props => [meme!];
}
