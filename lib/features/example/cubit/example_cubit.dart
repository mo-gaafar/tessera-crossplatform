/// Cubits act as the ViewModel, they are responsible for:
///   - Detecting UI triggers and sending requests to repositories
///   - Recieving responses and updating presentation layer with new states
/// 
/// 
/// Cubits are split into _cubit.dart and _state.dart
/// 
/// _cubit.dart implements constructor with initial state,
/// as well as any other methods that contain logic needed to be implemented on
/// UI triggers, such as calls to repository functions that make api requests.
/// They should emit() a new state.
/// 
/// _state.dart contains classes of all possible states.
/// 
/// 
/// 
/// 
/// EXAMPLE
/// 
/// 
/// part 'counter_state.dart';
///
/// class CounterCubit extends Cubit<CounterState> {
///   CounterCubit() : super(CounterState(counterValue: 0));
///
///   void increment() => emit(
///       CounterState(counterValue: state.counterValue + 1, wasIncremented: true));
///
///   void decrement() => emit(CounterState(
///       counterValue: state.counterValue - 1, wasIncremented: false));
/// }
