import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/core/theme/cubit/theme_cubit.dart';
import 'package:tessera/features/events/cubit/event_book_cubit.dart';
import 'package:tessera/features/events/data/event_data.dart';
import 'package:tessera/features/events/view/pages/event_screen.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Screen'),
        actions: [
          IconButton(
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            icon: const Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            EventModel event = await context
              .read<EventBookCubit>()
              .getEventData();
            if(context.mounted)
            {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return EventPage(eventData: event);
                  }),
                );
            }

            print('hii landing page');
          },
          child: const Text('event'),
        ),
      ),
    );
  }
}