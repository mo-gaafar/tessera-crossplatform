import 'dart:convert';

import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'package:tessera/features/atendee_management/cubit/atendeeManagement_cubit.dart';
import 'package:tessera/features/event_creation/data/organiser_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:tessera/core/services/networking/exceptions.dart';
import 'package:tessera/core/services/networking/networking.dart';

class AtendeeManagementRepository {
  static final Map<String, String> _headers = {
    'Accept-Charset': 'utf-8',
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjQzYTU2NzA2ZjU1ZTkwODVkMTkzZjQ4IiwiaWF0IjoxNjgzNTc0MjgxLCJleHAiOjE2ODM2NjA2ODF9.cemAiMZ5KxrH188ZWy8PEc8_lWLJu9J9BOSm9gi1ThE'
  };
  Future addAtendee(var data) async {
    print('data');
    print(data);
    try {
      final response = await NetworkService.getPostApiResponseOrganizer(
          'https://www.tessera.social/api/manage-attendee/addattendee/6454399919a17b933aed053e',
          data);
      return response['message'];
    } catch (e) {
      return 'Error from the backend';
    }
  }

  Future getEventTicketTier() async {
    try {
      List allEventsTicketTierByuser = [];
      final response = await NetworkService.getGetApiResponseOrganizer(
          'https://www.tessera.social/api/event-tickets/retrieve-event-ticket-tier/643d1fd3453ffd14bdb7284d');
      print(response);
      if (response == null || response['ticketTiers'].length == 0) {
        return 'No Events';
      } else {
        if (response['success'] == true) {
          for (int i = 0; i < response['ticketTiers'].length; i++) {
            String? currency;
            String? price;
            if (response['ticketTiers'][i]['price'].contains('\$')) {
              currency = response['ticketTiers'][i]['price'].substring(0, 1);
              price = response['ticketTiers'][i]['price']
                  .substring(1, response['ticketTiers'][i]['price'].length);
            } else {
              currency = '';
              price = response['ticketTiers'][i]['price'];
            }
            allEventsTicketTierByuser.add([
              response['ticketTiers'][i]['tierName'],
              response['ticketTiers'][i]['maxCapacity'],
              price,
              currency
            ]);
          }
          print(allEventsTicketTierByuser);
          return allEventsTicketTierByuser;
        }
        return 'Network Error';
      }
    } catch (e) {
      return 'Network Error';
    }
  }
}
