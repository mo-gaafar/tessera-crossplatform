import '../data/tier_data.dart';

class MyCubitState {
  final List<Map> myDataList;

  MyCubitState({required this.myDataList});

  // copyWith method to create new state with updated data
  MyCubitState copyWith({List<Map>? myDataList}) {
    return MyCubitState(myDataList: myDataList ?? this.myDataList);
  }
}