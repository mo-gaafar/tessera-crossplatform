import 'createEvent_cubit.dart';
import 'package:equatable/equatable.dart';
///states that the cubit emit
abstract class CreateEventState extends Equatable {
  const CreateEventState();

  @override
  List<Object> get props => [];
}
class CreateEventInitial extends CreateEventState {}
class CreateEventError extends CreateEventState {
  final String message;

  const CreateEventError({this.message = 'An error occured'});
}