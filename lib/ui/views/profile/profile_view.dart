import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/data/places_repository.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:intheloopapp/domains/onboarding_bloc/onboarding_bloc.dart';
import 'package:intheloopapp/linkify.dart';
import 'package:intheloopapp/ui/themes.dart';
import 'package:intheloopapp/ui/views/common/loading/loading_view.dart';
import 'package:intheloopapp/ui/views/error/error_view.dart';
import 'package:intheloopapp/ui/views/profile/profile_cubit.dart';
import 'package:intheloopapp/ui/widgets/profile_view/all_loops_list.dart';
import 'package:intheloopapp/ui/widgets/profile_view/badges_list.dart';
import 'package:intheloopapp/ui/widgets/profile_view/bookings_list.dart';
import 'package:intheloopapp/ui/widgets/profile_view/follow_button.dart';
import 'package:intheloopapp/ui/widgets/profile_view/follower_count.dart';
import 'package:intheloopapp/ui/widgets/profile_view/following_count.dart';
import 'package:intheloopapp/ui/widgets/profile_view/request_to_book.dart';
import 'package:intheloopapp/ui/widgets/profile_view/share_profile_button.dart';
import 'package:intheloopapp/ui/widgets/profile_view/social_media_icons.dart';
import 'package:intheloopapp/utils.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({
    required this.visitedUserId,
    super.key,
  });

  final String visitedUserId;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String get visitedUserId => widget.visitedUserId;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  List<Widget> _profileTabBar() {
    final tabs = [
      const Tab(
        text: 'LOOPS',
        icon: Icon(Icons.audiotrack),
      ),
      const Tab(
        text: 'BOOKINGS',
        icon: Icon(CupertinoIcons.tickets_fill),
      ),
      const Tab(
        text: 'BADGES',
        icon: Icon(Icons.shield),
      ),
    ];

    return tabs;
  }

  Widget _badgesTab() => BadgesList(scrollController: _scrollController);
  Widget _loopsTab() => AllLoopsList(scrollController: _scrollController);
  Widget _bookingsTab() => BookingsList(scrollController: _scrollController);

  List<Widget> _profileTabs() {
    final tabs = [
      _loopsTab(),
      _bookingsTab(),
      _badgesTab(),
    ];

    return tabs;
  }

  Widget _profilePage(
    UserModel currentUser,
    UserModel visitedUser,
    DatabaseRepository databaseRepository,
    PlacesRepository places,
  ) =>
      BlocProvider(
        create: (context) => ProfileCubit(
          places: places,
          databaseRepository: databaseRepository,
          currentUser: currentUser,
          visitedUser: visitedUser,
        )
          ..initLoops()
          ..initBadges()
          ..initBookings()
          // ..initUserCreatedBadges()
          ..loadIsFollowing(currentUser.id, visitedUser.id)
          ..loadIsVerified(visitedUser.id)
          ..initPlace(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final tabs = _profileTabBar();

            return BlocListener<OnboardingBloc, OnboardingState>(
              listener: (context, userState) {
                if (userState is Onboarded) {
                  if (userState.currentUser.id == visitedUser.id) {
                    context
                        .read<ProfileCubit>()
                        .refetchVisitedUser(newUserData: userState.currentUser);
                  }
                }
              },
              child: RefreshIndicator(
                displacement: 20,
                notificationPredicate: (notification) {
                  // with NestedScrollView local(depth == 2)
                  // OverscrollNotification are not sent
                  if (notification is OverscrollNotification ||
                      Platform.isIOS) {
                    return notification.depth == 2;
                  }
                  return notification.depth == 0;
                },
                onRefresh: () async {
                  context.read<ProfileCubit>()
                    // ignore: unawaited_futures
                    ..initLoops()
                    // ignore: unawaited_futures
                    ..initBadges()
                    // ignore: unawaited_futures
                    ..initBookings()
                    // ignore: unawaited_futures
                    ..refetchVisitedUser()
                    // ignore: unawaited_futures
                    ..loadIsFollowing(currentUser.id, visitedUser.id)
                    // ignore: unawaited_futures
                    ..loadIsVerified(visitedUser.id);
                },
                child: DefaultTabController(
                  length: tabs.length,
                  child: NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          expandedHeight: 300,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            titlePadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            centerTitle: false,
                            title: Text.rich(
                              TextSpan(
                                text: visitedUser.artistName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                                children: [
                                  if (state.isVerified)
                                    const WidgetSpan(
                                      child: Icon(
                                        Icons.verified,
                                        size: 18,
                                        color: tappedAccent,
                                      ),
                                      alignment: PlaceholderAlignment.middle,
                                    )
                                  else
                                    const WidgetSpan(
                                      child: SizedBox.shrink(),
                                    ),
                                ],
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                            ),
                            background: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (visitedUser.profilePicture == null)
                                      ? const AssetImage(
                                          'assets/default_avatar.png',
                                        ) as ImageProvider
                                      : CachedNetworkImageProvider(
                                          visitedUser.profilePicture!,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '@${visitedUser.username}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF757575),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    if (visitedUser.label != 'None')
                                      Text(
                                        visitedUser.label,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF757575),
                                        ),
                                      ),
                                  ],
                                ),
                                const ShareProfileButton(),
                                const FollowButton(),
                              ],
                            ),
                          ),
                        ),
                        if (visitedUser.occupations.isNotEmpty)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              child: Text(
                                visitedUser.occupations.join(', '),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: tappedAccent,
                                ),
                              ),
                            ),
                          ),
                        if (visitedUser.bio.isNotEmpty)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              child: Linkify(
                                text: visitedUser.bio,
                                maxLines: 6,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  // color: Color(0xFF757575),
                                ),
                              ),
                            ),
                          ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const FollowerCount(),
                                const FollowingCount(),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.location,
                                      color: tappedAccent,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      formattedAddress(
                                        state.place.addressComponents,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: tappedAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: SocialMediaIcons(),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: RequestToBookButton(),
                        ),
                        SliverOverlapAbsorber(
                          // This widget takes the overlapping behavior of the
                          // SliverAppBar,
                          // and redirects it to the SliverOverlapInjector below
                          // If it is
                          // missing, then it is possible for the nested "inner"
                          // scroll view
                          // below to end up under the SliverAppBar even when
                          // the inner
                          // scroll view thinks it has not been scrolled.
                          // This is not necessary if the "headerSliverBuilder"
                          // only builds
                          // widgets that do not overlap the next sliver.
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context,
                          ),
                          sliver: SliverPersistentHeader(
                            pinned: true,
                            delegate: _SliverAppBarDelegate(
                              TabBar(
                                tabs: tabs,
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: _profileTabs(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    final databaseRepository =
        RepositoryProvider.of<DatabaseRepository>(context);
    final places = RepositoryProvider.of<PlacesRepository>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocSelector<OnboardingBloc, OnboardingState, UserModel?>(
        selector: (state) => (state is Onboarded) ? state.currentUser : null,
        builder: (context, currentUser) {
          if (currentUser == null) {
            return const ErrorView();
          }

          return currentUser.id != visitedUserId
              ? FutureBuilder<Option<UserModel>>(
                  future: databaseRepository.getUserById(visitedUserId),
                  builder: (context, snapshot) {
                    final user = snapshot.data;

                    return switch (user) {
                      null => const LoadingView(),
                      None() => const LoadingView(),
                      Some(:final value) => _profilePage(
                          currentUser,
                          value,
                          databaseRepository,
                          places,
                        ),
                    };
                  },
                )
              : _profilePage(
                  currentUser,
                  currentUser,
                  databaseRepository,
                  places,
                );
        },
      ),
    );
  }
}
