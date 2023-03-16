/// The repository class of a certain feature should:
///   - Implement functions that make the required api calls using NetworkHelper
///   - Await the response and then pass it to the Model class's fromJson method
///   - Return the Model object
/// 
/// 
/// 
/// 
/// EXAMPLE
/// 
/// class RandomNumberRepository {
///   static Future<RandomNumber> fetchRandomNumber() async {
///     try {
///       final response = await NetworkHelper.getGetApiResponse(
///           'https://csrng.net/csrng/csrng.php?min=0&max=100');
///
///       return RandomNumber.fromJson(response[0]);
///     } catch (e) {
///       rethrow;
///     }
///   }
/// }