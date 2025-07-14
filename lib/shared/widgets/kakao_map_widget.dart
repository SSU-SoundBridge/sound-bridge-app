import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class KakaoMapWidget extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final List<MapMarker>? markers;
  final Function(double lat, double lng)? onMapClick;
  final double? height; // nullable로 변경
  final bool expanded; // 전체 공간을 채울지 여부

  const KakaoMapWidget({
    super.key,
    this.latitude,
    this.longitude,
    this.markers,
    this.onMapClick,
    this.height,
    this.expanded = false,
  });

  @override
  State<KakaoMapWidget> createState() => _KakaoMapWidgetState();
}

class _KakaoMapWidgetState extends State<KakaoMapWidget> {
  late KakaoMapController _controller;
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
    final lat = widget.latitude ?? 37.5665;
    final lng = widget.longitude ?? 126.9780;

    return KakaoMap(
      onMapCreated: (KakaoMapController controller) {
        _controller = controller;
      },
      center: LatLng(lat, lng),
      markers: _markersList,
      onMapTap: (LatLng latLng) {
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
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _buildMap(),
      ),
    );
  }
}

class MapMarker {
  final double latitude;
  final double longitude;
  final String title;

  const MapMarker({
    required this.latitude,
    required this.longitude,
    required this.title,
  });
}
