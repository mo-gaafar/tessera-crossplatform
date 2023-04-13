class FilterRepository {
  static Future<List<String>> getFilteredCategories() async {
    // TODO: Implement API call to get filtered categories.
    return categories;
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

  static Future getNearbyEvents() async {
    // TODO: Implement getNearbyEvents
    throw UnimplementedError();
  }

  static Future queryEvents() async {
    return UnimplementedError();
  }

  static Future getQueriedCategories() async {
    return UnimplementedError();
  }
}
