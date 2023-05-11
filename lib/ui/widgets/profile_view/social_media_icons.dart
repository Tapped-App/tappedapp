import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intheloopapp/ui/views/profile/profile_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key});

  Widget? _socialMediaIcon(
    bool show, {
    required Icon icon,
    void Function()? onTap,
  }) {
    return show
        ? GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: icon,
            ),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _socialMediaIcon(
                state.visitedUser.twitterHandle != null,
                icon: const Icon(
                  FontAwesomeIcons.twitter,
                ),
                onTap: () {
                  launchUrl(
                    Uri(
                      scheme: 'https',
                      path: 'twitter.com/${state.visitedUser.twitterHandle}',
                    ),
                  );
                },
              ),
              _socialMediaIcon(
                state.visitedUser.instagramHandle != null,
                icon: const Icon(
                  FontAwesomeIcons.instagram,
                ),
                onTap: () {
                  launchUrl(
                    Uri(
                      scheme: 'https',
                      path:
                          'instagram.com/${state.visitedUser.instagramHandle}',
                    ),
                  );
                },
              ),
              _socialMediaIcon(
                state.visitedUser.tiktokHandle != null,
                icon: const Icon(FontAwesomeIcons.tiktok),
                onTap: () {
                  launchUrl(
                    Uri(
                      scheme: 'https',
                      path: 'tiktok.com/@${state.visitedUser.tiktokHandle}',
                    ),
                  );
                },
              ),
              _socialMediaIcon(
                state.visitedUser.youtubeChannelId != null,
                icon: const Icon(FontAwesomeIcons.youtube),
                onTap: () {
                  launchUrl(
                    Uri(
                      scheme: 'https',
                      path:
                          'youtube.com/channel/${state.visitedUser.youtubeChannelId}',
                    ),
                  );
                },
              ),
              _socialMediaIcon(
                state.visitedUser.spotifyId != null,
                icon: const Icon(FontAwesomeIcons.spotify),
                onTap: () {
                  launchUrl(
                    Uri(
                      scheme: 'https',
                      path: 'open.spotify.com/artist/${state.visitedUser.spotifyId}',
                    ),
                  );
                },
              ),
            ].where((element) => element != null).whereType<Widget>().toList(),
          ),
        );
      },
    );
  }
}
