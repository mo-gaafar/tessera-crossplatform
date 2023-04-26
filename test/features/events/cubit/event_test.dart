import 'package:tessera/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tessera/features/events/cubit/event_book_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tessera/features/events/data/booking_data.dart';
import 'package:tessera/features/events/data/event_data.dart';
import 'package:tessera/main.dart';

class MockEventBook extends Mock implements EventBookCubit {}

void main() {
  //Arrange
  late MockEventBook eventBookCubit;
  late EventModel eventModel;
  late BookingModel bookingModel;

  void arrangeAuthAndPrefsMocks() {
    when(() => eventBookCubit.getEventData('123'))
        .thenAnswer((_) async => eventModel);
    when(() => eventBookCubit.postBookingData(bookingModel))
        .thenAnswer((_) async => true);
  }

  setUp(() async {
    eventModel = EventModel(
        success: 'true',
        filteredEvents: [
          {
            "basicInfo": {
              "location": {
                "longitude": 45.523064,
                "latitude": -122.676483,
                "placeId": "ChIJN1t_tDeuEmsRUsoyG83frY4",
                "venueName": "My Venue",
                "streetNumber": 123,
                "route": "Main St",
                "administrativeAreaLevel1": "OR",
                "country": "US",
                "city": "Portland"
              },
              "eventName": "Cross Platform",
              "startDateTime": "2023-05-01T14:30:00.000Z",
              "endDateTime": "2023-05-01T18:00:00.000Z",
              "eventImage": "https://picsum.photos/282/140",
              "categories": "Music"
            },
            "summary": "Join us for an evening of live music!",
            "description":
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, purus sed tempus luctus, nunc sapien lacinia metus, eu finibus velit odio vel nulla.",
            "ticketTiers": [
              {
                "tierName": "Regular",
                "quantitySold": 0,
                "maxCapacity": 100,
                "price": "20",
                "startSelling": "2023-04-14T00:00:00.000Z",
                "endSelling": "2023-05-01T14:30:00.000Z",
                "_id": "643ad9af53ce2a393ad6a23f"
              },
              {
                "tierName": "VIP",
                "quantitySold": 0,
                "maxCapacity": 50,
                "price": "50",
                "startSelling": "2023-04-14T00:00:00.000Z",
                "endSelling": "2023-05-01T14:30:00.000Z",
                "_id": "643ad9af53ce2a393ad6a240"
              }
            ],
            "isOnline": false,
            "eventUrl": "https://example.com/my-event",
            "creatorId": {
              "_id": "643a56706f55e9085d193f48",
              "firstName": "Zeekoo",
              "lastName": "john"
            }
          }
        ],
        tierCapacityFull: [
          {"tierName": "Regular", "isCapacityFull": false},
          {"tierName": "VIP", "isCapacityFull": false}
        ],
        isEventCapacityFull: false,
        isEventFree: false);
    bookingModel = BookingModel(
        contactInformation: {
          "first_name": "tessera",
          "last_name": "backend",
          "email": "tessera.backend@gmail.com"
        },
        promocode: "summer30",
        ticketTierSelected: [
          {"tierName": "VIP", "quantity": 3, "price": 500},
          {"tierName": "Regular", "quantity": 2, "price": 120}
        ]);
    eventBookCubit = MockEventBook();
    arrangeAuthAndPrefsMocks();
  });

  test(
    "should return EventBookCubit state when first initialized",
    () => expect(eventBookCubit.state, EventInitial()),
  );

  test(
    "should emit EventLoading and EventChosen state when getEventData() is called",
    () async {
      final future = eventBookCubit.getEventData('123');
      // Assert
      expect(eventBookCubit.state, EventLoading());

      // Act
      await future;
      // Assert
      expect(eventBookCubit.state, EventChosen());
    },
  );

  test(
    "should emit EventLoading state when getEventData() is called",
    () async {
      // Act
      await eventBookCubit.postBookingData(bookingModel);
      // Assert
      expect(eventBookCubit.state, EventSuccessfullyBooked());
    },
  );
}
