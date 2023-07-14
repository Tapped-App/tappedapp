import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/data/payment_repository.dart';
import 'package:intheloopapp/data/remote_config_repository.dart';
import 'package:intheloopapp/data/stream_repository.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/domains/models/service.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/onboarding_bloc/onboarding_bloc.dart';
import 'package:intheloopapp/ui/create_booking/components/create_booking_form.dart';
import 'package:intheloopapp/ui/create_booking/create_booking_cubit.dart';
import 'package:intheloopapp/ui/error/error_view.dart';
import 'package:intheloopapp/ui/loading/loading_view.dart';
import 'package:intheloopapp/ui/user_tile.dart';
import 'package:skeletons/skeletons.dart';

class CreateBookingView extends StatelessWidget {
  const CreateBookingView({
    required this.service,
    required this.requesteeStripeConnectedAccountId,
    super.key,
  });

  final Service service;
  final String requesteeStripeConnectedAccountId;

  @override
  Widget build(BuildContext context) {
    final database = RepositoryProvider.of<DatabaseRepository>(context);
    final nav = RepositoryProvider.of<NavigationBloc>(context);
    final remote = RepositoryProvider.of<RemoteConfigRepository>(context);

    return BlocSelector<OnboardingBloc, OnboardingState, UserModel?>(
      selector: (state) => (state is Onboarded) ? state.currentUser : null,
      builder: (context, currentUser) {
        if (currentUser == null) {
          return const ErrorView();
        }

        return FutureBuilder<double>(
          future: remote.getBookingFee(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoadingView();
            }

            final bookingFee = snapshot.data!;

            return BlocProvider(
              create: (context) => CreateBookingCubit(
                currentUser: currentUser,
                service: service,
                requesteeStripeConnectedAccountId:
                    requesteeStripeConnectedAccountId,
                bookingFee: bookingFee,
                navigationBloc: context.read<NavigationBloc>(),
                onboardingBloc: context.read<OnboardingBloc>(),
                database: database,
                streamRepo: RepositoryProvider.of<StreamRepository>(context),
                payments: RepositoryProvider.of<PaymentRepository>(context),
              ),
              child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                appBar: AppBar(
                  title: const Row(
                    children: [
                      Text(
                        'Request to Book',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView(
                    children: [
                      FutureBuilder<Option<UserModel>>(
                        future: database.getUserById(service.userId),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SkeletonListTile();
                          }

                          final requestee = snapshot.data;

                          return switch (requestee) {
                            null => SkeletonListTile(),
                            None() => SkeletonListTile(),
                            Some(:final value) => UserTile(
                                userId: value.id,
                                user: Some(value),
                              ),
                          };
                        },
                      ),
                      const CreateBookingForm(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
