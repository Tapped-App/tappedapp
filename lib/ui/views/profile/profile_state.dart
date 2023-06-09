part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  ProfileState({
    required this.currentUser,
    required this.visitedUser,
    this.isFollowing = false,
    this.isBlocked = false,
    this.isVerified = false,
    this.userLoops = const [],
    this.latestLoop = const None(),
    this.latestOpportunity = const None(),
    this.latestBooking = const None(),
    this.userBadges = const [],
    this.userBookings = const [],
    this.hasReachedMaxLoops = false,
    this.hasReachedMaxBadges = false,
    this.hasReachedMaxBookings = false,
    this.hasReachedMaxUserCreatedBadges = false,
    this.loopStatus = LoopsStatus.initial,
    this.badgeStatus = BadgesStatus.initial,
    this.bookingsStatus = BookingsStatus.initial,
    int? followerCount,
    int? followingCount,
    Place? place,
  }) {
    this.followerCount = followerCount ?? visitedUser.followerCount;
    this.followingCount = followingCount ?? visitedUser.followingCount;
    this.place = place ?? const Place();
  }

  late final int followerCount;
  late final int followingCount;
  final bool isFollowing;
  final bool isBlocked;
  final bool isVerified;
  final List<Loop> userLoops;
  final List<Badge> userBadges;
  final List<Booking> userBookings;

  final Option<Loop> latestLoop;
  final Option<Loop> latestOpportunity;
  final Option<Booking> latestBooking;

  final bool hasReachedMaxLoops;
  final bool hasReachedMaxBadges;
  final bool hasReachedMaxBookings;
  final bool hasReachedMaxUserCreatedBadges;
  final LoopsStatus loopStatus;
  final BadgesStatus badgeStatus;
  final BookingsStatus bookingsStatus;
  final UserModel visitedUser;
  final UserModel currentUser;
  late final Place place;

  List<Loop> get userOpportunities =>
      userLoops.where((loop) => loop.isOpportunity).toList();

  @override
  List<Object> get props => [
        followingCount,
        followerCount,
        isFollowing,
        isBlocked,
        isVerified,
        userLoops,
        latestLoop,
        latestOpportunity,
        latestBooking,
        userBadges,
        userBookings,
        hasReachedMaxLoops,
        hasReachedMaxBadges,
        hasReachedMaxBookings,
        hasReachedMaxUserCreatedBadges,
        loopStatus,
        badgeStatus,
        bookingsStatus,
        visitedUser,
        currentUser,
        place,
      ];

  ProfileState copyWith({
    int? followerCount,
    int? followingCount,
    bool? isFollowing,
    bool? isBlocked,
    bool? isVerified,
    Option<Loop>? latestLoop,
    Option<Loop>? latestOpportunity,
    Option<Booking>? latestBooking,
    List<Loop>? userLoops,
    List<Badge>? userBadges,
    List<Booking>? userBookings,
    bool? hasReachedMaxLoops,
    bool? hasReachedMaxBadges,
    bool? hasReachedMaxBookings,
    bool? hasReachedMaxUserCreatedBadges,
    LoopsStatus? loopStatus,
    BadgesStatus? badgeStatus,
    BookingsStatus? bookingsStatus,
    UserModel? currentUser,
    UserModel? visitedUser,
    Place? place,
  }) {
    return ProfileState(
      followingCount: followingCount ?? this.followingCount,
      followerCount: followerCount ?? this.followerCount,
      isFollowing: isFollowing ?? this.isFollowing,
      isBlocked: isBlocked ?? this.isBlocked,
      isVerified: isVerified ?? this.isVerified,
      latestLoop: latestLoop ?? this.latestLoop,
      latestOpportunity: latestOpportunity ?? this.latestOpportunity,
      latestBooking: latestBooking ?? this.latestBooking,
      userLoops: userLoops ?? this.userLoops,
      userBadges: userBadges ?? this.userBadges,
      userBookings: userBookings ?? this.userBookings,
      hasReachedMaxLoops: hasReachedMaxLoops ?? this.hasReachedMaxLoops,
      hasReachedMaxBadges: hasReachedMaxBadges ?? this.hasReachedMaxBadges,
      hasReachedMaxBookings:
          hasReachedMaxBookings ?? this.hasReachedMaxBookings,
      hasReachedMaxUserCreatedBadges:
          hasReachedMaxUserCreatedBadges ?? this.hasReachedMaxUserCreatedBadges,
      loopStatus: loopStatus ?? this.loopStatus,
      badgeStatus: badgeStatus ?? this.badgeStatus,
      bookingsStatus: bookingsStatus ?? this.bookingsStatus,
      currentUser: currentUser ?? this.currentUser,
      visitedUser: visitedUser ?? this.visitedUser,
      place: place ?? this.place,
    );
  }
}

enum LoopsStatus {
  initial,
  success,
  failure,
}

enum BadgesStatus {
  initial,
  success,
  failure,
}

enum BookingsStatus {
  initial,
  success,
  failure,
}
