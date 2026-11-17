import 'package:flutter/foundation.dart';

import '../models/member.dart';
import '../services/api_service.dart';

/// Single source of truth (lifted state). Profiles mutate it,
/// the Home Dashboard listens to it -> totals update instantly.
class TeamProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<Member> _members = [];
  bool _loading = false;
  bool _loaded = false;

  List<Member> get members => List.unmodifiable(_members);
  bool get isLoading => _loading;
  bool get isLoaded => _loaded;

  int get totalFollowers => _members.fold(0, (s, m) => s + m.followers);
  int get totalPosts => _members.fold(0, (s, m) => s + m.posts);

  Member byId(int id) => _members.firstWhere((m) => m.id == id);

  Future<void> load() async {
    if (_loading || _loaded) return;
    _loading = true;
    notifyListeners();
    _members = await _api.fetchTeam();
    _loading = false;
    _loaded = true;
    notifyListeners();
  }

  void toggleFollow(int id) {
    final m = byId(id);
    if (m.isFollowed) {
      m.isFollowed = false;
      m.followers--;
    } else {
      m.isFollowed = true;
      m.followers++;
    }
    notifyListeners();
  }

  void toggleLike(int id) {
    final m = byId(id);
    if (m.isLiked) {
      m.isLiked = false;
      m.likes--;
    } else {
      m.isLiked = true;
      m.likes++;
    }
    notifyListeners();
  }
}
