import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/domains/models/genre.dart';
import 'package:intheloopapp/ui/discover/components/user_slider.dart';
import 'package:intheloopapp/ui/discover/components/venue_slider.dart';
import 'package:intheloopapp/ui/discover/discover_cubit.dart';
import 'package:intheloopapp/ui/profile/components/feedback_button.dart';
import 'package:intheloopapp/utils/bloc_utils.dart';
import 'package:intheloopapp/utils/current_user_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class DraggableSheet extends StatelessWidget {
  const DraggableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final database = context.database;
    final theme = Theme.of(context);
    return CurrentUserBuilder(
      builder: (context, currentUser) {
        return BlocBuilder<DiscoverCubit, DiscoverState>(
          builder: (context, state) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.1,
              minChildSize: 0.1,
              snap: true,
              snapSizes: const [0.1, 0.5, 1],
              builder: (ctx, scrollController) => DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Column(
                  children: [
                    // DraggableHeader(
                    //   scrollController: scrollController,
                    //   bottomSheetDraggableAreaHeight: 32,
                    // ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 32 / 2 - 4 / 2,
                                  ),
                                  child: Container(
                                    height: 4,
                                    width: 42,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.15),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${state.venueHits.length} ${state.venueHits.length == 1 ? 'venue' : 'venues'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // AspectRatio(
                            //   aspectRatio: 2,
                            //   child: Row(
                            //     children: [
                            //       const SizedBox(height: 512),
                            //       Expanded(
                            //         child: PieChart(
                            //           PieChartData(
                            //             sections: state.genrePieData,
                            //             centerSpaceRadius: 0,
                            //             sectionsSpace: 0,
                            //             startDegreeOffset: 180,
                            //             borderData: FlBorderData(
                            //               show: false,
                            //             ),
                            //             pieTouchData: PieTouchData(
                            //               touchCallback: (pieTouchResponse, _) {},
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            ...state.genreFilters.map((e) {
                              final hits = state.genreList(e);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      e.formattedName.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  VenueSlider(venues: hits),
                                ],
                              );
                            }),
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(
                            //     vertical: 16,
                            //     horizontal: 8,
                            //   ),
                            //   child: Text(
                            //     'Top Bookers',
                            //     style: TextStyle(
                            //       fontSize: 28,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            // FutureBuilder(
                            //   future: database.getBookerLeaders(),
                            //   builder: (context, snapshot) {
                            //     if (!snapshot.hasData) {
                            //       return const Center(
                            //         child: CupertinoActivityIndicator(),
                            //       );
                            //     }
                            //
                            //     final bookerLeaders = snapshot.data ?? [];
                            //     return UserSlider(users: bookerLeaders);
                            //   },
                            // ),
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(
                            //     vertical: 16,
                            //     horizontal: 8,
                            //   ),
                            //   child: Text(
                            //     'Top DC Venues',
                            //     style: TextStyle(
                            //       fontSize: 28,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            // FutureBuilder(
                            //   future: database.getDCVenues(),
                            //   builder: (context, snapshot) {
                            //     if (!snapshot.hasData) {
                            //       return const Center(
                            //         child: CupertinoActivityIndicator(),
                            //       );
                            //     }
                            //
                            //     final dcVenues = snapshot.data ?? [];
                            //     return VenueSlider(venues: dcVenues);
                            //   },
                            // ),
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(
                            //     vertical: 16,
                            //     horizontal: 8,
                            //   ),
                            //   child: Text(
                            //     'Top NoVa Venues',
                            //     style: TextStyle(
                            //       fontSize: 28,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            // FutureBuilder(
                            //   future: database.getNovaVenues(),
                            //   builder: (context, snapshot) {
                            //     if (!snapshot.hasData) {
                            //       return const Center(
                            //         child: CupertinoActivityIndicator(),
                            //       );
                            //     }
                            //
                            //     final novaVenues = snapshot.data ?? [];
                            //     return VenueSlider(venues: novaVenues);
                            //   },
                            // ),
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(
                            //     vertical: 16,
                            //     horizontal: 8,
                            //   ),
                            //   child: Text(
                            //     'Top Maryland Venues',
                            //     style: TextStyle(
                            //       fontSize: 28,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            // FutureBuilder(
                            //   future: database.getMarylandVenues(),
                            //   builder: (context, snapshot) {
                            //     if (!snapshot.hasData) {
                            //       return const Center(
                            //         child: CupertinoActivityIndicator(),
                            //       );
                            //     }
                            //
                            //     final marylandVenues = snapshot.data ?? [];
                            //     return VenueSlider(venues: marylandVenues);
                            //   },
                            // ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 8,
                              ),
                              child: Text(
                                'Top Performers',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FutureBuilder(
                              future: database.getBookingLeaders(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                                }

                                final bookingLeaders = snapshot.data ?? [];
                                return UserSlider(users: bookingLeaders);
                              },
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: FeedbackButton(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CupertinoButton(
                                          onPressed: () {
                                            final uri = Uri.parse('https://tappedapp.notion.site/join-tapped-9ccf655358344b21979f73adadf22d98?pvs=4');
                                            launchUrl(uri);
                                          },
                                          color: theme.colorScheme.onSurface.withOpacity(0.1),
                                          padding: const EdgeInsets.all(12),
                                          child: const Text(
                                            'want a job?',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
