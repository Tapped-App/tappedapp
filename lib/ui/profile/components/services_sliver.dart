import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/ui/profile/profile_cubit.dart';
import 'package:intheloopapp/ui/settings/components/services_list.dart';
import 'package:intheloopapp/ui/themes.dart';

class ServicesSliver extends StatelessWidget {
  const ServicesSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  Text(
                    'Services',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ServicesList(
              services: state.services,
              isCurrentUser: state.currentUser.id == state.visitedUser.id,
            ),
          ],
        );
      },
    );
  }
}
