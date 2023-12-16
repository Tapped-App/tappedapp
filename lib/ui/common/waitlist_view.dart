import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/ui/common/easter_egg_placeholder.dart';
import 'package:intheloopapp/utils/current_user_builder.dart';

class WaitlistView extends StatefulWidget {
  const WaitlistView({super.key});

  @override
  State<WaitlistView> createState() => _WaitlistViewState();
}

class _WaitlistViewState extends State<WaitlistView> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final database = context.read<DatabaseRepository>();

    if (_loading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    return CurrentUserBuilder(
      builder: (context, currentUser) {
        return Scaffold(
          backgroundColor: theme.colorScheme.background,
          appBar: AppBar(),
          body: FutureBuilder(
            future: database.isOnPremiumWailist(currentUser.id),
            builder: (context, snapshot) {
              final isOnWaitlist = snapshot.data;
              return switch (isOnWaitlist) {
                null => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                false => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                true => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: double.infinity),
                        const EasterEggPlaceholder(
                          text: "you've reached your daily application quota",
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'join the waitlist to get unlimited daily opportunities!',
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () {
                            // apply for the waitlist
                            setState(() {
                              _loading = true;
                            });

                            database.joinPremiumWaitlist(currentUser.id).then(
                              (value) {
                                context.pop();
                                setState(() {
                                  _loading = false;
                                });
                              },
                            );
                          },
                          child: const Text('sign me up'),
                        ),
                      ],
                    ),
                  ),
              };
            },
          ),
        );
      },
    );
  }
}
