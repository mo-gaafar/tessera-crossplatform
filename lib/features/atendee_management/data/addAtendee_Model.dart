import 'dart:convert';
import 'dart:io';

class AddAtendeeModel {
  String? organiserfirstName =
      'tessera'; //should be initialized with organizer cubit
  String? organiserlasteName =
      'backend'; //should be initialized with organizer cubit
  String? organiserEmail =
      'tessera.backend@gmail.com'; //should be initialized with organizer cubit
  String? atendeeFirstName;
  String? atendeeLastName;
  String? atendeeEmail;
  String? ticketTierName;
  String? ticketQuantity;
  String? ticketPrice; //should be initialized from the ticket tier cubit
  bool ticketisFree = false; //should be initialized from the ticket tier cubit

  /// Returns a [Map] representation of the [AddAtendeeModel].
  Map<String, dynamic> toMap() {
    List listOFAtendees = [];
    for (int i = 0;
        i < int.parse((ticketQuantity == null) ? '0' : ticketQuantity!);
        i++) {
      listOFAtendees.add(
        {
          "firstname": atendeeFirstName,
          "lastname": atendeeLastName,
          "email": atendeeEmail
        },
      );
    }
    return <String, dynamic>{
      "contactInformation": {
        "first_name": organiserfirstName.toString(),
        "last_name": organiserlasteName.toString(),
        "email": organiserEmail.toString()
      },
      "promocode": null,
      "SendEmail": true,
      "ticketTierSelected": [
        {
          "tierName": ticketTierName.toString(),
          "quantity": int.parse(ticketQuantity.toString()),
          "price":
              (ticketisFree == true) ? 0 : int.parse(ticketPrice.toString()),
          "tickets": listOFAtendees.toList()
        }
      ]
    };
  }

  /// Encodes the [AddAtendeeModel] to JSON.
  String toJson() => json.encode(toMap());

  /// Returns a [String] representation of the [AddAtendeeModel].
  @override
  String toString() {
    return 'AddAtendeeModel(organiserfirstName: $organiserfirstName, organiserlasteName: $organiserlasteName, organiserEmail: $organiserEmail, atendeeFirstName: $atendeeFirstName, atendeeLastName: $atendeeLastName, ticketTierName: $ticketTierName,ticketQuantity: $ticketQuantity,ticketPrice: $ticketPrice)';
  }
}
