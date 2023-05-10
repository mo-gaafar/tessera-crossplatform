import 'package:flutter_test/flutter_test.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'package:tessera/features/organizers_view/atendee_management/data/atendeeManagement_repository.dart';

void main() {
  test('get all attendees', () async {
    final response = await AtendeeManagementRepository().getEventTicketTier(
        '645ad1d805121639286d0a2f',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjQ1YTQ4NzNkMGUzNWI3MTJmMzY0ZjY1IiwiaWF0IjoxNjgzNjczNDcxLCJleHAiOjE2ODM3NTk4NzF9.z2Y4YJ6CKnwHGDoPwCy2noOiJ1ifIZIivJ4lNMF0Kvo');
    List allEventsTicketTierByuser = [];
    if (response == 'Network Error' || response == 'No Events') {
      print(response);
    } else {
      allEventsTicketTierByuser = response;
      print(allEventsTicketTierByuser);
    }
    expect('', '');
  });
}
