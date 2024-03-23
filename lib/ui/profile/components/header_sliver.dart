import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intheloopapp/data/auth_repository.dart';
import 'package:intheloopapp/domains/models/social_following.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/navigation_bloc/tapped_route.dart';
import 'package:intheloopapp/ui/profile/components/feedback_button.dart';
import 'package:intheloopapp/ui/profile/components/follower_count.dart';
import 'package:intheloopapp/ui/profile/components/message_button.dart';
import 'package:intheloopapp/ui/profile/components/request_to_book.dart';
import 'package:intheloopapp/ui/profile/components/request_to_perform.dart';
import 'package:intheloopapp/ui/profile/components/review_count.dart';
import 'package:intheloopapp/ui/profile/components/settings_button.dart';
import 'package:intheloopapp/ui/profile/components/star_rating.dart';
import 'package:intheloopapp/ui/profile/profile_cubit.dart';
import 'package:intheloopapp/utils/custom_claims_builder.dart';

class HeaderSliver extends StatelessWidget {
  const HeaderSliver({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final isCurrentUser = state.currentUser.id == state.visitedUser.id;
          return Column(
            children: [
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (state.visitedUser.socialFollowing.audienceSize > 0 ||
                      isCurrentUser)
                    const FollowerCount(),
                  const ReviewCount(),
                  const StarRating(),
                ],
              ),
              const SizedBox(height: 12),
              if (!isCurrentUser && !state.visitedUser.unclaimed)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: MessageButton(),
                    ),
                  ],
                ),
              if (!isCurrentUser && state.visitedUser.unclaimed)
                RequestToPerform(
                  venue: state.visitedUser,
                ),
              if (isCurrentUser)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SettingsButton(),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: FeedbackButton(),
                    ),
                  ],
                ),
              if (!isCurrentUser && state.services.isNotEmpty)
                const SizedBox(height: 8),
              if (!isCurrentUser && state.services.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: RequestToBookButton(
                    user: state.visitedUser,
                    service: const None(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
