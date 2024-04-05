import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intheloopapp/domains/models/booking.dart';
import 'package:intheloopapp/ui/booking/booking_view.dart';
import 'package:intheloopapp/ui/discover/discover_cubit.dart';
import 'package:intheloopapp/utils/hero_image.dart';
import 'package:latlong2/latlong.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BookingsMarkerLayer extends StatelessWidget {
  const BookingsMarkerLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverCubit, DiscoverState>(
      builder: (context, state) {
        return MarkerLayer(
          markers: [
            ...state.userBookings.map((booking) {
              final heroImage = HeroImage(
                imageProvider: booking.getBookingImage(const None()),
                heroTag: booking.id,
              );
              return switch (booking.location) {
                None() => null,
                Some(:final value) => Marker(
                    width: 35,
                    height: 35,
                    point: LatLng(value.lat, value.lng),
                    child: InkWell(
                      onTap: () => showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) => BookingView(
                          booking: booking,
                          flierImage: Option.of(heroImage),
                        ),
                      ),
                      child: Hero(
                        tag: heroImage.heroTag,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: heroImage.imageProvider,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              };
            }).whereType<Marker>(),
          ],
        );
      },
    );
  }
}
