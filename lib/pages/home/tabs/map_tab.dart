import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_sliver_app_bar.dart';
import 'package:sound_bridge_app/shared/widgets/kakao_map_widget.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  bool _showLocationList = false; // 위치 목록 표시 여부

  List<MapMarker> _createJazzVenueMarkers() {
    return [
      // 홍대 재즈바들
      const MapMarker(
        title: 'All That Jazz',
        latitude: 37.5563,
        longitude: 126.9236,
      ),
      const MapMarker(
        title: 'Club Evans',
        latitude: 37.5580,
        longitude: 126.9244,
      ),
      const MapMarker(title: 'Dixie', latitude: 37.5565, longitude: 126.9250),

      // 강남 재즈바들
      const MapMarker(
        title: 'Jazz Story',
        latitude: 37.4979,
        longitude: 127.0276,
      ),
      const MapMarker(
        title: 'Moonnight Jazz Bar',
        latitude: 37.5110,
        longitude: 127.0590,
      ),

      // 한남/이태원 재즈바들
      const MapMarker(
        title: 'Blue Note Seoul',
        latitude: 37.5349,
        longitude: 126.9947,
      ),
      const MapMarker(
        title: 'Soul Live',
        latitude: 37.5420,
        longitude: 126.9947,
      ),

      // 신촌 라이브 하우스
      const MapMarker(
        title: 'Live House',
        latitude: 37.5598,
        longitude: 126.9426,
      ),

      // 종로 재즈바
      const MapMarker(
        title: 'Once in a Blue Moon',
        latitude: 37.5735,
        longitude: 126.9788,
      ),

      // 압구정 재즈클럽
      const MapMarker(
        title: 'Smooth Jazz Lounge',
        latitude: 37.5270,
        longitude: 127.0380,
      ),
    ];
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
            customActions: [
              IconButton(
                onPressed: () {
                  // 필터 기능 구현
                },
                icon: const Icon(Icons.filter_list),
              ),
              IconButton(
                onPressed: () {
                  // 현재 위치 기능 구현
                },
                icon: const Icon(Icons.my_location),
              ),
            ],
          ),
          SliverFillRemaining(
            child: Stack(
              children: [
                // 카카오맵
                KakaoMapWidget(
                  latitude: 37.5665,
                  longitude: 126.9780,
                  markers: _createJazzVenueMarkers(),
                  expanded: true,
                ),

                // 위치 목록 토글 버튼
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _showLocationList = !_showLocationList;
                      });
                    },
                    backgroundColor: AppColors.primary,
                    child: Icon(
                      _showLocationList ? Icons.close : Icons.list,
                      color: Colors.white,
                    ),
                  ),
                ),

                // 하단 위치 목록 (조건부 표시)
                if (_showLocationList)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowMedium,
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showLocationList = false;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Container(
                                  width: 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey300,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return _buildPerformanceItem(index);
                              },
                            ),
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

  Widget _buildPerformanceItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.music_note,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '재즈 공연 ${index + 1}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '홍대 재즈바 • 500m',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '오늘 20:00',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.grey400),
        ],
      ),
    );
  }
}
