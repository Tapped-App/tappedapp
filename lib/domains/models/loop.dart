import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/utils/app_logger.dart';
import 'package:intheloopapp/utils/default_value.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'loop.g.dart';

/// The definition for a [Loop]
///
/// This type is almost identical to the schema used to store
/// loops in the DB
@JsonSerializable()
class Loop extends Equatable {
  /// A [Loop] requires every field to be filled
  /// i.e. no optional fields
  const Loop({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.audioPath,
    required this.imagePaths,
    required this.timestamp,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.isOpportunity,
    required this.commentsLocked,
    // required this.tags,
    required this.deleted,
  });

  /// Creates a [Loop] with default values
  factory Loop.empty({
    required String userId,
    required String description,
  }) =>
      Loop(
        id: const Uuid().v4(),
        userId: userId,
        title: const Option.none(),
        description: description,
        audioPath: const Option.none(),
        imagePaths: const [],
        timestamp: DateTime.now(),
        likeCount: 0,
        commentCount: 0,
        shareCount: 0,
        isOpportunity: false,
        commentsLocked: false,
        // tags: const [],
        deleted: false,
      );

  /// Builds a [Loop] from a firebase [DocumentSnapshot]
  ///
  /// And attempts to provide sensible defaults
  /// if values are missing
  factory Loop.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    try {
      final tmpTimestamp = doc.getOrElse(
        'timestamp',
        Timestamp.now(),
      ) as Timestamp;

      return Loop(
        id: doc.id,
        userId: doc.getOrElse('userId', ''),
        title: Option.fromNullable(doc.getOrElse<String?>('title', null)),
        description: doc.getOrElse('description', ''),
        audioPath:
            Option.fromNullable(doc.getOrElse<String?>('audioPath', null)),
        imagePaths: List.from(
          doc.getOrElse<Iterable<dynamic>>(
            'imagePaths',
            [],
          ),
        ),
        timestamp: tmpTimestamp.toDate(),
        likeCount: doc.getOrElse('likeCount', 0),
        commentCount: doc.getOrElse('commentCount', 0),
        shareCount: doc.getOrElse('shareCount', 0),
        isOpportunity: doc.getOrElse('isOpportunity', false),
        commentsLocked: doc.getOrElse('commentsLocked', false),
        // tags: List.from(
        //   doc.getOrElse('tags', <dynamic>[]) as Iterable<dynamic>,
        // ),
        deleted: doc.getOrElse('deleted', false),
      );
    } catch (e, s) {
      logger.error(
        'Error building loop from doc',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  /// Builds a [Loop] from a `Map` using the autogenerated
  /// methods from jsonserialize
  factory Loop.fromJson(Map<String, dynamic> json) => _$LoopFromJson(json);

  /// Converts a [Loop] to a `Map` using the autogenerated
  /// methods from jsonserialize
  Map<String, dynamic> toJson() => _$LoopToJson(this);

  // toMap keeps the Timestamp object and toJson doesn't
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'title': title.asNullable(),
        'description': description,
        'audioPath': audioPath.asNullable(),
        'imagePaths': imagePaths,
        'timestamp': timestamp,
        'likeCount': likeCount,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'isOpportunity': isOpportunity,
        'commentsLocked': commentsLocked,
        // 'tags': tags,
        'deleted': deleted,
      };

  /// The uuid of this [Loop]
  final String id;

  /// The id of this [Loop]'s author
  final String userId;

  /// The title for this [Loop]
  @OptionalStringConverter()
  final Option<String> title;

  /// The description/caption/body for this [Loop]
  final String description;

  /// The url for the audio associated with this [Loop]
  @OptionalStringConverter()
  final Option<String> audioPath;

  /// The urls for the images associated with this [Loop]
  final List<String> imagePaths;

  /// The timestamp this [Loop] for created at
  final DateTime timestamp;

  /// The number of likes this [Loop] has
  final int likeCount;

  /// The number of comments this [Loop] has
  final int commentCount;

  /// The number of shares this [Loop] has
  final int shareCount;

  /// If the [Loop] was marked as an opportunity
  /// this would mean it collects userIds from interested
  /// users
  final bool isOpportunity;

  /// If the [Loop] was locked for comments
  /// this would prevent users from adding
  /// comments to the [Loop]
  final bool commentsLocked;

  /// The tags associated with this [Loop]
  // final List<String> tags;

  /// Whether this [Loop] was deleted
  final bool deleted;

  @override
  List<Object> get props => [
        id,
        userId,
        title,
        description,
        audioPath,
        imagePaths,
        likeCount,
        commentCount,
        shareCount,
        isOpportunity,
        commentsLocked,
        // tags,
        deleted,
      ];

  /// Creates a new [Loop] with select attributes changed
  ///
  /// Loops are immutable so to modify a value
  /// a new [Loop] must be created with unchanged
  /// values being copied from the original [Loop]
  Loop copyWith({
    String? id,
    String? userId,
    Option<String>? title,
    String? description,
    Option<String>? audioPath,
    List<String>? imagePaths,
    DateTime? timestamp,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    bool? isOpportunity,
    bool? commentsLocked,
    // List<String>? tags,
    bool? deleted,
  }) {
    return Loop(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      audioPath: audioPath ?? this.audioPath,
      imagePaths: imagePaths ?? this.imagePaths,
      timestamp: timestamp ?? this.timestamp,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      isOpportunity: isOpportunity ?? this.isOpportunity,
      commentsLocked: commentsLocked ?? this.commentsLocked,
      // tags: tags ?? this.tags,
      deleted: deleted ?? this.deleted,
    );
  }
}
