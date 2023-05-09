import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tessera/features/organizers_view/ticketing/data/publish_repository.dart';

part 'publish_state.dart';

class PublishCubit extends Cubit<PublishState> {
  PublishCubit() : super(PublishInitial());

  Future<dynamic> publish(String id, var data, String token) async {
    try {
      var response = await PublishRepository.publishEvent(data, id, token);
      if (response['success'] == true) {
        emit(EventPublished());

        return ['succussfully published', response['url']];
      } else {
        return [response['message'], response['url']];
      }
    } catch (e) {
      emit(Error());
      throw Exception(e.toString());
    }
  }
}
