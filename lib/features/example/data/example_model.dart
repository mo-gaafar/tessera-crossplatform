/// Model classes serialize incoming json responses to dart objects
/// 
/// 
/// EXAMPLE
/// 
/// class RandomNumber {
///   late String status;
///   late int min;
///   late int max;
///   late int random;
///
///   RandomNumber(
///     this.status,
///     this.min,
///     this.max,
///     this.random,
///   );
///
///   RandomNumber.fromJson(Map<String, dynamic> json) {
///     status = json['status'];
///     min = json['min'];
///     max = json['max'];
///     random = json['random'];
///   }
/// }