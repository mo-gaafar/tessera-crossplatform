import 'package:bloc/bloc.dart';
import 'package:tessera/features/organizers_view/atendee_management/data/addAtendee_Model.dart';
import 'atendeeManagement_state.dart';

// Cubit handling all data related to creation of a new event.
///
/// Makes use of [atendeeManagemntRepository] to make API calls to the backend server and retrieve data.
class AtendeeManagementCubit extends Cubit<AtendeeManagementState> {
  /// The current event state and basic info.
  late AtendeeManagementCubit _atendeeManagementCubit;

  AddAtendeeModel atendeeModel = AddAtendeeModel();

  /// The current event that is being created. Available throughout the app.

  AtendeeManagementCubit() : super(AtendeeManagementInitial());
  void displayError({String? errormessage}) {
    emit(AtendeeManagementInitial());
    emit(AtendeeManagementError(message: errormessage!));
  }

  void updateAtendeeInfo({String? ticketsTotalPrice}) {
    emit(AtendeeManagementInitial());
    emit(AtendeeManagementInfo(ticketsTotalPrice: ticketsTotalPrice));
    atendeeModel.totalTicketsPrice = ticketsTotalPrice!;
  }
}
