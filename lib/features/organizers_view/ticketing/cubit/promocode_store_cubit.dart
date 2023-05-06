import 'package:bloc/bloc.dart';
import 'package:tessera/features/organizers_view/ticketing/cubit/promocode_store.dart';

import '../data/promocode_data.dart';

class PromocodeCubit extends Cubit<PromocodeCubitState> {
  PromocodeCubit() : super(PromocodeCubitState(ticketList: []));

  // method to add a new data object to the list
  void addData(Map newData) {
    final newState = state.copyWith(
      ticketList: List<Map>.from(state.ticketList)..add(newData),
    );
    emit(newState);
  }

  // method to update a data object in the list
  void updateData(int index, Map newData) {
    final newList = List<Map>.from(state.ticketList);
    newList[index] = newData;
    final newState = state.copyWith(ticketList: newList);
    emit(newState);
  }

  // method to remove a data object from the list
  void removeData(int index) {
    final newList = List<Map>.from(state.ticketList)..removeAt(index);
    final newState = state.copyWith(ticketList: newList);
    emit(newState);
  }
}