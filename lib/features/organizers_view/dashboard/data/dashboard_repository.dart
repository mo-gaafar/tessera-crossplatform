import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'package:tessera/features/organizers_view/dashboard/data/attendee_summary_model.dart';
import 'package:open_file/open_file.dart' as file;

import 'package:http/http.dart' as http;
import 'package:tessera/features/organizers_view/ticketing/data/tier_data.dart';
import 'package:url_launcher/url_launcher.dart';

/// The repository handling all api calls related to the dashboard.
class DashboardRepository {
  /// Requests the sold tickets data from the api.
  static Future<Either<String, Map>> requestTicketsSold(
      String id, String all, String tierName) async {
    try {
      var response = await NetworkService.getGetApiResponse(
          'https://www.tessera.social/api/dashboard/eventsoldtickets/events/$id?allTiers=$all&tierName=$tierName');

      if (response['success'] == true) {
        return Right({
          'tier': tierName,
          'sold': response.values.toList()[2] ?? 0,
          'total': response.values.toList()[3] ?? 0,
          'percentage': response.values.toList()[4] ?? 0,
        });
      } else {
        return Left(response['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Requests the sales data from the api.
  static Future<Either<String, int>> requestEventSales(
      String id, String all, String tierName) async {
    try {
      var response = await NetworkService.getGetApiResponse(
          'https://www.tessera.social/api/dashboard/eventsales/events/$id?allTiers=$all&tierName=$tierName');

      if (response['success'] == true) {
        return Right(response.values.last ?? 0);
      } else {
        return Left(response['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Returns a summary of attendees of the event.
  static Future<Either<String, List<AttendeeSummaryModel>>>
      requestAttendeeSummary(String id) async {
    try {
      var response = await NetworkService.getGetApiResponse(
          'https://www.tessera.social/api/dashboard/reportJason/attendees-list/$id');

      if (response['success'] == true) {
        List<AttendeeSummaryModel> attendeeSummary = [];
        final List attendees = response['attendeeSummary'];
        for (var attendee in attendees) {
          attendeeSummary.add(AttendeeSummaryModel.fromMap(attendee));
        }
        return Right(attendeeSummary);
      } else {
        return Left(response['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Dowloads the attendee summary of the event.
  static Future<String> downloadAttendeeSummary(String id, String dir) async {
    try {
      var dio = Dio();

      var response = await dio.download(
          'https://www.tessera.social/api/dashboard/report/attendees-list/$id',
          dir);

      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  /// Returns ticket tiers for the event.
  static Future<Either<String, List<TierModel>>> requestTicketTiers(
      String id) async {
    try {
      var response = await NetworkService.getGetApiResponse(
          'https://www.tessera.social/api/event-tickets/retrieve-event-ticket-tier/$id');
      if (response['success'] == true) {
        List<TierModel> ticketTiers = [];
        for (var ticket in response['ticketTiers']) {
          ticketTiers.add(TierModel.fromMap(ticket));
        }
        return Right(ticketTiers);
      } else {
        return Left(response['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
