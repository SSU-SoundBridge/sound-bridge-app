import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MapMarker {
  const MapMarker({
    required this.latitude,
    required this.longitude,
    required this.title,
  });

  final double latitude;
  final double longitude;
  final String title;
}

class KakaoMapWidget extends StatefulWidget {
  const KakaoMapWidget({
    super.key,
    this.latitude,
    this.longitude,
    this.markers,
    this.onMapClick,
    this.height,
    this.expanded = false,
  });

  final double? latitude;
  final double? longitude;
  final List<MapMarker>? markers;
  final Function(double lat, double lng)? onMapClick;
  final double? height; // nullable로 변경
  final bool expanded; // 전체 공간을 채울지 여부

  @override
  State<KakaoMapWidget> createState() => _KakaoMapWidgetState();
}

class _KakaoMapWidgetState extends State<KakaoMapWidget> {
  List<Marker> _markersList = [];

  @override
  void initState() {
    super.initState();
    _setupMarkers();
  }

  void _setupMarkers() {
    if (widget.markers != null) {
      _markersList =
          widget.markers!.map((marker) {
            return Marker(
              markerId: marker.title,
              latLng: LatLng(marker.latitude, marker.longitude),
              width: 30,
              height: 44,
            );
          }).toList();
    }
  }

  Widget _buildMap() {
    var lat = widget.latitude ?? 37.5665;
    var lng = widget.longitude ?? 126.9780;

    return KakaoMap(
      onMapCreated: (controller) {
        // _controller는 사용되지 않으므로 할당하지 않음
      },
      center: LatLng(lat, lng),
      markers: _markersList,
      onMapTap: (latLng) {
        if (widget.onMapClick != null) {
          widget.onMapClick!(latLng.latitude, latLng.longitude);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // expanded가 true이거나 height가 지정되지 않은 경우 전체 공간 사용
    if (widget.expanded || widget.height == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _buildMap(),
      );
    }

    // height가 지정된 경우 Container 사용
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _buildMap(),
      ),
    );
  }
}
