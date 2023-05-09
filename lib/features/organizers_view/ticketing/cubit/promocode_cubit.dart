import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tessera/features/organizers_view/ticketing/data/promocode_repository.dart';

part 'promocode_state.dart';

class PromocodeCubit extends Cubit<PromocodeState> {
  PromocodeCubit() : super(PromocodeInitial());


  Future<String> addPromocode(String id, var data) async {
    //try {
      
      var response = await PromocodeRepository.addPromocode(data,id);

      if (response['success'] == true) {
        emit(PromocodeAdded());
        print(response);
        return 'succussfully added promocode';
      } else {
        return response['message'];
      }
    //} catch (e) {
      //emit(Error());
      //throw Exception('Error when reciving the data');
    //}
    
  }
   Future<String> importPromocode(String id,var data) async {
    try {
      
      var response = await PromocodeRepository.importPromocode(data,id);

      if (response['success'] == true) {
        emit(PromocodeImported());

        return 'succussfully impored';
      } else {
        return response['message'];
      }
    } catch (e) {
      emit(Error());
      throw Exception('Error when reciving the data');
    }
    
  }
}
