import 'package:flutter/material.dart';

class Member {
  Member({
    required this.id,
    required this.name,
    required this.handle,
    required this.initials,
    required this.color,
    required this.posts,
    required this.followers,
    required this.following,
    required this.likes,
  });

  final int id;
  final String name;
  final String handle;
  final String initials;
  final Color color;

  int posts;
  int followers;
  int following;
  int likes;
  bool isFollowed = false;
  bool isLiked = false;

  /// Shared Hero tag: Home avatar <-> Profile avatar.
  String get heroTag => 'avatar_$id';
}
