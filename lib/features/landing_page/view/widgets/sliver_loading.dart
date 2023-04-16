import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';

/// Displays a loading indicator when the events are being fetched.
///
/// Compatible with [SliverList].
class SliverLoading extends StatelessWidget {
  const SliverLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<EventsFilterCubit, EventsFilterState>(
        builder: (context, state) {
          return state is EventsLoading
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const CircularProgressIndicator.adaptive(),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
