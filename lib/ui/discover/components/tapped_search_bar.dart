import 'package:cached_annotation/cached_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/data/search_repository.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/navigation_bloc/tapped_route.dart';
import 'package:intheloopapp/domains/search_bloc/search_bloc.dart';
import 'package:intheloopapp/ui/loading/logo_wave.dart';
import 'package:intheloopapp/ui/profile/components/opportunity_card.dart';
import 'package:intheloopapp/ui/user_card.dart';
import 'package:intheloopapp/ui/user_tile.dart';
import 'package:intheloopapp/utils/bloc_utils.dart';
import 'package:intheloopapp/utils/custom_claims_builder.dart';

class TappedSearchBar extends StatefulWidget {
  const TappedSearchBar({
    this.focusNode,
    this.controller,
    this.onChanged,
    this.onTap,
    this.trailing,
    super.key,
  });

  final FocusNode? focusNode;
  final SearchController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final List<Widget>? trailing;

  @override
  State<TappedSearchBar> createState() => _TappedSearchBarState();
}

class _TappedSearchBarState extends State<TappedSearchBar> {
  late final FocusNode _searchFocusNode;
  late final SearchController _searchController;
  late final ScrollController _scrollController = ScrollController();
  var _loadingSuggestions = true;

  void _search() {
    final query = _searchController.text;
    context.search.add(Search(query: query));
    widget.onChanged?.call(query);
  }

  @cached
  FutureOr<Iterable<Widget>> _getSuggestions({
    required DatabaseRepository database,
    required SearchRepository searchRepo,
  }) async {
    final [suggestedUsers, venuesNearby] = await Future.wait([
      database.getBookingLeaders(),
      searchRepo.queryUsers(
        '',
        occupations: ['Venue', 'venue'],
      ),
    ]);

    final featuredOps = await database.getFeaturedOpportunities();
    final sortedOps = featuredOps
      ..sort(
        (a, b) => a.startTime.compareTo(b.startTime),
      );

    final combined = [...suggestedUsers, ...venuesNearby]..sort(
        (a, b) => a.displayName.compareTo(b.displayName),
      );
    final combinedWidgets = combined.map(
      (user) => UserTile(
        userId: user.id,
        user: Option.of(user),
      ),
    );

    final featuredWidgets = sortedOps.map(
      (op) => OpportunityCard(opportunity: op),
    );

    return [...featuredWidgets, ...combinedWidgets];
  }

  @override
  void initState() {
    super.initState();
    _searchController = widget.controller ?? SearchController();
    _searchFocusNode = widget.focusNode ?? FocusNode();

    _searchController.addListener(_search);
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocusNode.removeListener(_search);
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final database = context.read<DatabaseRepository>();
    final searchRepo = context.read<SearchRepository>();
    return SearchAnchor(
      searchController: _searchController,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.search,
      viewBackgroundColor: theme.colorScheme.background,
      viewElevation: 0,
      builder: (context, searchController) {
        return Hero(
          tag: 'searchBar',
          child: SearchBar(
            // elevation: const MaterialStatePropertyAll(0),
            backgroundColor: MaterialStatePropertyAll(
              theme.colorScheme.background,
            ),
            elevation: const MaterialStatePropertyAll(0),
            controller: searchController,
            focusNode: _searchFocusNode,
            hintText: 'search tapped...',
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            trailing: widget.trailing ??
                [
                  CustomClaimsBuilder(
                    builder: (context, claims) {
                      final hasClaim = claims.isNotEmpty;
                      return IconButton(
                        onPressed: () {
                          return switch (hasClaim) {
                            true => context.push(
                                AdvancedSearchPage(),
                              ),
                            false => context.push(
                                PaywallPage(),
                              ),
                          };
                        },
                        icon: const Icon(CupertinoIcons.doc_text_search),
                        color: theme.colorScheme.onSurface,
                      );
                    },
                  ),
                ],
            onChanged: (_) {
              if (searchController.isOpen) {
                return;
              }
              searchController.openView();
            },
            onTap: () {
              searchController.openView();
              widget.onTap?.call();
            },
          ),
        );
      },
      viewBuilder: (suggestions) {
        return BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (_loadingSuggestions || state.loading) {
              return const Center(
                child: LogoWave(),
              );
            }

            if (suggestions.isNotEmpty && state.searchTerm.isEmpty) {
              final sugList = suggestions.toList();
              final ops = sugList.whereType<OpportunityCard>().toList();
              final restUsers = sugList.whereType<UserTile>();

              return ListView(
                controller: _scrollController,
                children: [
                  if (ops.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            'apply to perform',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ops.length,
                            itemBuilder: (context, index) {
                              final opWidget = ops[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: opWidget,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  if (restUsers.isNotEmpty)
                    const Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        'suggestions',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ...restUsers,
                ],
              );
            }

            return state.searchResults.isEmpty
                ? const Center(child: Text('No users found'))
                : ListView.builder(
                    itemCount: state.searchResults.length,
                    itemBuilder: (context, index) {
                      final user = state.searchResults[index];
                      return UserTile(
                        userId: user.id,
                        user: Option.of(user),
                      );
                    },
                  );
          },
        );
      },
      suggestionsBuilder: (context, searchController) async {
        if (searchController.text.isNotEmpty) {
          return const [];
        }

        final suggestions = await _getSuggestions(
          database: database,
          searchRepo: searchRepo,
        );

        setState(() {
          _loadingSuggestions = false;
        });

        return suggestions;
      },
    );
  }
}
