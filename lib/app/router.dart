import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 페이지 imports
import 'package:sound_bridge_app/pages/artist/artist_profile_page.dart';
import 'package:sound_bridge_app/pages/home/home_page.dart';
import 'package:sound_bridge_app/pages/performance/performance_detail_page.dart';
import 'package:sound_bridge_app/pages/performance/performance_map_page.dart';
import 'package:sound_bridge_app/pages/profile/profile_page.dart';
import 'package:sound_bridge_app/pages/venue/venue_detail_page.dart';
import 'package:sound_bridge_app/pages/venue/venue_list_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/performance-map',
        name: 'performance-map',
        builder: (context, state) => const PerformanceMapPage(),
      ),
      GoRoute(
        path: '/performance/:performanceId',
        name: 'performance-detail',
        builder: (context, state) {
          String performanceId = state.pathParameters['performanceId']!;
          return PerformanceDetailPage(performanceId: performanceId);
        },
      ),
      GoRoute(
        path: '/venues',
        name: 'venues',
        builder: (context, state) => const VenueListPage(),
      ),
      GoRoute(
        path: '/venue/:venueId',
        name: 'venue-detail',
        builder: (context, state) {
          String venueId = state.pathParameters['venueId']!;
          return VenueDetailPage(venueId: venueId);
        },
      ),
      GoRoute(
        path: '/artist/:artistId',
        name: 'artist-profile',
        builder: (context, state) {
          String artistId = state.pathParameters['artistId']!;
          return ArtistProfilePage(artistId: artistId);
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  '페이지를 찾을 수 없습니다',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  '경로: ${state.uri.toString()}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('홈으로 돌아가기'),
                ),
              ],
            ),
          ),
        ),
  );
}
