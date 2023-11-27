import 'package:intheloopapp/domains/models/activity.dart';
import 'package:intheloopapp/domains/models/ai_model.dart';
import 'package:intheloopapp/domains/models/avatar.dart';
import 'package:intheloopapp/domains/models/badge.dart';
import 'package:intheloopapp/domains/models/booking.dart';
import 'package:intheloopapp/domains/models/comment.dart';
import 'package:intheloopapp/domains/models/loop.dart';
import 'package:intheloopapp/domains/models/marketing_plan.dart';
import 'package:intheloopapp/domains/models/opportunity.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/domains/models/review.dart';
import 'package:intheloopapp/domains/models/service.dart';
// import 'package:intheloopapp/domains/models/tag.dart';
import 'package:intheloopapp/domains/models/user_model.dart';

abstract class DatabaseRepository {
  // User related stuff
  Future<bool> userEmailExists(String email);
  Future<void> createUser(UserModel user);
  Future<Option<UserModel>> getUserByUsername(String? username);
  Future<Option<UserModel>> getUserById(
    String userId, {
    bool ignoreCache = false,
  });
  Future<List<UserModel>> searchUsersByLocation({
    required double lat,
    required double lng,
    int radiusInMeters = 50 * 1000, // 50km
    int limit = 100,
    String? lastUserId,
  });
  Future<void> updateUserData(UserModel user);
  Future<bool> checkUsernameAvailability(String username, String userid);

  Future<List<UserModel>> getRichmondVenues();
  Future<List<UserModel>> getBookingLeaders();
  Future<List<UserModel>> getBookerLeaders();

  // Liking related stuff
  Future<void> addLike(
    String currentUserId,
    String loopId,
  );
  Future<void> deleteLike(
    String currentUserId,
    String loopId,
  );
  Future<bool> isLiked(
    String currentUserId,
    String loopId,
  );
  Future<List<UserModel>> getLikes(
    String loopId,
  );

  // Commenting related stuff
  Future<List<Comment>> getComments(
    String rootId, {
    int limit = 100,
  });
  Stream<Comment> commentsObserver(
    String rootId, {
    int limit = 100,
  });
  Future<Comment> getComment(
    String rootId,
    String commentId,
  );
  Future<void> addComment(
    Comment comment,
  );
  Future<void> likeComment(
    String currentUserId,
    Comment comment,
  );
  Future<void> unlikeComment(
    String currentUserId,
    Comment comment,
  );
  Future<bool> isCommentLiked(
    String currentUserId,
    Comment comment,
  );

  // Following related stuff
  Future<int> followersNum(String userid);
  Future<int> followingNum(String userid);
  Future<void> followUser(
    String currentUserId,
    String visitedUserId,
  );
  Future<void> unfollowUser(
    String currentUserId,
    String visitedUserId,
  );
  Future<bool> isFollowingUser(
    String currentUserId,
    String visitedUserId,
  );
  Future<List<UserModel>> getFollowing(String currentUserId);
  Future<List<UserModel>> getFollowers(String currentUserId);
  Future<List<UserModel>> getCommonFollowers(
      String currentUserID, String observedUserId,);

  // Activity related stuff
  Future<List<Activity>> getActivities(
    String userId, {
    int limit = 100,
    String? lastActivityId,
  });
  Stream<Activity> activitiesObserver(
    String userId, {
    int limit = 100,
  });
  Future<void> addActivity({
    required String currentUserId,
    required String visitedUserId,
    required ActivityType type,
    Loop? loop,
  });
  Future<void> markActivityAsRead(Activity activity);

  // Badge related stuff
  Future<bool> isVerified(String userId);
  Future<void> createBadge(Badge badge);
  Future<void> sendBadge(String badgeId, String receiverId);
  Stream<Badge> userCreatedBadgesObserver(
    String userId, {
    int limit = 100,
  });
  Future<List<Badge>> getUserCreatedBadges(
    String userId, {
    int limit = 100,
    String? lastBadgeId,
  });
  Stream<Badge> userBadgesObserver(
    String userId, {
    int limit = 100,
  });
  Future<List<Badge>> getUserBadges(
    String userId, {
    int limit = 100,
    String? lastBadgeId,
  });

  // Booking related stuff
  Future<void> createBooking(
    Booking booking,
  );
  Future<Option<Booking>> getBookingById(
    String bookRequestId,
  );
  Future<List<Booking>> getBookingsByRequesterRequestee(
    String requesterId,
    String requesteeId, {
    int limit = 20,
    String? lastBookingRequestId,
  });
  Future<List<Booking>> getBookingsByRequester(
    String userId, {
    int limit = 20,
    String? lastBookingRequestId,
  });
  Stream<Booking> getBookingsByRequesterObserver(
    String userId, {
    int limit = 20,
  });
  Future<List<Booking>> getBookingsByRequestee(
    String userId, {
    int limit = 20,
    String? lastBookingRequestId,
  });
  Stream<Booking> getBookingsByRequesteeObserver(
    String userId, {
    int limit = 20,
  });
  Future<void> updateBooking(Booking booking);

  // Service related stuff
  Future<void> createService(Service service);
  Future<void> updateService(Service service);
  Future<Option<Service>> getServiceById(String userId, String serviceId);
  Future<List<Service>> getUserServices(String userId);
  Future<void> deleteService(String userId, String serviceId);

  // Opportunity related stuff
  Future<List<Opportunity>> getUserOpportunities(String userId);
  Future<void> applyForOpportunity({
    required Opportunity opportunity,
    required String userId,
  });
  Future<bool> isUserAppliedForOpportunity({
    required Opportunity opportunity,
    required String userId,
  });
  Future<List<UserModel>> getInterestedUsers(Opportunity opportunity);

  // blocking
  Future<void> blockUser({
    required String currentUserId,
    required String blockedUserId,
  });
  Future<void> unblockUser({
    required String currentUserId,
    required String blockedUserId,
  });
  Future<bool> isBlocked({
    required String currentUserId,
    required String blockedUserId,
  });
  Future<void> reportUser({
    required UserModel reported,
    required UserModel reporter,
  });

  // Performer Review related stuff
  Future<void> createPerformerReview(
    PerformerReview review,
  );
  Future<Option<PerformerReview>> getPerformerReviewById({
    required String revieweeId,
    required String reviewId,
  });
  Future<List<PerformerReview>> getPerformerReviewsByPerformerId(
    String performerId, {
    int limit = 20,
    String? lastReviewId,
  });
  Stream<PerformerReview> getPerformerReviewsByPerformerIdObserver(
    String performerId, {
    int limit = 20,
  });

  // Booker Review related stuff
  Future<void> createBookerReview(
    BookerReview review,
  );
  Future<Option<BookerReview>> getBookerReviewById({
    required String revieweeId,
    required String reviewId,
  });
  Future<List<BookerReview>> getBookerReviewsByBookerId(
    String bookerId, {
    int limit = 20,
    String? lastReviewId,
  });
  Stream<BookerReview> getBookerReviewsByBookerIdObserver(
    String bookerId, {
    int limit = 20,
  });

  Future<Option<AiImageModel>> getUserImageModel(String userId);
  Future<List<Avatar>> getUserAvatars(String userId);
  Stream<Avatar> userAvatarsObserver(String userId);
  Future<void> createAvatar(Avatar avatar);
  Future<void> deleteAvatar({
    required String userId,
    required String avatarId,
  });
  Future<List<MarketingPlan>> getUserMarketingPlans(String userId);
  Stream<MarketingPlan> userMarketingPlansObserver(String userId);
}
