import 'package:intl/intl.dart';

class PerformanceModel {
  factory PerformanceModel.fromJson(Map<String, dynamic> json) {
    return PerformanceModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      artistId: json['artist_id'] as String,
      artistName: json['artist_name'] as String,
      venueId: json['venue_id'] as String,
      venueName: json['venue_name'] as String,
      venueAddress: json['venue_address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      genre: json['genre'] as String,
      capacity: json['capacity'] as int,
      currentBookings: json['current_bookings'] as int,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      tags: List<String>.from(json['tags'] as List),
      status: PerformanceStatus.fromString(json['status'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  PerformanceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.artistId,
    required this.artistName,
    required this.venueId,
    required this.venueName,
    required this.venueAddress,
    required this.latitude,
    required this.longitude,
    required this.startTime,
    required this.endTime,
    required this.genre,
    required this.capacity,
    required this.currentBookings,
    required this.price,
    this.imageUrl,
    this.videoUrl,
    required this.tags,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String description;
  final String artistId;
  final String artistName;
  final String venueId;
  final String venueName;
  final String venueAddress;
  final double latitude;
  final double longitude;
  final DateTime startTime;
  final DateTime endTime;
  final String genre;
  final int capacity;
  final int currentBookings;
  final double price;
  final String? imageUrl;
  final String? videoUrl;
  final List<String> tags;
  final PerformanceStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'artist_id': artistId,
      'artist_name': artistName,
      'venue_id': venueId,
      'venue_name': venueName,
      'venue_address': venueAddress,
      'latitude': latitude,
      'longitude': longitude,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'genre': genre,
      'capacity': capacity,
      'current_bookings': currentBookings,
      'price': price,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'tags': tags,
      'status': status.toString(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get formattedDate => DateFormat('yyyy.MM.dd').format(startTime);
  String get formattedTime => DateFormat('HH:mm').format(startTime);
  String get formattedDatetime =>
      DateFormat('yyyy.MM.dd HH:mm').format(startTime);
  String get formattedPrice => '${NumberFormat('#,###').format(price)}원';

  bool get isBookingFull => currentBookings >= capacity;
  bool get isUpcoming => startTime.isAfter(DateTime.now());
  bool get isOngoing =>
      DateTime.now().isAfter(startTime) && DateTime.now().isBefore(endTime);
  bool get isCompleted => DateTime.now().isAfter(endTime);

  int get availableSeats => capacity - currentBookings;
  double get bookingRate => currentBookings / capacity;

  Duration get duration => endTime.difference(startTime);
  String get durationText {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return '$hours시간 $minutes분';
    }
    return '$minutes분';
  }

  PerformanceModel copyWith({
    String? id,
    String? title,
    String? description,
    String? artistId,
    String? artistName,
    String? venueId,
    String? venueName,
    String? venueAddress,
    double? latitude,
    double? longitude,
    DateTime? startTime,
    DateTime? endTime,
    String? genre,
    int? capacity,
    int? currentBookings,
    double? price,
    String? imageUrl,
    String? videoUrl,
    List<String>? tags,
    PerformanceStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PerformanceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      artistId: artistId ?? this.artistId,
      artistName: artistName ?? this.artistName,
      venueId: venueId ?? this.venueId,
      venueName: venueName ?? this.venueName,
      venueAddress: venueAddress ?? this.venueAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      genre: genre ?? this.genre,
      capacity: capacity ?? this.capacity,
      currentBookings: currentBookings ?? this.currentBookings,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      tags: tags ?? this.tags,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

enum PerformanceStatus {
  upcoming,
  ongoing,
  completed,
  cancelled,
  soldOut;

  static PerformanceStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'upcoming':
        return PerformanceStatus.upcoming;
      case 'ongoing':
        return PerformanceStatus.ongoing;
      case 'completed':
        return PerformanceStatus.completed;
      case 'cancelled':
        return PerformanceStatus.cancelled;
      case 'soldout':
        return PerformanceStatus.soldOut;
      default:
        return PerformanceStatus.upcoming;
    }
  }

  String get displayName {
    switch (this) {
      case PerformanceStatus.upcoming:
        return '예정';
      case PerformanceStatus.ongoing:
        return '진행중';
      case PerformanceStatus.completed:
        return '완료';
      case PerformanceStatus.cancelled:
        return '취소';
      case PerformanceStatus.soldOut:
        return '매진';
    }
  }
}

enum PerformanceGenre {
  jazz,
  indie,
  busking,
  classical,
  hiphop,
  rock,
  folk,
  electronic,
  other;

  static PerformanceGenre fromString(String value) {
    switch (value.toLowerCase()) {
      case 'jazz':
        return PerformanceGenre.jazz;
      case 'indie':
        return PerformanceGenre.indie;
      case 'busking':
        return PerformanceGenre.busking;
      case 'classical':
        return PerformanceGenre.classical;
      case 'hiphop':
        return PerformanceGenre.hiphop;
      case 'rock':
        return PerformanceGenre.rock;
      case 'folk':
        return PerformanceGenre.folk;
      case 'electronic':
        return PerformanceGenre.electronic;
      default:
        return PerformanceGenre.other;
    }
  }

  String get displayName {
    switch (this) {
      case PerformanceGenre.jazz:
        return '재즈';
      case PerformanceGenre.indie:
        return '인디';
      case PerformanceGenre.busking:
        return '버스킹';
      case PerformanceGenre.classical:
        return '클래식';
      case PerformanceGenre.hiphop:
        return '힙합';
      case PerformanceGenre.rock:
        return '록';
      case PerformanceGenre.folk:
        return '포크';
      case PerformanceGenre.electronic:
        return '일렉트로닉';
      case PerformanceGenre.other:
        return '기타';
    }
  }
}
