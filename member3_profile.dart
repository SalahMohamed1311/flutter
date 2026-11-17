import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/team_provider.dart';
import '../utils/format.dart';
import '../widgets/like_button.dart';

/// Member 3 - "Sunset Card": warm pastel theme, curved header with an
/// overlapping rounded-square avatar and Chip-based stats row.
class Member3Profile extends StatelessWidget {
  const Member3Profile({super.key, required this.memberId});

  final int memberId;

  @override
  Widget build(BuildContext context) {
    final m = context.watch<TeamProvider>().byId(memberId);
    final provider = context.read<TeamProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E6),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 210,
                decoration: BoxDecoration(
                  color: m.color,
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(90)),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 6,
                left: 8,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('< Back',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              Positioned(
                bottom: -55,
                left: 0,
                right: 0,
                child: Center(
                  child: Hero(
                    tag: m.heroTag,
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCCBC),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white, width: 5),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 10),
                        ],
                      ),
                      child: const Icon(Icons.face_retouching_natural,
                          size: 60, color: Color(0xFFBF360C)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),
          Center(
            child: Text(m.name,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5D4037))),
          ),
          Center(child: Text(m.handle, style: const TextStyle(color: Colors.brown))),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 8,
              children: [
                Chip(
                  avatar: const Icon(Icons.edit_note, size: 18),
                  label: Text('${formatNumber(m.posts)} Posts'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: const Icon(Icons.groups, size: 18),
                  label: Text('${formatNumber(m.followers)} Followers'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: const Icon(Icons.person_add_alt, size: 18),
                  label: Text('${formatNumber(m.following)} Following'),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Chasing sunsets and shipping Flutter apps. '
                  'Coffee first, widgets second.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF6D4C41), height: 1.4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Center(
            child: ElevatedButton(
              onPressed: () => provider.toggleFollow(m.id),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: m.isFollowed ? Colors.brown.shade200 : m.color,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
              ),
              child: Text(m.isFollowed ? 'Following ✓' : 'Follow'),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: LikeButton(
              liked: m.isLiked,
              count: m.likes,
              color: const Color(0xFFD84315),
              onLike: () => provider.toggleLike(m.id),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
