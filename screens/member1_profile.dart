import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/team_provider.dart';
import '../utils/format.dart';
import '../widgets/like_button.dart';

/// Member 1 - "Neon Night": dark gradient, glowing ring avatar,
/// bordered stat boxes, plain Column layout.
class Member1Profile extends StatelessWidget {
  const Member1Profile({super.key, required this.memberId});

  final int memberId;

  static const _cyan = Color(0xFF4CC9F0);
  static const _pink = Color(0xFFF72585);

  @override
  Widget build(BuildContext context) {
    final m = context.watch<TeamProvider>().byId(memberId);
    final provider = context.read<TeamProvider>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D0221), Color(0xFF3A0CA3)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('< Back',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 10),
                Hero(
                  tag: m.heroTag,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(colors: [_cyan, _pink, _cyan]),
                      boxShadow: [
                        BoxShadow(color: _pink, blurRadius: 24, spreadRadius: 1),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 62,
                      backgroundColor: const Color(0xFF0D0221),
                      child: Text(m.initials,
                          style: const TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                              color: _cyan)),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(m.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5)),
                Text(m.handle, style: const TextStyle(color: _cyan)),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NeonStat(label: 'Posts', value: formatNumber(m.posts)),
                    _NeonStat(
                        label: 'Followers', value: formatNumber(m.followers)),
                    _NeonStat(
                        label: 'Following', value: formatNumber(m.following)),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => provider.toggleFollow(m.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: m.isFollowed ? Colors.transparent : _pink,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: _pink, width: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                  ),
                  icon: Icon(m.isFollowed ? Icons.check : Icons.person_add),
                  label: Text(m.isFollowed ? 'Following' : 'Follow'),
                ),
                const SizedBox(height: 24),
                LikeButton(
                  liked: m.isLiked,
                  count: m.likes,
                  color: _pink,
                  textColor: Colors.white,
                  onLike: () => provider.toggleLike(m.id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NeonStat extends StatelessWidget {
  const _NeonStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Member1Profile._cyan, width: 1.5),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(color: Member1Profile._cyan, fontSize: 12)),
        ],
      ),
    );
  }
}
