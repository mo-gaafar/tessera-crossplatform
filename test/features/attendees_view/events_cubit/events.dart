import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tessera/features/attendees_view/events/cubit/event_book_cubit.dart';
import 'package:tessera/features/attendees_view/events/data/event_data.dart';
import 'package:tessera/features/attendees_view/events/data/event_repository.dart';
import 'package:tessera/features/attendees_view/events_filter/cubit/events_filter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tessera/features/attendees_view/events/data/event_repository.dart';

class MockEventRepository extends Mock implements EventRepository {
  @override
  Future<Map<String, dynamic>> eventBasicInfo(String id) {
    return Future.value({
      'name': 'Test Event',
      'location': 'Test Location',
      'date': '2023-05-20',
      // add other fields as needed
    });
  }
}

void main() {
  group('EventBookCubit', () {
    late MockEventRepository mockRepository;
    late EventBookCubit cubit;

    setUp(() {
      mockRepository = MockEventRepository();
      cubit = EventBookCubit();
    });

    test('emits EventChosen when getEventData is successful', () async {
      // arrange
      final id = '123';
      final expectedEvent = EventModel.fromMap({
        'name': 'Test Event',
        'location': 'Test Location',
        'date': '2023-05-20',
        // add other fields as needed
      });

      when(mockRepository.eventBasicInfo(id)).thenAnswer((_) async => {
            'name': 'Test Event',
            'location': 'Test Location',
            'date': '2023-05-20',
            // add other fields as needed
          });

      // act
      final result = await cubit.getEventData(id);

      // assert
      expect(result, equals(expectedEvent));
      expect(cubit.state, equals(EventChosen()));
      verify(mockRepository.eventBasicInfo(id)).called(1);
    });

    test('emits Error when getEventData fails', () async {
      // arrange
      final id = '123';

      when(mockRepository.eventBasicInfo(id)).thenThrow(Exception());

      // act
      expect(() => cubit.getEventData(id), throwsException);

      // assert
      expect(cubit.state, equals(Error()));
      verify(mockRepository.eventBasicInfo(id)).called(1);
    });
  });
}
