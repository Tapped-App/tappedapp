import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/data/payment_repository.dart';
import 'package:intheloopapp/data/places_repository.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/domains/models/payment_user.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/onboarding_bloc/onboarding_bloc.dart';
import 'package:intheloopapp/utils/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectBankButton extends StatefulWidget {
  const ConnectBankButton({
    super.key,
  });

  @override
  State<ConnectBankButton> createState() => _ConnectBankButtonState();
}

class _ConnectBankButtonState extends State<ConnectBankButton> {
  bool loading = false;

  Widget _connectBankAccountButton({
    required BuildContext context,
    required UserModel currentUser,
    String? accountId,
  }) {
    final payments = context.read<PaymentRepository>();
    final places = context.read<PlacesRepository>();
    final onboarding = context.read<OnboardingBloc>();
    final nav = context.read<NavigationBloc>();
    return FilledButton(
      child: loading
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : const Text(
              'Connect Bank Account',
            ),
      onPressed: () async {
        if (loading) {
          return;
        }

        setState(() {
          loading = true;
        });

        final placeId = currentUser.placeId;
        final place =
            placeId != null ? await places.getPlaceById(placeId) : null;

        final addressComponents = place?.addressComponents ?? [];
        final countryCode = addressComponents
            .where(
              (element) => element.types.contains('country'),
            )
            .firstOrNull
            ?.shortName;

        // create connected account
        final res = await payments.createConnectedAccount(
          accountId: accountId,
          countryCode: countryCode,
        );

        if (!res.success) {
          logger.warning('create connected account failed');
        }

        final updatedUser = currentUser.copyWith(
          stripeConnectedAccountId: res.accountId,
        );

        onboarding.add(
          UpdateOnboardedUser(
            user: updatedUser,
          ),
        );

        nav.pop();

        await launchUrl(
          Uri.parse(res.url),
          mode: LaunchMode.externalApplication,
        );

        setState(() {
          loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final payments = RepositoryProvider.of<PaymentRepository>(context);

    return BlocSelector<OnboardingBloc, OnboardingState, UserModel?>(
      selector: (state) => (state is Onboarded) ? state.currentUser : null,
      builder: (context, currentUser) {
        if (currentUser == null) {
          return const CupertinoButton.filled(
            onPressed: null,
            child: Text('An error has occured :/'),
          );
        }

        if (currentUser.stripeConnectedAccountId == null) {
          return _connectBankAccountButton(
            context: context,
            currentUser: currentUser,
          );
        }

        return FutureBuilder<Option<PaymentUser>>(
          future: payments.getAccountById(
            currentUser.stripeConnectedAccountId!,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final paymentUser = snapshot.data;
            return switch (paymentUser) {
              null => const CircularProgressIndicator(),
              None() => _connectBankAccountButton(
                  context: context,
                  currentUser: currentUser,
                ),
              Some(:final value) => () {
                  if (!value.payoutsEnabled) {
                    return _connectBankAccountButton(
                      context: context,
                      currentUser: currentUser,
                      accountId: value.id,
                    );
                  }

                  return CupertinoButton(
                    onPressed: null,
                    color: Colors.white.withOpacity(0.1),
                    child: const Text('✅ Bank Account Connected'),
                  );
                }(),
            };
          },
        );
      },
    );
  }
}
