import '../data/promocode_data.dart';

class PromoCubitState {
  final List<Map> ticketList;

  PromoCubitState({required this.ticketList});

  // copyWith method to create new state with updated data
  PromoCubitState copyWith({List<Map>? ticketList}) {
    return PromoCubitState(ticketList: ticketList ?? this.ticketList);
  }
}