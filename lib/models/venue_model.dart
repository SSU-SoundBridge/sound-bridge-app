import 'package:intl/intl.dart';

class VenueModel {
  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      address: json['address'] as String,
      detailAddress: json['detail_address'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      phoneNumber: json['phone_number'] as String?,
      website: json['website'] as String?,
      instagramUrl: json['instagram_url'] as String?,
      facebookUrl: json['facebook_url'] as String?,
      imageUrls: List<String>.from(json['image_urls'] as List),
      capacity: json['capacity'] as int,
      type: VenueType.fromString(json['type'] as String),
      genres: List<String>.from(json['genres'] as List),
      amenities: List<String>.from(json['amenities'] as List),
      operatingHours: Map<String, String>.from(json['operating_hours'] as Map),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['review_count'] as int,
      isOpen: json['is_open'] as bool,
      isVerified: json['is_verified'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  VenueModel({
    required this.id,
    required this.name,
    this.description,
    required this.address,
    this.detailAddress,
    required this.latitude,
    required this.longitude,
    this.phoneNumber,
    this.website,
    this.instagramUrl,
    this.facebookUrl,
    required this.imageUrls,
    required this.capacity,
    required this.type,
    required this.genres,
    required this.amenities,
    required this.operatingHours,
    required this.rating,
    required this.reviewCount,
    required this.isOpen,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String? description;
  final String address;
  final String? detailAddress;
  final double latitude;
  final double longitude;
  final String? phoneNumber;
  final String? website;
  final String? instagramUrl;
  final String? facebookUrl;
  final List<String> imageUrls;
  final int capacity;
  final VenueType type;
  final List<String> genres;
  final List<String> amenities;
  final Map<String, String> operatingHours;
  final double rating;
  final int reviewCount;
  final bool isOpen;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'detail_address': detailAddress,
      'latitude': latitude,
      'longitude': longitude,
      'phone_number': phoneNumber,
      'website': website,
      'instagram_url': instagramUrl,
      'facebook_url': facebookUrl,
      'image_urls': imageUrls,
      'capacity': capacity,
      'type': type.toString(),
      'genres': genres,
      'amenities': amenities,
      'operating_hours': operatingHours,
      'rating': rating,
      'review_count': reviewCount,
      'is_open': isOpen,
      'is_verified': isVerified,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get fullAddress =>
      detailAddress != null ? '$address $detailAddress' : address;
  String get genreText => genres.join(', ');
  String get amenityText => amenities.join(', ');
  String get ratingText => rating.toStringAsFixed(1);
  String get capacityText => '$capacity명';

  bool get hasContact => phoneNumber != null;
  bool get hasSocialMedia => instagramUrl != null || facebookUrl != null;

  String? get todayOperatingHours {
    String today = DateFormat('EEEE').format(DateTime.now()).toLowerCase();
    return operatingHours[today];
  }

  bool get isOpenToday {
    String? todayHours = todayOperatingHours;
    if (todayHours == null || todayHours.isEmpty) return false;

    DateTime now = DateTime.now();
    DateFormat timeFormat = DateFormat('HH:mm');

    try {
      List<String> parts = todayHours.split('-');
      if (parts.length != 2) return false;

      DateTime openTime = timeFormat.parse(parts[0].trim());
      DateTime closeTime = timeFormat.parse(parts[1].trim());
      DateTime currentTime = timeFormat.parse(DateFormat('HH:mm').format(now));

      return currentTime.isAfter(openTime) && currentTime.isBefore(closeTime);
    } catch (e) {
      return false;
    }
  }

  VenueModel copyWith({
    String? id,
    String? name,
    String? description,
    String? address,
    String? detailAddress,
    double? latitude,
    double? longitude,
    String? phoneNumber,
    String? website,
    String? instagramUrl,
    String? facebookUrl,
    List<String>? imageUrls,
    int? capacity,
    VenueType? type,
    List<String>? genres,
    List<String>? amenities,
    Map<String, String>? operatingHours,
    double? rating,
    int? reviewCount,
    bool? isOpen,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VenueModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      detailAddress: detailAddress ?? this.detailAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      website: website ?? this.website,
      instagramUrl: instagramUrl ?? this.instagramUrl,
      facebookUrl: facebookUrl ?? this.facebookUrl,
      imageUrls: imageUrls ?? this.imageUrls,
      capacity: capacity ?? this.capacity,
      type: type ?? this.type,
      genres: genres ?? this.genres,
      amenities: amenities ?? this.amenities,
      operatingHours: operatingHours ?? this.operatingHours,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isOpen: isOpen ?? this.isOpen,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

enum VenueType {
  jazzBar,
  liveHouse,
  cafe,
  club,
  outdoor,
  theater,
  other;

  static VenueType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'jazzbar':
        return VenueType.jazzBar;
      case 'livehouse':
        return VenueType.liveHouse;
      case 'cafe':
        return VenueType.cafe;
      case 'club':
        return VenueType.club;
      case 'outdoor':
        return VenueType.outdoor;
      case 'theater':
        return VenueType.theater;
      default:
        return VenueType.other;
    }
  }

  String get displayName {
    switch (this) {
      case VenueType.jazzBar:
        return '재즈바';
      case VenueType.liveHouse:
        return '라이브하우스';
      case VenueType.cafe:
        return '카페';
      case VenueType.club:
        return '클럽';
      case VenueType.outdoor:
        return '야외';
      case VenueType.theater:
        return '극장';
      case VenueType.other:
        return '기타';
    }
  }
}

class VenueReviewModel {
  factory VenueReviewModel.fromJson(Map<String, dynamic> json) {
    return VenueReviewModel(
      id: json['id'] as String,
      venueId: json['venue_id'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      userProfileImageUrl: json['user_profile_image_url'] as String?,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      imageUrls: List<String>.from(json['image_urls'] as List),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  VenueReviewModel({
    required this.id,
    required this.venueId,
    required this.userId,
    required this.userName,
    this.userProfileImageUrl,
    required this.rating,
    required this.comment,
    required this.imageUrls,
    required this.createdAt,
  });

  final String id;
  final String venueId;
  final String userId;
  final String userName;
  final String? userProfileImageUrl;
  final double rating;
  final String comment;
  final List<String> imageUrls;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venue_id': venueId,
      'user_id': userId,
      'user_name': userName,
      'user_profile_image_url': userProfileImageUrl,
      'rating': rating,
      'comment': comment,
      'image_urls': imageUrls,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get ratingText => rating.toStringAsFixed(1);
  String get timeAgo {
    DateTime now = DateTime.now();
    Duration difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}

class VenueBookingModel {
  factory VenueBookingModel.fromJson(Map<String, dynamic> json) {
    return VenueBookingModel(
      id: json['id'] as String,
      venueId: json['venue_id'] as String,
      userId: json['user_id'] as String,
      performanceId: json['performance_id'] as String,
      bookingDate: DateTime.parse(json['booking_date'] as String),
      numberOfGuests: json['number_of_guests'] as int,
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: BookingStatus.fromString(json['status'] as String),
      specialRequests: json['special_requests'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  VenueBookingModel({
    required this.id,
    required this.venueId,
    required this.userId,
    required this.performanceId,
    required this.bookingDate,
    required this.numberOfGuests,
    required this.totalAmount,
    required this.status,
    this.specialRequests,
    required this.createdAt,
  });

  final String id;
  final String venueId;
  final String userId;
  final String performanceId;
  final DateTime bookingDate;
  final int numberOfGuests;
  final double totalAmount;
  final BookingStatus status;
  final String? specialRequests;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venue_id': venueId,
      'user_id': userId,
      'performance_id': performanceId,
      'booking_date': bookingDate.toIso8601String(),
      'number_of_guests': numberOfGuests,
      'total_amount': totalAmount,
      'status': status.toString(),
      'special_requests': specialRequests,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get formattedAmount => '${NumberFormat('#,###').format(totalAmount)}원';
  String get formattedDate => DateFormat('yyyy.MM.dd').format(bookingDate);
}

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed;

  static BookingStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return BookingStatus.pending;
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'cancelled':
        return BookingStatus.cancelled;
      case 'completed':
        return BookingStatus.completed;
      default:
        return BookingStatus.pending;
    }
  }

  String get displayName {
    switch (this) {
      case BookingStatus.pending:
        return '대기중';
      case BookingStatus.confirmed:
        return '확정';
      case BookingStatus.cancelled:
        return '취소';
      case BookingStatus.completed:
        return '완료';
    }
  }
}
