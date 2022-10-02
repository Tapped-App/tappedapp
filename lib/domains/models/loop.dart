import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intheloopapp/utils.dart';
import 'package:json_annotation/json_annotation.dart';

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
    required this.audio,
    required this.timestamp,
    required this.likes,
    required this.downloads,
    required this.comments,
    required this.shares,
    required this.tags,
    required this.deleted,
  });

  /// Creates a [Loop] with default values
  factory Loop.empty() => Loop(
        id: '',
        userId: '',
        title: '',
        audio: '',
        timestamp: DateTime.now(),
        likes: 0,
        downloads: 0,
        comments: 0,
        shares: 0,
        tags: const [],
        deleted: false,
      );

  /// Builds a [Loop] from a firebase `DocumentSnapshot`
  ///
  /// And attempts to provide sensible defaults
  /// if values are missing
  factory Loop.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final tmpTimestamp = doc.getOrElse(
      'timestamp',
      Timestamp.now(),
    ) as Timestamp;

    return Loop(
      id: doc.id,
      userId: doc.getOrElse('userId', '') as String,
      title: doc.getOrElse('title', '') as String,
      audio: doc.getOrElse('audio', '') as String,
      timestamp: tmpTimestamp.toDate(),
      likes: doc.getOrElse('likes', 0) as int,
      downloads: doc.getOrElse('downloads', 0) as int,
      comments: doc.getOrElse('comments', 0) as int,
      shares: doc.getOrElse('shares', 0) as int,
      tags: List.from(
        doc.getOrElse('tags', <String>[]) as Iterable<String>,
      ),
      deleted: doc.getOrElse('deleted', false) as bool,
    );
  }

  /// Builds a [Loop] from a `Map` using the autogenerated
  /// methods from jsonserialize
  factory Loop.fromJson(Map<String, dynamic> json) => _$LoopFromJson(json);

  /// Converts a [Loop] to a `Map` using the autogenerated
  /// methods from jsonserialize
  Map<String, dynamic> toJson() => _$LoopToJson(this);

  /// The uuid of this [Loop]
  final String id;

  /// The id of this [Loop]'s author
  final String userId;

  /// The title for this [Loop]
  final String title;

  /// The url for the audio associated with this [Loop]
  final String audio;

  /// The timestamp this [Loop] for created at
  final DateTime timestamp;

  /// The number of likes this [Loop] has
  final int likes;

  /// The number of downloads this [Loop] has
  final int downloads;

  /// The number of comments this [Loop] has
  final int comments;

  /// The number of shares this [Loop] has
  final int shares;

  /// The tags associated with this [Loop]
  final List<String> tags;

  /// Whether this [Loop] was deleted
  final bool deleted;

  @override
  List<Object> get props => [
        id,
        userId,
        title,
        audio,
        likes,
        downloads,
        comments,
        shares,
        tags,
        deleted,
      ];

  /// Whether a [Loop] is empty
  bool get isEmpty => this == Loop.empty();

  /// Whether a [Loop] isn't empty
  bool get isNotEmpty => this != Loop.empty();

  /// Creates a new [Loop] with select attributes changed
  ///
  /// Loops are immutable so to modify a value
  /// a new [Loop] must be created with unchanged
  /// values being copied from the original [Loop]
  Loop copyWith({
    String? id,
    String? userId,
    String? title,
    String? audio,
    DateTime? timestamp,
    int? likes,
    int? downloads,
    int? comments,
    int? shares,
    List<String>? tags,
    bool? deleted,
  }) {
    return Loop(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      audio: audio ?? this.audio,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      downloads: downloads ?? this.downloads,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      tags: tags ?? this.tags,
      deleted: deleted ?? this.deleted,
    );
  }
}
