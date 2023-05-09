import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

///states that the cubit emit
abstract class AtendeeManagementState extends Equatable {
  const AtendeeManagementState();

  @override
  List<Object> get props => [];
}

class AtendeeManagementInitial extends AtendeeManagementState {}

class AtendeeManagementError extends AtendeeManagementState {
  final String message;

  const AtendeeManagementError({this.message = 'An error occured'});
}
class AtendeeManagementInfo extends AtendeeManagementState {
  final String? ticketsTotalPrice;
  AtendeeManagementInfo({this.ticketsTotalPrice});
}
