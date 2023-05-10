import 'dart:convert';

/// Model class representing the ticekts's data.
class TicketModel {
  final String nameAndPrice;
  int ticketsNumber;
  bool ticketTierSelected;
  
  final bool capacityFull;

  /// Creates a [TicketModel] from given user data.
  ///
  /// Requires [price] , [ticketsNumber] , [ticketTierSelected] and [capacityFull]
  TicketModel( 
      {
        required this.nameAndPrice,
        this.ticketsNumber=0,
       this.ticketTierSelected=false,
       
      required this.capacityFull,
      });

  /// Creates a [TicketModel] from a [Map].
  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
        nameAndPrice: map['nameAndPrice'] as String,
        ticketsNumber: map['ticketsNumber'] as int,
        ticketTierSelected: map['ticketTierSelected'] as bool,
        
        capacityFull: map['capacityFull'] as bool);
  }

  /// Returns a [Map] representation of the [EventModel].
  Map<String, dynamic> toMap() => {
        'nameAndPrice':nameAndPrice,
        'ticketsNumber': ticketsNumber,
        'ticketTierSelected': ticketTierSelected,
        
        'capacityFull': capacityFull,
      };

  /// Encodes the [EventModel] to JSON.
  String toJson() => json.encode(toMap());

  /// Decodes the [EventModel] from JSON.
  factory TicketModel.fromJson(String source) =>
      TicketModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
