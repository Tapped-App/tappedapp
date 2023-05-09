import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/ui/views/profile/profile_cubit.dart';
import 'package:intheloopapp/ui/widgets/common/loop_container/loop_container.dart';

class AllLoopsList extends StatefulWidget {
  const AllLoopsList({
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;

  @override
  AllLoopsListState createState() => AllLoopsListState();
}

class AllLoopsListState extends State<AllLoopsList>
    with AutomaticKeepAliveClientMixin {
  late ProfileCubit _profileCubit;

  Timer? _debounce;
  ScrollController get _scrollController => widget.scrollController;

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (_isBottom) _profileCubit.fetchMoreLoops();
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _profileCubit = context.read<ProfileCubit>();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Widget loopsList(BuildContext context, ProfileState state) {
    switch (state.loopStatus) {
      case LoopsStatus.initial:
        return const Text('Waiting for New Loops...');

      case LoopsStatus.failure:
        return const Center(child: Text('failed to fetch loops'));

      case LoopsStatus.success:
        if (state.userLoops.isEmpty || state.visitedUser.deleted) {
          return const Text('No loops yet...');
        }

        return CustomScrollView(
          // The "controller" and "primary" members should be left
          // unset, so that the NestedScrollView can control this
          // inner scroll view.
          // If the "controller" property is set, then this scroll
          // view will not be associated with the NestedScrollView.
          // The PageStorageKey should be unique to this ScrollView;
          // it allows the list to remember its scroll position when
          // the tab view is not on the screen.
          key: const PageStorageKey<String>('loops'),
          slivers: [
            SliverOverlapInjector(
              // This is the flip side of the SliverOverlapAbsorber
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverList(
                // itemExtent: 100,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return LoopContainer(
                      loop: state.userLoops[index],
                    );
                  },
                  childCount: state.userLoops.length,
                ),
              ),
            ),
          ],
        );
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: loopsList,
    );
  }
}
