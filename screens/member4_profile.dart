import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/team_provider.dart';
import '../utils/format.dart';
import '../widgets/like_button.dart';

/// Member 4 - "Retro Terminal": black/green monospace look, Table-based
/// stats, timeline log of posts and an extended FAB for Follow.
class Member4Profile extends StatelessWidget {
  const Member4Profile({super.key, required this.memberId});

  final int memberId;

  static const _green = Color(0xFF00FF66);
  static const _mono = TextStyle(fontFamily: 'monospace', color: _green);

  @override
  Widget build(BuildContext context) {
    final m = context.watch<TeamProvider>().byId(memberId);
    final provider = context.read<TeamProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: _green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('> ${m.handle}', style: _mono),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => provider.toggleFollow(m.id),
        backgroundColor: _green,
        foregroundColor: Colors.black,
        icon: Icon(m.isFollowed ? Icons.check : Icons.add),
        label: Text(m.isFollowed ? 'UNFOLLOW' : 'FOLLOW',
            style: const TextStyle(
                fontFamily: 'monospace', fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
        children: [
          Center(
            child: Hero(
              tag: m.heroTag,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF001A0A),
                  border: Border.all(color: _green, width: 3),
                ),
                child: const Icon(Icons.terminal, size: 64, color: _green),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text('[ ${m.name.toUpperCase()} ]',
                style: _mono.copyWith(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 22),
          Container(
            decoration: BoxDecoration(border: Border.all(color: _green)),
            padding: const EdgeInsets.all(12),
            child: Table(
              children: [
                _row('POSTS', formatNumber(m.posts)),
                _row('FOLLOWERS', formatNumber(m.followers)),
                _row('FOLLOWING', formatNumber(m.following)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Center(
            child: LikeButton(
              liked: m.isLiked,
              count: m.likes,
              color: _green,
              onLike: () => provider.toggleLike(m.id),
            ),
          ),
          const SizedBox(height: 22),
          Text('// RECENT LOG', style: _mono.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          for (var i = 0; i < 5; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text('[T-${i + 1}d] post_${m.posts - i}.exe  OK',
                  style: _mono.copyWith(fontSize: 13)),
            ),
        ],
      ),
    );
  }

  TableRow _row(String k, String v) => TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text('$k ........', style: _mono),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(v,
                textAlign: TextAlign.right,
                style: _mono.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      );
}
