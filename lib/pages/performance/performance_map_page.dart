import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sound_bridge_app/features/performance/widgets/performance_detail_bottom_sheet.dart';
import 'package:sound_bridge_app/models/performance_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_sliver_app_bar.dart';
import 'package:sound_bridge_app/shared/widgets/kakao_map_widget.dart';

class PerformanceMapPage extends StatefulWidget {
  const PerformanceMapPage({super.key});

  @override
  State<PerformanceMapPage> createState() => _PerformanceMapPageState();
}

class _PerformanceMapPageState extends State<PerformanceMapPage> {
  Position? _currentPosition;
  List<PerformanceModel> _performances = [];
  String _selectedGenre = '전체';
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  double _currentLatitude = 37.5665;
  double _currentLongitude = 126.9780;

  // 더미 데이터 - 실제 앱에서는 API에서 가져옴
  final List<PerformanceModel> _dummyPerformances = [
    // All That Jazz 공연들
    PerformanceModel(
      id: '1',
      title: 'Modern Jazz Night',
      description: '현대 재즈의 매력을 느낄 수 있는 특별한 밤',
      artistId: 'artist1',
      artistName: 'Seoul Jazz Quartet',
      venueId: 'venue1',
      venueName: 'All That Jazz',
      venueAddress: '서울 마포구 홍대입구역 근처',
      latitude: 37.5563,
      longitude: 126.9236,
      startTime: DateTime.now().add(const Duration(days: 1)),
      endTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
      genre: '재즈',
      capacity: 50,
      currentBookings: 35,
      price: 35000,
      tags: ['재즈', '라이브', '홍대', '모던재즈'],
      status: PerformanceStatus.upcoming,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),

    // Blue Note Seoul 공연들
    PerformanceModel(
      id: '2',
      title: 'Blue Note Sessions',
      description: 'Blue Note 스타일의 정통 재즈 공연',
      artistId: 'artist2',
      artistName: 'Hannam Jazz Collective',
      venueId: 'venue2',
      venueName: 'Blue Note Seoul',
      venueAddress: '서울 용산구 한남동',
      latitude: 37.5349,
      longitude: 126.9947,
      startTime: DateTime.now().add(const Duration(days: 2)),
      endTime: DateTime.now().add(const Duration(days: 2, hours: 3)),
      genre: '재즈',
      capacity: 120,
      currentBookings: 89,
      price: 45000,
      tags: ['재즈', '블루노트', '한남', '정통재즈'],
      status: PerformanceStatus.upcoming,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),

    // Club Evans 공연들
    PerformanceModel(
      id: '3',
      title: 'Fusion Jazz Experience',
      description: '퓨전 재즈의 새로운 경험',
      artistId: 'artist3',
      artistName: 'Evans Fusion Band',
      venueId: 'venue3',
      venueName: 'Club Evans',
      venueAddress: '서울 마포구 홍대 클럽가',
      latitude: 37.5580,
      longitude: 126.9244,
      startTime: DateTime.now().add(const Duration(hours: 6)),
      endTime: DateTime.now().add(const Duration(hours: 8)),
      genre: '퓨전재즈',
      capacity: 80,
      currentBookings: 42,
      price: 28000,
      tags: ['퓨전재즈', '라이브', '홍대', '실험적'],
      status: PerformanceStatus.upcoming,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),

    // Jazz Story 공연들
    PerformanceModel(
      id: '4',
      title: 'Vocal Jazz Night',
      description: '감미로운 보컬 재즈의 밤',
      artistId: 'artist4',
      artistName: 'Seoul Jazz Vocal Trio',
      venueId: 'venue4',
      venueName: 'Jazz Story',
      venueAddress: '서울 강남구 역삼동',
      latitude: 37.4979,
      longitude: 127.0276,
      startTime: DateTime.now().add(const Duration(days: 3)),
      endTime: DateTime.now().add(const Duration(days: 3, hours: 2)),
      genre: '보컬재즈',
      capacity: 60,
      currentBookings: 55,
      price: 38000,
      tags: ['보컬재즈', '강남', '로맨틱', '라이브'],
      status: PerformanceStatus.upcoming,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),

    // Soul Live 공연들
    PerformanceModel(
      id: '5',
      title: 'Soul & Jazz Fusion',
      description: '소울과 재즈의 만남',
      artistId: 'artist5',
      artistName: 'Soul Brothers',
      venueId: 'venue5',
      venueName: 'Soul Live',
      venueAddress: '서울 용산구 이태원로',
      latitude: 37.5420,
      longitude: 126.9947,
      startTime: DateTime.now().add(const Duration(days: 4)),
      endTime: DateTime.now().add(const Duration(days: 4, hours: 2)),
      genre: '소울재즈',
      capacity: 70,
      currentBookings: 28,
      price: 32000,
      tags: ['소울', '재즈', '이태원', '펑키'],
      status: PerformanceStatus.upcoming,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),

    // Once in a Blue Moon 공연들
    PerformanceModel(
      id: '6',
      title: 'Traditional Jazz Revival',
      description: '전통 재즈의 부활',
      artistId: 'artist6',
      artistName: 'Jongro Traditional Jazz Band',
      venueId: 'venue6',
      venueName: 'Once in a Blue Moon',
      venueAddress: '서울 종로구 인사동',
      latitude: 37.5735,
      longitude: 126.9788,
      startTime: DateTime.now().add(const Duration(days: 5)),
      endTime: DateTime.now().add(const Duration(days: 5, hours: 2)),
      genre: '전통재즈',
      capacity: 40,
      currentBookings: 38,
      price: 30000,
      tags: ['전통재즈', '종로', '클래식', '인사동'],
      status: PerformanceStatus.upcoming,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _getCurrentLocation();
    _loadPerformances();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        _currentPosition = await Geolocator.getCurrentPosition();
        setState(() {
          _currentLatitude = _currentPosition!.latitude;
          _currentLongitude = _currentPosition!.longitude;
        });
      }
    } catch (e) {
      debugPrint('위치 정보를 가져올 수 없습니다: $e');
    }
  }

  void _loadPerformances() {
    _performances =
        _dummyPerformances
            .where(
              (performance) =>
                  _selectedGenre == '전체' || performance.genre == _selectedGenre,
            )
            .toList();
  }

  List<MapMarker> _createMarkers() {
    List<MapMarker> markers = [];

    for (var performance in _performances) {
      markers.add(
        MapMarker(
          title: performance.title,
          latitude: performance.latitude,
          longitude: performance.longitude,
        ),
      );
    }

    // 현재 위치 마커 추가
    if (_currentPosition != null) {
      markers.add(
        MapMarker(
          title: '현재 위치',
          latitude: _currentPosition!.latitude,
          longitude: _currentPosition!.longitude,
        ),
      );
    }

    return markers;
  }

  void _showPerformanceDetails(PerformanceModel performance) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => PerformanceDetailBottomSheet(performance: performance),
    );
  }

  void _onGenreChanged(String genre) {
    setState(() {
      _selectedGenre = genre;
      _isLoading = true;
    });
    _loadPerformances();
    setState(() {
      _isLoading = false;
    });
  }

  void _onMarkerClick(Map<String, dynamic> data) {
    String performanceId = data['id'];
    PerformanceModel performance = _performances.firstWhere(
      (p) => p.id == performanceId,
      orElse: () => _performances.first,
    );
    _showPerformanceDetails(performance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CommonSliverAppBar(
            title: '공연 지도',
            centerIcon: Icons.map,
            expandedHeight: 120,
            showSearch: true,
            onSearchPressed: () {
              // 검색 기능 구현
            },
          ),
          SliverFillRemaining(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                      children: [
                        // 카카오맵
                        KakaoMapWidget(
                          latitude: _currentLatitude,
                          longitude: _currentLongitude,
                          markers: _createMarkers(),
                          expanded: true,
                        ),

                        // 상단 필터 바
                        Positioned(
                          top: 16,
                          left: 16,
                          right: 16,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.shadowLight,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // 장르 필터
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      children:
                                          ['전체', '재즈', '인디', '버스킹', '클래식']
                                              .map(
                                                (genre) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 8,
                                                      ),
                                                  child: FilterChip(
                                                    label: Text(genre),
                                                    selected:
                                                        _selectedGenre == genre,
                                                    onSelected: (selected) {
                                                      if (selected) {
                                                        _onGenreChanged(genre);
                                                      }
                                                    },
                                                    selectedColor: AppColors
                                                        .primary
                                                        .withValues(alpha: 0.2),
                                                    checkmarkColor:
                                                        AppColors.primary,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                ),

                                // 검색 버튼
                                IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    // 검색 기능 구현
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
