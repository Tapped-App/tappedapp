import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/ui/bookings/bookings_view.dart';
import 'package:intheloopapp/ui/loops_feeds_list/loop_feeds_list_view.dart';
import 'package:intheloopapp/ui/profile/profile_view.dart';
import 'package:intheloopapp/ui/record_label/subscribed_view.dart';
import 'package:intheloopapp/ui/search/search_view.dart';
import 'package:intheloopapp/ui/shell/components/bottom_toolbar.dart';
import 'package:intheloopapp/utils/current_user_builder.dart';

class ShellView extends StatefulWidget {
  const ShellView({
    super.key,
    this.initialTab = 0,
  });

  final int initialTab;

  @override
  State<ShellView> createState() => _ShellViewState();
}

class _ShellViewState extends State<ShellView> {
  late final FocusNode searchFocusNode;

  @override
  void initState() {
    searchFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CurrentUserBuilder(
      builder: (context, currentUser) {
        return BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return Scaffold(
              body: IndexedStack(
                index: state.selectedTab,
                children: [
                  const LoopFeedsListView(), // getstream.io activity feed?
                  SearchView(
                    searchFocusNode: searchFocusNode,
                  ),
                  const BookingsView(),
                  const SubscribedView(),
                  ProfileView(
                    visitedUserId: currentUser.id,
                    visitedUser: Some(currentUser),
                  ),
                ],
              ),
              bottomNavigationBar: BottomToolbar(
                user: currentUser,
                searchFocusNode: searchFocusNode,
              ),
            );
          },
        );
      },
    );
  }
}
