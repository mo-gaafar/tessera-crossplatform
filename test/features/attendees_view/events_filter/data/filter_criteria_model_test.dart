import 'package:flutter_test/flutter_test.dart';
import 'package:tessera/features/attendees_view/events_filter/data/filter_criteria_model.dart';
import 'package:tessera/features/attendees_view/events_filter/view/widgets/event_filter_chip.dart';

void main() {
  late FilterCriteria filterCriteria;
  late List<EventFilterChip> filterChips;

  setUp(() {
    filterChips = [
      EventFilterChip(label: 'testChip1'),
      EventFilterChip(label: 'testChip2'),
      EventFilterChip(label: 'testChip3'),
    ];
    filterCriteria = FilterCriteria(filterChips: filterChips, type: 'testType');
  });

  group('Return chips to be displayed according to selection', () {
    test(
      "should return the entire list of chips when returnDisplayedChips() is called if none are selected",
      () async {
        // Act
        var returnedChips = filterCriteria.returnDisplayedChips();

        // Assert
        expect(filterChips, returnedChips);
      },
    );

    test(
      "should return the selected chip when returnDisplayedChips() is called and a chip is selected",
      () async {
        // Arrange
        filterChips[0].isSelected = true;

        // Act
        var returnedChips = filterCriteria.returnDisplayedChips();

        // Assert
        expect(returnedChips, [filterChips[0]]);
      },
    );
  });

  group('Selected chip label', () {
    test(
      "should return null when returnSelected() is called and no chip is selected",
      () async {
        // Act
        var returnedChips = filterCriteria.returnSelected();

        // Assert
        expect(null, returnedChips);
      },
    );

    test(
      "should return the selected chip's label when returnSelected() is called and a chip is selected",
      () async {
        // Arrange
        filterChips[0].isSelected = true;

        // Act
        var returnedChips = filterCriteria.returnSelected();

        // Assert
        expect(returnedChips, {'label': 'testChip1', 'type': 'testType'});
      },
    );
  });
}
