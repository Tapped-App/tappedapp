import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/domains/models/activity.dart';
import 'package:intheloopapp/domains/models/badge.dart' as badge;
import 'package:intheloopapp/domains/models/booking.dart';
import 'package:intheloopapp/domains/models/comment.dart';
import 'package:intheloopapp/domains/models/loop.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/domains/models/service.dart';
import 'package:intheloopapp/domains/models/user_model.dart';

class LocalDatabaseImpl extends DatabaseRepository {
  @override
  Future<bool> userEmailExists(String email) async {
    return true;
  }

  @override
  Future<Option<UserModel>> getUserByUsername(String? username) async {
    return const None();
  }

  @override
  Future<void> createUser(UserModel user) async {
    return;
  }

  @override
  Future<Option<UserModel>> getUserById(
    String userId, {
    bool ignoreCache = false,
  }) async {
    return const None();
  }

  @override
  Future<List<UserModel>> getViewLeaders() async {
    return [];
  }

  @override
  Future<List<UserModel>> getBookingLeaders() async {
    return [];
  }

  @override
  Future<Option<Loop>> getLoopById(
    String loopId, {
    bool ignoreCache = false,
  }) async {
    return const None();
  }

  @override
  Future<int> followersNum(String userid) async {
    return 42;
  }

  @override
  Future<int> followingNum(String userid) async {
    return 42;
  }

  @override
  Future<void> updateUserData(UserModel user) async {
    return;
  }

  @override
  Future<void> followUser(
    String currentUserId,
    String visitedUserId,
  ) async {
    return;
  }

  @override
  Future<void> unfollowUser(
    String currentUserId,
    String visitedUserId,
  ) async {
    return;
  }

  @override
  Future<bool> isFollowingUser(
    String currentUserId,
    String visitedUserId,
  ) async {
    return false;
  }

  @override
  Future<List<UserModel>> getFollowing(String currentUserId) async {
    return [];
  }

  @override
  Future<List<UserModel>> getFollowers(String currentUserId) async {
    return [];
  }

  @override
  Future<void> addLoop(Loop loop) async {
    return;
  }

  @override
  Future<void> deleteLoop(Loop loop) async {
    return;
  }

  @override
  Future<List<Loop>> getUserLoops(
    String userId, {
    int limit = 0,
    String? lastLoopId,
  }) async {
    return [];
  }

  @override
  Stream<Loop> userLoopsObserver(String userId, {int limit = 20}) async* {}

  @override
  Future<List<Loop>> getFollowingLoops(
    String currentUserId, {
    int limit = 0,
    String? lastLoopId,
    bool ignoreCache = false,
  }) async {
    return [];
  }

  @override
  Stream<Loop> followingLoopsObserver(
    String currentUserId, {
    int limit = 20,
    bool ignoreCache = false,
  }) async* {}

  @override
  Future<List<Loop>> getAllLoops(
    String currentUserId, {
    int limit = 0,
    String? lastLoopId,
    bool ignoreCache = false,
  }) async {
    return [];
  }

  @override
  Stream<Loop> allLoopsObserver(
    String currentUserId, {
    int limit = 20,
    bool ignoreCache = false,
  }) async* {}

  @override
  Future<void> addLike(
    String currentUserId,
    String loopId,
  ) async {
    return;
  }

  @override
  Future<void> deleteLike(
    String currentUserId,
    String loopId,
  ) async {
    return;
  }

  @override
  Future<bool> isLiked(
    String currentUserId,
    String loopId,
  ) async {
    return false;
  }

  @override
  Future<List<UserModel>> getLikes(
    String loopId,
  ) async {
    return [];
  }

  @override
  Future<List<Activity>> getActivities(
    String userId, {
    int limit = 0,
    String? lastActivityId,
  }) async {
    return [];
  }

  @override
  Stream<Activity> activitiesObserver(
    String userId, {
    int limit = 20,
  }) async* {}

  @override
  Future<void> addActivity({
    required String currentUserId,
    required ActivityType type,
    Loop? loop,
    String? visitedUserId,
  }) async {
    return;
  }

  @override
  Future<void> markActivityAsRead(Activity activity) async {
    return;
  }

  @override
  Future<List<Comment>> getComments(
    String rootId, {
    int limit = 20,
  }) async {
    return [];
  }

  @override
  Stream<Comment> commentsObserver(
    String rootId, {
    int limit = 20,
  }) async* {}

  @override
  Future<Comment> getComment(
    String rootId,
    String commentId,
  ) async {
    return Comment(
      id: '',
      rootId: '',
      userId: '',
      content: '',
    );
  }

  @override
  Future<void> addComment(
    Comment comment,
  ) async {
    return;
  }

  @override
  Future<void> likeComment(
    String currentUserId,
    Comment comment,
  ) async {
    return;
  }

  @override
  Future<void> unlikeComment(
    String currentUserId,
    Comment comment,
  ) async {
    return;
  }

  @override
  Future<bool> isCommentLiked(
    String currentUserId,
    Comment comment,
  ) async {
    return false;
  }

  // Future<List<Tag>> getTagSuggestions(String query) async {
  //   await Future<void>.delayed(Duration(seconds: 2));
  //   return [];
  // }

  @override
  Future<void> shareLoop(Loop loop) async {
    return;
  }

  @override
  Future<void> reportLoop({
    required String reporterId,
    required Loop loop,
  }) async {
    return;
  }

  @override
  Future<bool> checkUsernameAvailability(String username, String userid) async {
    return true;
  }

  @override
  Future<bool> isVerified(String userId) async {
    return false;
  }

  @override
  Future<void> createBadge(badge.Badge badge) async {
    return;
  }

  @override
  Future<void> sendBadge(String badgeId, String receiverId) async {
    return;
  }

  @override
  Stream<badge.Badge> userBadgesObserver(
    String userId, {
    int limit = 20,
  }) async* {}

  @override
  Stream<badge.Badge> userCreatedBadgesObserver(
    String userId, {
    int limit = 20,
  }) async* {}

  @override
  Future<List<badge.Badge>> getUserBadges(
    String userId, {
    String? lastBadgeId,
    int limit = 20,
  }) async {
    return [];
  }

  @override
  Future<List<badge.Badge>> getUserCreatedBadges(
    String userId, {
    String? lastBadgeId,
    int limit = 20,
  }) async {
    return [];
  }

  // booking related stuff
  @override
  Future<void> createBooking(
    Booking booking,
  ) {
    return Future(() => null);
  }

  @override
  Future<Option<Booking>> getBookingById(
    String bookRequestId,
  ) {
    return Future(() => const None());
  }

  @override
  Future<List<Booking>> getBookingsByRequesterRequestee(
    String requesterId,
    String requesteeId, {
    int limit = 20,
    String? lastBookingRequestId,
  }) {
    return Future(() => []);
  }

  @override
  Future<List<Booking>> getBookingsByRequester(
    String userId, {
    int limit = 20,
    String? lastBookingRequestId,
  }) {
    return Future(() => []);
  }

  @override
  Stream<Booking> getBookingsByRequesterObserver(
    String userId, {
    int limit = 20,
  }) async* {}

  @override
  Future<List<Booking>> getBookingsByRequestee(
    String userId, {
    int limit = 20,
    String? lastBookingRequestId,
  }) {
    return Future(() => []);
  }

  @override
  Stream<Booking> getBookingsByRequesteeObserver(
    String userId, {
    int limit = 20,
  }) async* {}

  @override
  Future<void> updateBooking(Booking booking) {
    return Future(() => []);
  }

  @override
  Future<List<UserModel>> searchUsersByLocation({
    required double lat,
    required double lng,
    int radiusInMeters = 50 * 1000,
    int limit = 20,
    String? lastUserId,
  }) async {
    return [];
  }

  @override
  Future<void> createService(Service service) async {
    return;
  }

  @override
  Future<void> deleteService(String userId, String serviceId) async {
    return;
  }

  @override
  Future<Option<Service>> getServiceById(
    String userId,
    String serviceId,
  ) async {
    return const None();
  }

  @override
  Future<List<Service>> getUserServices(String userId) async {
    return [];
  }

  @override
  Future<void> updateService(Service service) async {
    return;
  }

  @override
  Future<void> showInterest({
    required String userId,
    required String loopId,
  }) async {
    return;
  }

  @override
  Future<void> cancelInterest({
    required String userId,
    required String loopId,
  }) async {
    return;
  }

  @override
  Future<List<UserModel>> getInterestedUsers(
    String loopId,
  ) async {
    return [];
  }

  @override
  Future<bool> isInterested({
    required String userId,
    required String loopId,
  }) async {
    return false;
  }

  @override
  Future<List<Loop>> getUserOpportunities(
    String userId, {
    int limit = 20,
    String? lastLoopId,
  }) async {
    return [];
  }

  @override
  Stream<Loop> userOpportunitiesObserver(
    String userId, {
    int limit = 100,
  }) async* {}
}
