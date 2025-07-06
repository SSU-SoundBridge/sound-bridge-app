import 'package:flutter/material.dart';
import 'package:sound_bridge_app/features/venue/widgets/venue_contact_tab.dart';
import 'package:sound_bridge_app/features/venue/widgets/venue_info_card.dart';
import 'package:sound_bridge_app/features/venue/widgets/venue_performances_tab.dart';
import 'package:sound_bridge_app/features/venue/widgets/venue_reviews_tab.dart';
import 'package:sound_bridge_app/features/venue/widgets/venue_stats_row.dart';
import 'package:sound_bridge_app/models/venue_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_bottom_bar.dart';
import 'package:sound_bridge_app/shared/widgets/common_sliver_app_bar.dart';

class VenueDetailPage extends StatefulWidget {
  const VenueDetailPage({super.key, required this.venueId});

  final String venueId;

  @override
  State<VenueDetailPage> createState() => _VenueDetailPageState();
}

class _VenueDetailPageState extends State<VenueDetailPage>
    with SingleTickerProviderStateMixin {
  VenueModel? _venue;
  bool _isLoading = true;
  bool _isBookmarked = false;
  bool _isFollowing = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadVenueData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadVenueData() async {
    // 실제 앱에서는 API 호출
    await Future.delayed(const Duration(seconds: 1));

    // 더미 데이터
    var venue = VenueModel(
      id: widget.venueId,
      name: '홍대 재즈바',
      description: '홍대 지역의 대표적인 재즈 공연장입니다.',
      address: '서울 마포구 홍대입구역',
      detailAddress: '9길 25',
      latitude: 37.5563,
      longitude: 126.9236,
      phoneNumber: '02-1234-5678',
      website: 'https://hongdaejazzbar.com',
      instagramUrl: 'https://instagram.com/hongdaejazzbar',
      facebookUrl: 'https://facebook.com/hongdaejazzbar',
      imageUrls: [],
      capacity: 100,
      type: VenueType.jazzBar,
      genres: ['재즈', '블루스'],
      amenities: ['주차가능', '무대', '음향시설', '바'],
      operatingHours: {
        'monday': '18:00-02:00',
        'tuesday': '18:00-02:00',
        'wednesday': '18:00-02:00',
        'thursday': '18:00-02:00',
        'friday': '18:00-03:00',
        'saturday': '18:00-03:00',
        'sunday': '18:00-02:00',
      },
      rating: 4.5,
      reviewCount: 234,
      isOpen: true,
      isVerified: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    setState(() {
      _venue = venue;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_venue == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('공연장 상세')),
        body: const Center(child: Text('공연장 정보를 찾을 수 없습니다.')),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              CommonSliverAppBar(
                title: _venue!.name,
                backgroundType: AppBarBackgroundType.image,
                backgroundImage:
                    _venue!.imageUrls.isNotEmpty
                        ? _venue!.imageUrls.first
                        : null,
                centerIcon: Icons.location_on,
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
              SliverToBoxAdapter(child: _buildVenueInfo()),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: '공연'),
                      Tab(text: '리뷰'),
                      Tab(text: '연락처'),
                    ],
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondary,
                    indicatorColor: AppColors.primary,
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              VenuePerformancesTab(
                performances: [], // 더미 데이터 - 실제로는 API에서 가져옴
                onPerformancePressed: (performance) {
                  // 공연 상세 페이지로 이동
                },
              ),
              const VenueReviewsTab(),
              VenueContactTab(venue: _venue!),
            ],
          ),
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
            if (_venue!.phoneNumber != null)
              BottomBarButton(
                type: BottomBarButtonType.phone,
                phoneNumber: _venue!.phoneNumber,
                onPressed: null,
              ),
            BottomBarButton(
              type: BottomBarButtonType.map,
              latitude: _venue!.latitude,
              longitude: _venue!.longitude,
              onPressed: null,
            ),
            if (_venue!.website != null)
              BottomBarButton(
                type: BottomBarButtonType.website,
                url: _venue!.website,
                onPressed: null,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VenueStatsRow(venue: _venue!),
          const SizedBox(height: 16),
          VenueInfoCard(venue: _venue!),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.surface, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
