// Mocks generated by Mockito 5.4.0 from annotations
// in intheloopapp/test/ui/likes_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:intheloopapp/data/database_repository.dart' as _i3;
import 'package:intheloopapp/domains/models/activity.dart' as _i7;
import 'package:intheloopapp/domains/models/badge.dart' as _i8;
import 'package:intheloopapp/domains/models/booking.dart' as _i9;
import 'package:intheloopapp/domains/models/comment.dart' as _i2;
import 'package:intheloopapp/domains/models/loop.dart' as _i6;
import 'package:intheloopapp/domains/models/service.dart' as _i10;
import 'package:intheloopapp/domains/models/user_model.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeComment_0 extends _i1.SmartFake implements _i2.Comment {
  _FakeComment_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DatabaseRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseRepository extends _i1.Mock
    implements _i3.DatabaseRepository {
  MockDatabaseRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> userEmailExists(String? email) => (super.noSuchMethod(
        Invocation.method(
          #userEmailExists,
          [email],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<void> createUser(_i5.UserModel? user) => (super.noSuchMethod(
        Invocation.method(
          #createUser,
          [user],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i5.UserModel?> getUserByUsername(String? username) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserByUsername,
          [username],
        ),
        returnValue: _i4.Future<_i5.UserModel?>.value(),
      ) as _i4.Future<_i5.UserModel?>);
  @override
  _i4.Future<_i5.UserModel?> getUserById(
    String? userId, {
    bool? ignoreCache = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserById,
          [userId],
          {#ignoreCache: ignoreCache},
        ),
        returnValue: _i4.Future<_i5.UserModel?>.value(),
      ) as _i4.Future<_i5.UserModel?>);
  @override
  _i4.Future<List<_i5.UserModel>> searchUsersByLocation({
    required double? lat,
    required double? lng,
    int? radiusInMeters = 50000,
    int? limit = 100,
    String? lastUserId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchUsersByLocation,
          [],
          {
            #lat: lat,
            #lng: lng,
            #radiusInMeters: radiusInMeters,
            #limit: limit,
            #lastUserId: lastUserId,
          },
        ),
        returnValue: _i4.Future<List<_i5.UserModel>>.value(<_i5.UserModel>[]),
      ) as _i4.Future<List<_i5.UserModel>>);
  @override
  _i4.Future<void> updateUserData(_i5.UserModel? user) => (super.noSuchMethod(
        Invocation.method(
          #updateUserData,
          [user],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<bool> checkUsernameAvailability(
    String? username,
    String? userid,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkUsernameAvailability,
          [
            username,
            userid,
          ],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<List<_i5.UserModel>> getViewLeaders() => (super.noSuchMethod(
        Invocation.method(
          #getViewLeaders,
          [],
        ),
        returnValue: _i4.Future<List<_i5.UserModel>>.value(<_i5.UserModel>[]),
      ) as _i4.Future<List<_i5.UserModel>>);
  @override
  _i4.Future<List<_i5.UserModel>> getBookingLeaders() => (super.noSuchMethod(
        Invocation.method(
          #getBookingLeaders,
          [],
        ),
        returnValue: _i4.Future<List<_i5.UserModel>>.value(<_i5.UserModel>[]),
      ) as _i4.Future<List<_i5.UserModel>>);
  @override
  _i4.Future<_i6.Loop?> getLoopById(
    String? loopId, {
    bool? ignoreCache = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLoopById,
          [loopId],
          {#ignoreCache: ignoreCache},
        ),
        returnValue: _i4.Future<_i6.Loop?>.value(),
      ) as _i4.Future<_i6.Loop?>);
  @override
  _i4.Future<void> addLoop(_i6.Loop? loop) => (super.noSuchMethod(
        Invocation.method(
          #addLoop,
          [loop],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteLoop(_i6.Loop? loop) => (super.noSuchMethod(
        Invocation.method(
          #deleteLoop,
          [loop],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<List<_i6.Loop>> getUserLoops(
    String? userId, {
    int? limit = 100,
    String? lastLoopId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserLoops,
          [userId],
          {
            #limit: limit,
            #lastLoopId: lastLoopId,
          },
        ),
        returnValue: _i4.Future<List<_i6.Loop>>.value(<_i6.Loop>[]),
      ) as _i4.Future<List<_i6.Loop>>);
  @override
  _i4.Stream<_i6.Loop> userLoopsObserver(
    String? userId, {
    int? limit = 100,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #userLoopsObserver,
          [userId],
          {#limit: limit},
        ),
        returnValue: _i4.Stream<_i6.Loop>.empty(),
      ) as _i4.Stream<_i6.Loop>);
  @override
  _i4.Future<List<_i6.Loop>> getFollowingLoops(
    String? currentUserId, {
    int? limit = 100,
    String? lastLoopId,
    bool? ignoreCache = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFollowingLoops,
          [currentUserId],
          {
            #limit: limit,
            #lastLoopId: lastLoopId,
            #ignoreCache: ignoreCache,
          },
        ),
        returnValue: _i4.Future<List<_i6.Loop>>.value(<_i6.Loop>[]),
      ) as _i4.Future<List<_i6.Loop>>);
  @override
  _i4.Stream<_i6.Loop> followingLoopsObserver(
    String? currentUserId, {
    int? limit = 100,
    bool? ignoreCache = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #followingLoopsObserver,
          [currentUserId],
          {
            #limit: limit,
            #ignoreCache: ignoreCache,
          },
        ),
        returnValue: _i4.Stream<_i6.Loop>.empty(),
      ) as _i4.Stream<_i6.Loop>);
  @override
  _i4.Future<List<_i6.Loop>> getAllLoops(
    String? currentUserId, {
    int? limit = 100,
    String? lastLoopId,
    bool? ignoreCache = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllLoops,
          [currentUserId],
          {
            #limit: limit,
            #lastLoopId: lastLoopId,
            #ignoreCache: ignoreCache,
          },
        ),
        returnValue: _i4.Future<List<_i6.Loop>>.value(<_i6.Loop>[]),
      ) as _i4.Future<List<_i6.Loop>>);
  @override
  _i4.Stream<_i6.Loop> allLoopsObserver(
    String? currentUserId, {
    int? limit = 100,
    bool? ignoreCache = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #allLoopsObserver,
          [currentUserId],
          {
            #limit: limit,
            #ignoreCache: ignoreCache,
          },
        ),
        returnValue: _i4.Stream<_i6.Loop>.empty(),
      ) as _i4.Stream<_i6.Loop>);
  @override
  _i4.Future<void> addLike(
    String? currentUserId,
    String? loopId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addLike,
          [
            currentUserId,
            loopId,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteLike(
    String? currentUserId,
    String? loopId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteLike,
          [
            currentUserId,
            loopId,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<bool> isLiked(
    String? currentUserId,
    String? loopId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #isLiked,
          [
            currentUserId,
            loopId,
          ],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<List<_i5.UserModel>> getLikes(String? loopId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLikes,
          [loopId],
        ),
        returnValue: _i4.Future<List<_i5.UserModel>>.value(<_i5.UserModel>[]),
      ) as _i4.Future<List<_i5.UserModel>>);
  @override
  _i4.Future<List<_i2.Comment>> getComments(
    String? rootId, {
    int? limit = 100,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getComments,
          [rootId],
          {#limit: limit},
        ),
        returnValue: _i4.Future<List<_i2.Comment>>.value(<_i2.Comment>[]),
      ) as _i4.Future<List<_i2.Comment>>);
  @override
  _i4.Stream<_i2.Comment> commentsObserver(
    String? rootId, {
    int? limit = 100,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #commentsObserver,
          [rootId],
          {#limit: limit},
        ),
        returnValue: _i4.Stream<_i2.Comment>.empty(),
      ) as _i4.Stream<_i2.Comment>);
  @override
  _i4.Future<_i2.Comment> getComment(
    String? rootId,
    String? commentId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getComment,
          [
            rootId,
            commentId,
          ],
        ),
        returnValue: _i4.Future<_i2.Comment>.value(_FakeComment_0(
          this,
          Invocation.method(
            #getComment,
            [
              rootId,
              commentId,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Comment>);
  @override
  _i4.Future<void> addComment(_i2.Comment? comment) => (super.noSuchMethod(
        Invocation.method(
          #addComment,
          [comment],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> likeComment(
    String? currentUserId,
    _i2.Comment? comment,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #likeComment,
          [
            currentUserId,
            comment,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> unlikeComment(
    String? currentUserId,
    _i2.Comment? comment,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #unlikeComment,
          [
            currentUserId,
            comment,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<bool> isCommentLiked(
    String? currentUserId,
    _i2.Comment? comment,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #isCommentLiked,
          [
            currentUserId,
            comment,
          ],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<void> shareLoop(_i6.Loop? loop) => (super.noSuchMethod(
        Invocation.method(
          #shareLoop,
          [loop],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> reportLoop({
    required String? reporterId,
    required _i6.Loop? loop,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #reportLoop,
          [],
          {
            #reporterId: reporterId,
            #loop: loop,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<int> followersNum(String? userid) => (super.noSuchMethod(
        Invocation.method(
          #followersNum,
          [userid],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<int> followingNum(String? userid) => (super.noSuchMethod(
        Invocation.method(
          #followingNum,
          [userid],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<void> followUser(
    String? currentUserId,
    String? visitedUserId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #followUser,
          [
            currentUserId,
            visitedUserId,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> unfollowUser(
    String? currentUserId,
    String? visitedUserId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #unfollowUser,
          [
            currentUserId,
            visitedUserId,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<bool> isFollowingUser(
    String? currentUserId,
    String? visitedUserId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #isFollowingUser,
          [
            currentUserId,
            visitedUserId,
          ],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<List<_i5.UserModel>> getFollowing(String? currentUserId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFollowing,
          [currentUserId],
        ),
        returnValue: _i4.Future<List<_i5.UserModel>>.value(<_i5.UserModel>[]),
      ) as _i4.Future<List<_i5.UserModel>>);
  @override
  _i4.Future<List<_i5.UserModel>> getFollowers(String? currentUserId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFollowers,
          [currentUserId],
        ),
        returnValue: _i4.Future<List<_i5.UserModel>>.value(<_i5.UserModel>[]),
      ) as _i4.Future<List<_i5.UserModel>>);
  @override
  _i4.Future<List<_i7.Activity>> getActivities(
    String? userId, {
    int? limit = 100,
    String? lastActivityId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getActivities,
          [userId],
          {
            #limit: limit,
            #lastActivityId: lastActivityId,
          },
        ),
        returnValue: _i4.Future<List<_i7.Activity>>.value(<_i7.Activity>[]),
      ) as _i4.Future<List<_i7.Activity>>);
  @override
  _i4.Stream<_i7.Activity> activitiesObserver(
    String? userId, {
    int? limit = 100,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #activitiesObserver,
          [userId],
          {#limit: limit},
        ),
        returnValue: _i4.Stream<_i7.Activity>.empty(),
      ) as _i4.Stream<_i7.Activity>);
  @override
  _i4.Future<void> addActivity({
    required String? currentUserId,
    required String? visitedUserId,
    required _i7.ActivityType? type,
    _i6.Loop? loop,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addActivity,
          [],
          {
            #currentUserId: currentUserId,
            #visitedUserId: visitedUserId,
            #type: type,
            #loop: loop,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> markActivityAsRead(_i7.Activity? activity) =>
      (super.noSuchMethod(
        Invocation.method(
          #markActivityAsRead,
          [activity],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<bool> isVerified(String? userId) => (super.noSuchMethod(
        Invocation.method(
          #isVerified,
          [userId],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<void> createBadge(_i8.Badge? badge) => (super.noSuchMethod(
        Invocation.method(
          #createBadge,
          [badge],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> sendBadge(
    String? badgeId,
    String? receiverId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendBadge,
          [
            badgeId,
            receiverId,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Stream<_i8.Badge> userCreatedBadgesObserver(
    String? userId, {
    int? limit = 100,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #userCreatedBadgesObserver,
          [userId],
          {#limit: limit},
        ),
        returnValue: _i4.Stream<_i8.Badge>.empty(),
      ) as _i4.Stream<_i8.Badge>);
  @override
  _i4.Future<List<_i8.Badge>> getUserCreatedBadges(
    String? userId, {
    int? limit = 100,
    String? lastBadgeId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserCreatedBadges,
          [userId],
          {
            #limit: limit,
            #lastBadgeId: lastBadgeId,
          },
        ),
        returnValue: _i4.Future<List<_i8.Badge>>.value(<_i8.Badge>[]),
      ) as _i4.Future<List<_i8.Badge>>);
  @override
  _i4.Stream<_i8.Badge> userBadgesObserver(
    String? userId, {
    int? limit = 100,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #userBadgesObserver,
          [userId],
          {#limit: limit},
        ),
        returnValue: _i4.Stream<_i8.Badge>.empty(),
      ) as _i4.Stream<_i8.Badge>);
  @override
  _i4.Future<List<_i8.Badge>> getUserBadges(
    String? userId, {
    int? limit = 100,
    String? lastBadgeId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserBadges,
          [userId],
          {
            #limit: limit,
            #lastBadgeId: lastBadgeId,
          },
        ),
        returnValue: _i4.Future<List<_i8.Badge>>.value(<_i8.Badge>[]),
      ) as _i4.Future<List<_i8.Badge>>);
  @override
  _i4.Future<void> createBooking(_i9.Booking? booking) => (super.noSuchMethod(
        Invocation.method(
          #createBooking,
          [booking],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i9.Booking?> getBookingById(String? bookRequestId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBookingById,
          [bookRequestId],
        ),
        returnValue: _i4.Future<_i9.Booking?>.value(),
      ) as _i4.Future<_i9.Booking?>);
  @override
  _i4.Future<List<_i9.Booking>> getBookingsByRequesterRequestee(
    String? requesterId,
    String? requesteeId, {
    int? limit = 20,
    String? lastBookingRequestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBookingsByRequesterRequestee,
          [
            requesterId,
            requesteeId,
          ],
          {
            #limit: limit,
            #lastBookingRequestId: lastBookingRequestId,
          },
        ),
        returnValue: _i4.Future<List<_i9.Booking>>.value(<_i9.Booking>[]),
      ) as _i4.Future<List<_i9.Booking>>);
  @override
  _i4.Future<List<_i9.Booking>> getBookingsByRequester(
    String? userId, {
    int? limit = 20,
    String? lastBookingRequestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBookingsByRequester,
          [userId],
          {
            #limit: limit,
            #lastBookingRequestId: lastBookingRequestId,
          },
        ),
        returnValue: _i4.Future<List<_i9.Booking>>.value(<_i9.Booking>[]),
      ) as _i4.Future<List<_i9.Booking>>);
  @override
  _i4.Future<List<_i9.Booking>> getBookingsByRequestee(
    String? userId, {
    int? limit = 20,
    String? lastBookingRequestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBookingsByRequestee,
          [userId],
          {
            #limit: limit,
            #lastBookingRequestId: lastBookingRequestId,
          },
        ),
        returnValue: _i4.Future<List<_i9.Booking>>.value(<_i9.Booking>[]),
      ) as _i4.Future<List<_i9.Booking>>);
  @override
  _i4.Future<void> updateBooking(_i9.Booking? booking) => (super.noSuchMethod(
        Invocation.method(
          #updateBooking,
          [booking],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> createService(_i10.Service? service) => (super.noSuchMethod(
        Invocation.method(
          #createService,
          [service],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> updateService(_i10.Service? service) => (super.noSuchMethod(
        Invocation.method(
          #updateService,
          [service],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i10.Service?> getServiceById(
    String? userId,
    String? serviceId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getServiceById,
          [
            userId,
            serviceId,
          ],
        ),
        returnValue: _i4.Future<_i10.Service?>.value(),
      ) as _i4.Future<_i10.Service?>);
  @override
  _i4.Future<List<_i10.Service>> getUserServices(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserServices,
          [userId],
        ),
        returnValue: _i4.Future<List<_i10.Service>>.value(<_i10.Service>[]),
      ) as _i4.Future<List<_i10.Service>>);
  @override
  _i4.Future<void> deleteService(
    String? userId,
    String? serviceId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteService,
          [
            userId,
            serviceId,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> showInterest({
    required String? userId,
    required String? loopId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showInterest,
          [],
          {
            #userId: userId,
            #loopId: loopId,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> cancelInterest({
    required String? userId,
    required String? loopId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #cancelInterest,
          [],
          {
            #userId: userId,
            #loopId: loopId,
          },
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<List<_i5.UserModel>> getInterestedUsers(String? loopId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getInterestedUsers,
          [loopId],
        ),
        returnValue: _i4.Future<List<_i5.UserModel>>.value(<_i5.UserModel>[]),
      ) as _i4.Future<List<_i5.UserModel>>);
  @override
  _i4.Future<bool> isInterested({
    required String? userId,
    required String? loopId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #isInterested,
          [],
          {
            #userId: userId,
            #loopId: loopId,
          },
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
