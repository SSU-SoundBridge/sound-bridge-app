import 'package:flutter/material.dart';
import 'package:sound_bridge_app/features/performance/widgets/performance_detail_tab.dart';
import 'package:sound_bridge_app/features/performance/widgets/performance_reviews_tab.dart';
import 'package:sound_bridge_app/features/performance/widgets/performance_venue_info_tab.dart';
import 'package:sound_bridge_app/models/performance_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_bottom_bar.dart';
import 'package:sound_bridge_app/shared/widgets/common_sliver_app_bar.dart';

class PerformanceDetailPage extends StatefulWidget {
  const PerformanceDetailPage({super.key, required this.performanceId});

  final String performanceId;

  @override
  State<PerformanceDetailPage> createState() => _PerformanceDetailPageState();
}

class _PerformanceDetailPageState extends State<PerformanceDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  PerformanceModel? _performance;
  bool _isLoading = true;
  bool _isBookmarked = false;

  // 더미 데이터 - 실제 앱에서는 API에서 가져옴
  final Map<String, PerformanceModel> _dummyPerformances = {
    '1': PerformanceModel(
      id: '1',
      title: '재즈 나이트 - 어반 사운드',
      description:
          '홍대 최고의 재즈바에서 펼쳐지는 특별한 재즈 공연입니다. 국내 최고의 재즈 뮤지션들이 선사하는 감동적인 음악 여행을 경험해보세요.',
      artistId: 'artist1',
      artistName: '재즈 앙상블',
      venueId: 'venue1',
      venueName: '홍대 재즈바',
      venueAddress: '서울 마포구 홍대입구역 3번 출구 도보 5분',
      latitude: 37.5563,
      longitude: 126.9236,
      startTime: DateTime.now().add(const Duration(days: 1)),
      endTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
      genre: '재즈',
      capacity: 50,
      currentBookings: 23,
      price: 25000,
      imageUrl: 'https://example.com/jazz-night.jpg',
      tags: ['재즈', '라이브', '홍대', '어반'],
      status: PerformanceStatus.upcoming,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadPerformanceData();
  }

  Future<void> _loadPerformanceData() async {
    // 실제 앱에서는 API 호출
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _performance = _dummyPerformances[widget.performanceId];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_performance == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('공연 정보')),
        body: const Center(child: Text('공연 정보를 찾을 수 없습니다.')),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              CommonSliverAppBar(
                title: _performance!.title,
                backgroundType: AppBarBackgroundType.image,
                backgroundImage:
                    _performance!.imageUrl != null &&
                            _performance!.imageUrl!.isNotEmpty
                        ? _performance!.imageUrl
                        : null,
                centerIcon: Icons.music_note,
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
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: '공연 정보'),
                      Tab(text: '장소 정보'),
                      Tab(text: '리뷰'),
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
              PerformanceDetailTab(performance: _performance!),
              PerformanceVenueInfoTab(performance: _performance!),
              const PerformanceReviewsTab(),
            ],
          ),
        ),
        bottomNavigationBar: CommonBottomBar(
          primaryButton: BottomBarButton(
            type: BottomBarButtonType.booking,
            onPressed: () {
              // 예약 기능 구현
            },
          ),
          secondaryButtons: [
            if (_performance!.venueId.isNotEmpty)
              BottomBarButton(
                type: BottomBarButtonType.map,
                latitude: _performance!.latitude,
                longitude: _performance!.longitude,
                onPressed: null,
              ),
          ],
          showPriceInfo: true,
          priceValue: '${_performance!.price.toStringAsFixed(0)}원',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
