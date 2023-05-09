part of 'promocode_cubit.dart';

abstract class PromocodeState extends Equatable {
  const PromocodeState();

  @override
  List<Object> get props => [];
}

class PromocodeInitial extends PromocodeState {}
class PromocodeAdded extends PromocodeState {}
class PromocodeImported extends PromocodeState {}
class Error extends PromocodeState {}
