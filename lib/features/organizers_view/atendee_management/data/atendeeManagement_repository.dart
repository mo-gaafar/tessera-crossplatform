import 'package:tessera/core/services/networking/networking.dart';

import 'package:tessera/core/services/networking/networking.dart';

class AtendeeManagementRepository {
  Future addAtendee(String id, var data, String token) async {
    print('data');
    print(data);
    try {
      final response = await NetworkService.getPostApiResponse(
          'https://www.tessera.social/api/manage-attendee/addattendee/$id',
          data,
          token: token);
      if (response['success'] == true) {
        return 'Attendee Added successfully';
      }
      return response['message'];
    } catch (e) {
      return 'Error from the backend';
    }
  }

  Future getEventTicketTier(String id, String token) async {
    //   try {
    //     List allEventsTicketTierByuser = [];
    //     final response = await NetworkService.getGetApiResponseOrganizer(
    //         'https://www.tessera.social/api/event-tickets/retrieve-event-ticket-tier/64560b5b36af37a7a313b0d6');
    //     print(response);
    //     if (response == null || response['ticketTiers'].length == 0) {
    //       return 'No Events';
    //     } else {
    //       if (response['success'] == true) {
    //         for (int i = 0; i < response['ticketTiers'].length; i++) {
    //           String? currency;
    //           String? price;
    //           int? availableTickets;
    //           String? tempQuantitySold;
    //           if (response['ticketTiers'][i]['price'].contains('\$')) {
    //             currency = response['ticketTiers'][i]['price'].substring(0, 1);
    //             price = response['ticketTiers'][i]['price']
    //                 .substring(1, response['ticketTiers'][i]['price'].length);
    //           } else {
    //             currency = '';
    //             price = response['ticketTiers'][i]['price'];
    //           }
    //           print('maxCapacity ${i}: ' +
    //               '${int.parse(response['ticketTiers'][i]["maxCapacity"].toString())}');
    //           if (response['ticketTiers'][i]["percentageSold"] == null) {
    //             tempQuantitySold = response['ticketTiers'][i]["maxCapacity"];
    //           } else {
    //             tempQuantitySold = '0';
    //           }
    //           print('tempQuantitySold ${i}: ' + '${tempQuantitySold}');
    //           availableTickets = int.parse(
    //                   response['ticketTiers'][i]["maxCapacity"].toString()) -
    //               int.parse(tempQuantitySold!);
    //           allEventsTicketTierByuser.add([
    //             response['ticketTiers'][i]['tierName'],
    //             availableTickets.toString(),
    //             price,
    //             currency
    //           ]);
    //         }
    //         print(allEventsTicketTierByuser);
    //         return allEventsTicketTierByuser;
    //       }
    //       return 'Network Error';
    //     }
    //   } catch (e) {
    //     return 'Network Error';
    //   }

    List allEventsTicketTierByuser = [];
    final response = await NetworkService.getGetApiResponse(
        'https://www.tessera.social/api/event-tickets/retrieve-event-ticket-tier/$id',
        token: token);
    print(response);
    if (response == null || response['ticketTiers'].length == 0) {
      return 'No Events';
    } else {
      if (response['success'] == true) {
        for (int i = 0; i < response['ticketTiers'].length; i++) {
          String? currency;
          String? price;
          int? availableTickets;
          String? tempQuantitySold;
          if (response['ticketTiers'][i]['price'].contains('\$')) {
            currency = response['ticketTiers'][i]['price'].substring(0, 1);
            price = response['ticketTiers'][i]['price']
                .substring(1, response['ticketTiers'][i]['price'].length);
          } else {
            currency = '';
            price = response['ticketTiers'][i]['price'];
          }

          if (response['ticketTiers'][i]["percentageSold"] == null) {
            tempQuantitySold = '0';
          } else {
            tempQuantitySold =
                response['ticketTiers'][i]["quantitySold"].toString();
          }
          availableTickets =
              int.parse(response['ticketTiers'][i]["maxCapacity"].toString()) -
                  int.parse(tempQuantitySold);
          allEventsTicketTierByuser.add([
            response['ticketTiers'][i]['tierName'],
            availableTickets.toString(),
            price,
            currency
          ]);
        }
        print(allEventsTicketTierByuser);
        return allEventsTicketTierByuser;
      }
      return 'Network Error';
    }
  }
}
