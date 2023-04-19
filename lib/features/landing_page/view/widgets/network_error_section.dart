import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/features/events_filter/cubit/events_filter_cubit.dart';

/// Displays a network error message when a connection error occurs.
class NetworkErrorSection extends StatelessWidget {
  const NetworkErrorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_outlined,
              size: 100,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            Column(
              children: [
                const Text(
                  'Network error',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Please check your internet connection and try again.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
                CupertinoButton(
                  borderRadius: BorderRadius.circular(40),
                  // color: Theme.of(context).textTheme.bodyLarge!.color,
                  child: const Text(
                    'Try Again',
                    style: TextStyle(color: AppColors.secondary),
                  ),
                  onPressed: () async {
                    context.read<EventsFilterCubit>().attempRefresh();
                    await context.read<EventsFilterCubit>().initCriteria();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
