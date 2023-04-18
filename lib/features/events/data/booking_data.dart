class BookingModel {
  final Map contactInformation;
  String? promocode;
  final List<dynamic> ticketTierSelected;

  BookingModel(
      {required this.contactInformation,
      this.promocode,
      required this.ticketTierSelected});

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      contactInformation: map['contactInformation'] as Map,
      promocode: map['promocode'] != null ? map['promocode'] as String : null,
      ticketTierSelected: map['ticketTierSelected'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toMap() => {
        'contactInformation': contactInformation,
        'promocode': promocode,
        'ticketTierSelected': ticketTierSelected,
      };
}

class ContactInformation {
  final String firstName;
  final String lastName;
  final String email;

  ContactInformation(
      {required this.firstName, required this.lastName, required this.email});

  factory ContactInformation.fromMap(Map<String, dynamic> map) {
    return ContactInformation(
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      };
}

class TicketTierSelected {
  final String tierName;
  final int quantity;
  final int price;

  TicketTierSelected(
      {required this.tierName, required this.quantity, required this.price});

  factory TicketTierSelected.fromMap(Map<String, dynamic> map) {
    return TicketTierSelected(
      tierName: map['tierName'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as int,
    );
  }

  Map<String, dynamic> toMap() => {
        'tierName': tierName,
        'quantity': quantity,
        'price': price,
      };
}
