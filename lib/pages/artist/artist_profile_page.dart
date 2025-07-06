import 'package:flutter/material.dart';
import 'package:sound_bridge_app/features/artist/widgets/artist_info_card.dart';
import 'package:sound_bridge_app/features/artist/widgets/artist_performances_section.dart';
import 'package:sound_bridge_app/features/artist/widgets/artist_reviews_section.dart';
import 'package:sound_bridge_app/features/artist/widgets/artist_stats_row.dart';
import 'package:sound_bridge_app/models/artist_model.dart';
import 'package:sound_bridge_app/models/performance_model.dart';
import 'package:sound_bridge_app/shared/widgets/common_bottom_bar.dart';
import 'package:sound_bridge_app/shared/widgets/common_sliver_app_bar.dart';

class ArtistProfilePage extends StatefulWidget {
  const ArtistProfilePage({super.key, required this.artistId});

  final String artistId;

  @override
  State<ArtistProfilePage> createState() => _ArtistProfilePageState();
}

class _ArtistProfilePageState extends State<ArtistProfilePage> {
  ArtistModel? _artist;
  List<PerformanceModel> _performances = [];
  List<ArtistReviewModel> _reviews = [];
  bool _isLoading = true;
  bool _isBookmarked = false;
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _loadArtistData();
  }

  Future<void> _loadArtistData() async {
    // 실제 앱에서는 API 호출
    await Future.delayed(const Duration(seconds: 1));

    // 더미 데이터
    var artist = ArtistModel(
      id: widget.artistId,
      name: '재즈 앙상블',
      bio: '한국을 대표하는 재즈 그룹으로 활동하고 있습니다.',
      genres: ['재즈'],
      instruments: ['피아노', '색소폰', '드럼'],
      profileImageUrl: null,
      coverImageUrl: null,
      instagramUrl: 'https://instagram.com/jazzensemble',
      youtubeUrl: 'https://youtube.com/jazzensemble',
      spotifyUrl: 'https://spotify.com/artist/jazzensemble',
      rating: 4.8,
      reviewCount: 156,
      followerCount: 1234,
      performanceCount: 45,
      isVerified: true,
      isAvailable: true,
      contactEmail: 'contact@jazzensemble.com',
      phoneNumber: '02-1234-5678',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    var performances = [
      PerformanceModel(
        id: '1',
        title: '재즈 나이트 - 어반 사운드',
        description: '특별한 재즈 공연',
        artistId: widget.artistId,
        artistName: artist.name,
        venueId: 'venue1',
        venueName: '홍대 재즈바',
        venueAddress: '서울 마포구 홍대입구역',
        latitude: 37.5563,
        longitude: 126.9236,
        startTime: DateTime.now().add(const Duration(days: 1)),
        endTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
        genre: '재즈',
        capacity: 50,
        currentBookings: 23,
        price: 25000,
        imageUrl: '',
        tags: ['재즈', '라이브'],
        status: PerformanceStatus.upcoming,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    var reviews = [
      ArtistReviewModel(
        id: '1',
        artistId: widget.artistId,
        userId: 'user1',
        userName: '재즈 마니아',
        rating: 5.0,
        comment: '정말 훌륭한 공연이었습니다!',
        performanceId: '1',
        performanceTitle: '재즈 나이트',
        createdAt: DateTime.now(),
      ),
    ];

    setState(() {
      _artist = artist;
      _performances = performances;
      _reviews = reviews;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_artist == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('아티스트 정보')),
        body: const Center(child: Text('아티스트 정보를 찾을 수 없습니다.')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CommonSliverAppBar(
            title: _artist!.name,
            centerIcon: Icons.person,
            showBookmark: true,
            showShare: true,
            isBookmarked: _isBookmarked,
            onBookmarkPressed: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
            },
            onSharePressed: () {
              // 공유 기능 구현
            },
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildArtistInfo(),
                ArtistPerformancesSection(performances: _performances),
                ArtistReviewsSection(
                  reviews: _reviews,
                  reviewCount: _artist!.reviewCount,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CommonBottomBar(
        primaryButton: BottomBarButton(
          type: BottomBarButtonType.follow,
          isActive: _isFollowing,
          onPressed: () {
            setState(() {
              _isFollowing = !_isFollowing;
            });
          },
        ),
        secondaryButtons: [
          if (_artist!.phoneNumber != null)
            BottomBarButton(
              type: BottomBarButtonType.phone,
              phoneNumber: _artist!.phoneNumber,
              onPressed: null,
            ),
          if (_artist!.instagramUrl != null)
            BottomBarButton(
              type: BottomBarButtonType.website,
              url: _artist!.instagramUrl,
              onPressed: null,
            ),
        ],
      ),
    );
  }

  Widget _buildArtistInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArtistStatsRow(artist: _artist!),
          const SizedBox(height: 16),
          ArtistInfoCard(artist: _artist!),
        ],
      ),
    );
  }
}
