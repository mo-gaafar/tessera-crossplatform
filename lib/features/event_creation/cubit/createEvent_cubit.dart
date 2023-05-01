import 'createEvent_state.dart';
import 'package:bloc/bloc.dart';
import 'package:tessera/features/event_creation/data/newEvent_Model.dart';

/// Cubit handling all data related to creation of a new event.
///
/// Makes use of [CreateEventRepository] to make API calls to the backend server and retrieve data.
class CreateEventCubit extends Cubit<CreateEventState> {
  /// The current event state and basic info.
  late CreateEventCubit _createEventCubit;

  /// The current event that is being created. Available throughout the app.
  NewEventModel currentEvent = NewEventModel();
  CreateEventCubit() : super(CreateEventInitial());

  void displayError({String? errormessage}) {
    emit(CreateEventError(message: errormessage!));
  }
}
