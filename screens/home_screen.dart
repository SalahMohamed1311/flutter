import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/member.dart';
import '../providers/team_provider.dart';
import '../utils/format.dart';
import 'member1_profile.dart';
import 'member2_profile.dart';
import 'member3_profile.dart';
import 'member4_profile.dart';

/// Root screen - StatefulWidget (required).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0; // local state, updated with setState()

  @override
  void initState() {
    super.initState();
    // Kick off the simulated 2-second API call.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeamProvider>().load();
    });
  }

  Widget _profileFor(int id) {
    switch (id) {
      case 1:
        return Member1Profile(memberId: id);
      case 2:
        return Member2Profile(memberId: id);
      case 3:
        return Member3Profile(memberId: id);
      default:
        return Member4Profile(memberId: id);
    }
  }

  void _open(Member m) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _profileFor(m.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final team = context.watch<TeamProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Hub'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ---- Counter feature (setState) ----
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Counter: $_counter',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () => setState(() => _counter++),
                    icon: const Icon(Icons.add),
                    label: const Text('Increment'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ---- Team stats (async) ----
          if (team.isLoading || !team.isLoaded)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading team data...'),
                ],
              ),
            )
          else ...[
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.people,
                    label: 'Total Followers',
                    value: formatNumber(team.totalFollowers),
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.article,
                    label: 'Total Posts',
                    value: formatNumber(team.totalPosts),
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Team Members',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            for (final m in team.members)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Bonus: Hero - tap avatar to fly into the profile.
                      GestureDetector(
                        onTap: () => _open(m),
                        child: Hero(
                          tag: m.heroTag,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: m.color,
                            child: Text(
                              m.initials,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(
                                '${formatNumber(m.followers)} followers • ${m.posts} posts'),
                          ],
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: () => _open(m),
                        child: Text('→ Member ${m.id} Profile'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(value,
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold, color: color)),
            Text(label),
          ],
        ),
      ),
    );
  }
}
