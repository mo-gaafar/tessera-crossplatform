class FilterRepository {
  static Future<List<String>> getFilteredCategories(
      {String location = '', String isFree = '', String isOnline = ''}) async {
    // TODO: Implement API call to get filtered categories.
    throw UnimplementedError();
  }

  static List<String> categories = [
    'Food & Drink',
    'Music',
    'Charity & Causes',
  ];

  static List<String> dates = [
    'Today',
    'Tomorrow',
    'This Week',
    'This Weekend',
    'Next Week'
  ];
}
