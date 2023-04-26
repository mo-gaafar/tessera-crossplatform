import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

class CustomSideMenuComponents extends StatelessWidget {
  const CustomSideMenuComponents({super.key});

  final fontColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final UserModel user = context.select((AuthCubit auth) => auth.currentUser);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: user.photoUrl != null
                      ? NetworkImage(user.photoUrl!)
                      : null,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: 22.0,
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Hello, ${user.username}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            onTap: () async {
              await context.read<AuthCubit>().signOut();

              if (context.read<AuthCubit>().state is SignedOut) {
                Navigator.of(context).pushReplacementNamed('/loginOptions');
              }
            },
            leading: Icon(
              Icons.logout_rounded,
              size: 20.0,
              color: Theme.of(context).iconTheme.color,
            ),
            title: const Text('Logout'),
            dense: true,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.admin_panel_settings_outlined,
              size: 20.0,
              color: Theme.of(context).iconTheme.color,
            ),
            title: const Text('Organize'),
            dense: true,
          ),
        ],
      ),
    );
  }
}
