part of 'theme_cubit.dart';

/// Holds the current state of the app theme.
@immutable
class ThemeState extends Equatable {
  final ThemeData theme;

  const ThemeState({required this.theme});

  @override
  List<Object?> get props => [theme];
}
