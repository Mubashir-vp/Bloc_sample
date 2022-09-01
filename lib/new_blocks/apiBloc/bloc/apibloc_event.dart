part of 'apibloc_bloc.dart';

@immutable
abstract class ApiblocEvent {
    const ApiblocEvent();
  @override
  List<Object> get props => [];

}
class LoadData extends ApiblocEvent {
   final List<MemeModel> meme;
 const LoadData({this.meme=const <MemeModel>[]} );
 @override
  List<Object> get props => [meme];
}
