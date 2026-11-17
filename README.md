# Team Hub - Mobile Programming Lab 3

## Run
```bash
cd team_hub
flutter create .      # generates android/ios/web folders (keeps lib/ and pubspec.yaml)
flutter pub get
flutter run
```

## Folder structure (Bonus: Code Modularity)
```
lib/
  main.dart
  models/member.dart
  services/api_service.dart        # Future.delayed(2s) simulated API
  providers/team_provider.dart     # lifted shared state (Provider)
  utils/format.dart
  widgets/like_button.dart         # double-tap + AnimatedScale
  screens/
    home_screen.dart               # StatefulWidget root
    member1_profile.dart           # Neon Night
    member2_profile.dart           # Collapsing slivers
    member3_profile.dart           # Sunset card
    member4_profile.dart           # Retro terminal
```

## Requirement mapping
| Requirement | Where |
|---|---|
| StatefulWidget root + counter with setState | `home_screen.dart` |
| Team total followers & posts | `home_screen.dart` (reads `TeamProvider`) |
| 2s Future + CircularProgressIndicator, no hardcoded numbers | `api_service.dart`, `home_screen.dart` |
| Navigator.push to each profile / Navigator.pop back | `home_screen.dart`, every profile |
| Unique profile styling, avatar, stats row | `member1..4_profile.dart` |
| Follow -> total updates instantly on return | `TeamProvider.toggleFollow` + `context.watch` |
| Bonus Hero | avatar tag `member.heroTag` (home <-> profiles) |
| Bonus Double-tap + AnimatedScale | `widgets/like_button.dart` |
| Bonus CustomScrollView + SliverAppBar | `member2_profile.dart` |
| Bonus Code Modularity | folder structure above |

## Before submitting
Replace "Student A/B/C/D" names/handles in `services/api_service.dart` with your real team.
If your team has 3 members, delete one profile and its entry in `api_service.dart` and `_profileFor` in `home_screen.dart`.
