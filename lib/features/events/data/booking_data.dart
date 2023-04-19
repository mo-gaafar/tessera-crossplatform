
/// Model class representing the booking's data.
class BookingModel {
  final Map contactInformation;
  String? promocode;
  final List<dynamic> ticketTierSelected;

  /// Creates a [BookingModel] from given user data.
  ///
  /// Only [contactInformation] and [ticketTierSelected] are required.
  BookingModel(
      {required this.contactInformation,
      this.promocode,
      required this.ticketTierSelected});
  /// Creates a [BookingModel] from a [Map].
  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      contactInformation: map['contactInformation'] as Map,
      promocode: map['promocode'] != null ? map['promocode'] as String : null,
      ticketTierSelected: map['ticketTierSelected'] as List<dynamic>,
    );
  }
  /// Returns a [Map] representation of the [BookingModel].
  Map<String, dynamic> toMap() => {
        'contactInformation': contactInformation,
        'promocode': promocode,
        'ticketTierSelected': ticketTierSelected,
      };
}
/// A class representing the [ContactInformation] data.
class ContactInformation {
  final String firstName;
  final String lastName;
  final String email;

  /// Creates a [ContactInformation] from given user data.
  ///
  ///  [firstName] , [lastName] , [email] are required.
  ContactInformation(
      {required this.firstName, required this.lastName, required this.email});
  /// Creates a [ContactInformation] from a [Map].
  factory ContactInformation.fromMap(Map<String, dynamic> map) {
    return ContactInformation(
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String,
    );
  }
  /// Returns a [Map] representation of the [ContactInformation].
  Map<String, dynamic> toMap() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      };
}
/// A class representing the [TicketTierSelected] data.
class TicketTierSelected {
  final String tierName;
  final int quantity;
  final int price;
  /// Creates a [TicketTierSelected] from given user data.
  ///
  ///  [tierName] , [quantity] , [price] are required.
  TicketTierSelected(
      {required this.tierName, required this.quantity, required this.price});
  /// Creates a [TicketTierSelected] from a [Map].
  factory TicketTierSelected.fromMap(Map<String, dynamic> map) {
    return TicketTierSelected(
      tierName: map['tierName'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as int,
    );
  }
  /// Returns a [Map] representation of the [TicketTierSelected].
  Map<String, dynamic> toMap() => {
        'tierName': tierName,
        'quantity': quantity,
        'price': price,
      };
}
