import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sound_bridge_app/features/performance/widgets/performance_detail_bottom_sheet.dart';
import 'package:sound_bridge_app/models/performance_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_sliver_app_bar.dart';

class PerformanceMapPage extends StatefulWidget {
  const PerformanceMapPage({super.key});

  @override
  State<PerformanceMapPage> createState() => _PerformanceMapPageState();
}

class _PerformanceMapPageState extends State<PerformanceMapPage> {
  final Set<Marker> _markers = {};
  Position? _currentPosition;
  List<PerformanceModel> _performances = [];
  String _selectedGenre = '전체';
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  // 더미 데이터 - 실제 앱에서는 API에서 가져옴
  final List<PerformanceModel> _dummyPerformances = [
    PerformanceModel(
      id: '1',
      title: '재즈 나이트',
      description: '홍대 재즈바에서 열리는 재즈 공연',
      artistId: 'artist1',
      artistName: '재즈 앙상블',
      venueId: 'venue1',
      venueName: '홍대 재즈바',
      venueAddress: '서울 마포구 홍대입구역 근처',
      latitude: 37.5563,
      longitude: 126.9236,
      startTime: DateTime.now().add(const Duration(days: 1)),
      endTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
      genre: '재즈',
      capacity: 50,
      currentBookings: 23,
      price: 25000,
      tags: ['재즈', '라이브', '홍대'],
      status: PerformanceStatus.upcoming,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    PerformanceModel(
      id: '2',
      title: '인디 공연',
      description: '강남 클럽에서 열리는 인디 공연',
      artistId: 'artist2',
      artistName: '인디 밴드',
      venueId: 'venue2',
      venueName: '강남 클럽',
      venueAddress: '서울 강남구 강남역 근처',
      latitude: 37.4979,
      longitude: 127.0276,
      startTime: DateTime.now().add(const Duration(days: 2)),
      endTime: DateTime.now().add(const Duration(days: 2, hours: 3)),
      genre: '인디',
      capacity: 100,
      currentBookings: 78,
      price: 30000,
      tags: ['인디', '밴드', '강남'],
      status: PerformanceStatus.upcoming,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    PerformanceModel(
      id: '3',
      title: '버스킹 공연',
      description: '이태원 거리 버스킹 공연',
      artistId: 'artist3',
      artistName: '버스킹 듀오',
      venueId: 'venue3',
      venueName: '이태원 거리',
      venueAddress: '서울 용산구 이태원로',
      latitude: 37.5349,
      longitude: 126.9947,
      startTime: DateTime.now().add(const Duration(hours: 3)),
      endTime: DateTime.now().add(const Duration(hours: 5)),
      genre: '버스킹',
      capacity: 200,
      currentBookings: 0,
      price: 0,
      tags: ['버스킹', '무료', '이태원'],
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
    _createMarkers();
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

  void _createMarkers() {
    _markers.clear();

    for (var performance in _performances) {
      _markers.add(
        Marker(
          markerId: MarkerId(performance.id),
          position: LatLng(performance.latitude, performance.longitude),
          infoWindow: InfoWindow(
            title: performance.title,
            snippet: performance.venueName,
            onTap: () => _showPerformanceDetails(performance),
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            _getMarkerColor(performance.genre),
          ),
        ),
      );
    }

    // 현재 위치 마커 추가
    if (_currentPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          infoWindow: const InfoWindow(title: '현재 위치'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
  }

  double _getMarkerColor(String genre) {
    switch (genre) {
      case '재즈':
        return BitmapDescriptor.hueRed;
      case '인디':
        return BitmapDescriptor.hueGreen;
      case '버스킹':
        return BitmapDescriptor.hueOrange;
      default:
        return BitmapDescriptor.hueRed;
    }
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
    _createMarkers();
    setState(() {
      _isLoading = false;
    });
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
                        // 지도
                        GoogleMap(
                          onMapCreated: (controller) {
                            // 지도 초기화
                          },
                          initialCameraPosition: CameraPosition(
                            target:
                                _currentPosition != null
                                    ? LatLng(
                                      _currentPosition!.latitude,
                                      _currentPosition!.longitude,
                                    )
                                    : const LatLng(37.5665, 126.9780), // 서울 중심
                            zoom: 12,
                          ),
                          markers: _markers,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: true,
                          compassEnabled: true,
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
