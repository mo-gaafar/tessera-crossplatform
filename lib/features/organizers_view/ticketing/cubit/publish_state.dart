part of 'publish_cubit.dart';

abstract class PublishState extends Equatable {
  const PublishState();

  @override
  List<Object> get props => [];
}

class PublishInitial extends PublishState {}
class EventPublished extends PublishState {}
class Error extends PublishState {}
