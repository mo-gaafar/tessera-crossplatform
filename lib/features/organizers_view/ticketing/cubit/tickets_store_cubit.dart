import 'package:bloc/bloc.dart';
import 'package:tessera/features/organizers_view/ticketing/cubit/tickets_store.dart';

import '../data/tier_data.dart';

class MyCubit extends Cubit<MyCubitState> {
  MyCubit() : super(MyCubitState(myDataList: []));

  // method to add a new data object to the list
  void addData(Map newData) {
    final newState = state.copyWith(
      myDataList: List<Map>.from(state.myDataList)..add(newData),
    );
    emit(newState);
  }

  // method to update a data object in the list
  void updateData(int index, Map newData) {
    final newList = List<Map>.from(state.myDataList);
    newList[index] = newData;
    final newState = state.copyWith(myDataList: newList);
    emit(newState);
  }

  // method to remove a data object from the list
  void removeData(int index) {
    final newList = List<Map>.from(state.myDataList)..removeAt(index);
    final newState = state.copyWith(myDataList: newList);
    emit(newState);
  }
}