import 'package:flutter/material.dart';

import '../models/member.dart';

/// Simulated backend. No numbers are hardcoded in the UI:
/// everything arrives through this 2-second Future.
class ApiService {
  Future<List<Member>> fetchTeam() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      Member(
        id: 1, name: 'Student A', handle: '@student_a', initials: 'A',
        color: const Color(0xFF7C4DFF),
        posts: 12, followers: 5200, following: 310, likes: 240,
      ),
      Member(
        id: 2, name: 'Student B', handle: '@student_b', initials: 'B',
        color: const Color(0xFF00897B),
        posts: 8, followers: 3100, following: 180, likes: 130,
      ),
      Member(
        id: 3, name: 'Student C', handle: '@student_c', initials: 'C',
        color: const Color(0xFFFF7043),
        posts: 15, followers: 7800, following: 422, likes: 510,
      ),
      Member(
        id: 4, name: 'Student D', handle: '@student_d', initials: 'D',
        color: const Color(0xFF43A047),
        posts: 20, followers: 9400, following: 95, likes: 760,
      ),
    ];
  }
}
