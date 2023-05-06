import '../data/promocode_data.dart';

class PromocodeCubitState {
  final List<Map> ticketList;

  PromocodeCubitState({required this.ticketList});

  // copyWith method to create new state with updated data
  PromocodeCubitState copyWith({List<Map>? ticketList}) {
    return PromocodeCubitState(ticketList: ticketList ?? this.ticketList);
  }
}