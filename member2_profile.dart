import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/team_provider.dart';
import '../utils/format.dart';
import '../widgets/like_button.dart';

/// Member 2 - "Collapsing Gallery": CustomScrollView + SliverAppBar
/// (Bonus: Advanced Scrolling), stats separated by dividers, post feed.
class Member2Profile extends StatelessWidget {
  const Member2Profile({super.key, required this.memberId});

  final int memberId;

  @override
  Widget build(BuildContext context) {
    final m = context.watch<TeamProvider>().byId(memberId);
    final provider = context.read<TeamProvider>();
    final postCount = m.posts > 10 ? 10 : m.posts;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: m.color,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: 'Back',
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(m.name),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [m.color, m.color.withOpacity(0.55)],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Hero(
                      tag: m.heroTag,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white70, width: 5),
                        ),
                        child: Icon(Icons.person, size: 70, color: m.color),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(m.handle,
                      style: TextStyle(
                          color: m.color,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        _cell('Posts', formatNumber(m.posts)),
                        const VerticalDivider(width: 1),
                        _cell('Followers', formatNumber(m.followers)),
                        const VerticalDivider(width: 1),
                        _cell('Following', formatNumber(m.following)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: m.isFollowed ? Colors.grey : m.color,
                          minimumSize: const Size(130, 46),
                        ),
                        onPressed: () => provider.toggleFollow(m.id),
                        child: Text(m.isFollowed ? 'Unfollow' : 'Follow'),
                      ),
                      LikeButton(
                        liked: m.isLiked,
                        count: m.likes,
                        color: m.color,
                        onLike: () => provider.toggleLike(m.id),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => Card(
                  child: ListTile(
                    leading: Icon(Icons.photo, color: m.color),
                    title: Text('Post #${m.posts - i}'),
                    subtitle: Text('Shared ${i + 1} day(s) ago'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                childCount: postCount,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cell(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
