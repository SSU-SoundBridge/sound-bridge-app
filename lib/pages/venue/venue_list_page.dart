import 'package:flutter/material.dart';
import 'package:sound_bridge_app/features/venue/widgets/venue_card.dart';
import 'package:sound_bridge_app/models/venue_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_sliver_app_bar.dart';

class VenueListPage extends StatefulWidget {
  const VenueListPage({super.key});

  @override
  State<VenueListPage> createState() => _VenueListPageState();
}

class _VenueListPageState extends State<VenueListPage> {
  List<VenueModel> _venues = [];
  List<VenueModel> _filteredVenues = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedCategory = 'all';
  String _selectedSort = 'name';

  // 더미 데이터
  final List<VenueModel> _dummyVenues = [
    VenueModel(
      id: '1',
      name: '홍대 재즈바',
      address: '서울 마포구 홍대입구역 근처',
      latitude: 37.5563,
      longitude: 126.9236,
      type: VenueType.jazzBar,
      capacity: 50,
      description: '홍대 최고의 재즈바로 유명합니다. 아늑한 분위기와 뛰어난 음향시설로 최고의 공연을 즐길 수 있습니다.',
      phoneNumber: '02-1234-5678',
      website: 'https://hongdaejazzbar.com',
      instagramUrl: '@hongdae_jazz_bar',
      facebookUrl: 'HongdaeJazzBar',
      operatingHours: {
        'monday': '19:00-02:00',
        'tuesday': '19:00-02:00',
        'wednesday': '19:00-02:00',
        'thursday': '19:00-02:00',
        'friday': '19:00-03:00',
        'saturday': '19:00-03:00',
        'sunday': '19:00-01:00',
      },
      genres: ['재즈', '블루스', '퓨전'],
      amenities: ['음향시설', '조명', '무대', '주차장', '화장실'],
      imageUrls: ['https://example.com/venue1.jpg'],
      rating: 4.5,
      reviewCount: 234,
      isOpen: true,
      isVerified: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    VenueModel(
      id: '2',
      name: '강남 클럽',
      address: '서울 강남구 강남역 근처',
      latitude: 37.4979,
      longitude: 127.0276,
      type: VenueType.club,
      capacity: 200,
      description: '강남 최대 규모의 클럽으로 다양한 장르의 공연이 열립니다.',
      phoneNumber: '02-5678-9012',
      website: 'https://gangnamclub.com',
      instagramUrl: '@gangnam_club',
      facebookUrl: 'GangnamClub',
      operatingHours: {
        'monday': '18:00-03:00',
        'tuesday': '18:00-03:00',
        'wednesday': '18:00-03:00',
        'thursday': '18:00-03:00',
        'friday': '18:00-04:00',
        'saturday': '18:00-04:00',
        'sunday': '18:00-02:00',
      },
      genres: ['EDM', '힙합', '록'],
      amenities: ['음향시설', '조명', '무대', '주차장', '화장실', '바', '댄스플로어'],
      imageUrls: ['https://example.com/venue2.jpg'],
      rating: 4.2,
      reviewCount: 156,
      isOpen: true,
      isVerified: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    VenueModel(
      id: '3',
      name: '세종문화회관',
      address: '서울 중구 세종대로 175',
      latitude: 37.5720,
      longitude: 126.9762,
      type: VenueType.theater,
      capacity: 3000,
      description: '한국 최고의 문화 공연장으로 다양한 클래식과 전통 공연이 열립니다.',
      phoneNumber: '02-399-1000',
      website: 'https://sejongpac.or.kr',
      instagramUrl: '@sejongpac',
      facebookUrl: 'SejongPAC',
      operatingHours: {
        'monday': '09:00-22:00',
        'tuesday': '09:00-22:00',
        'wednesday': '09:00-22:00',
        'thursday': '09:00-22:00',
        'friday': '09:00-22:00',
        'saturday': '09:00-22:00',
        'sunday': '09:00-22:00',
      },
      genres: ['클래식', '오페라', '발레'],
      amenities: ['음향시설', '조명', '무대', '주차장', '화장실', '카페', '기념품샵'],
      imageUrls: ['https://example.com/venue3.jpg'],
      rating: 4.8,
      reviewCount: 892,
      isOpen: true,
      isVerified: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadVenues();
  }

  Future<void> _loadVenues() async {
    setState(() {
      _isLoading = true;
    });

    // 실제 앱에서는 API 호출
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _venues = _dummyVenues;
      _filteredVenues = _venues;
      _isLoading = false;
    });
  }

  void _filterVenues() {
    setState(() {
      _filteredVenues =
          _venues.where((venue) {
            var matchesSearch =
                venue.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                venue.address.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                );

            var matchesCategory =
                _selectedCategory == 'all' ||
                venue.type.toString().split('.').last == _selectedCategory;

            return matchesSearch && matchesCategory;
          }).toList();

      _sortVenues();
    });
  }

  void _sortVenues() {
    switch (_selectedSort) {
      case 'rating':
        _filteredVenues.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'reviews':
        _filteredVenues.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
      case 'name':
      default:
        _filteredVenues.sort((a, b) => a.name.compareTo(b.name));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CommonSliverAppBar(
            title: '공연장 목록',
            centerIcon: Icons.location_city,
            expandedHeight: 200,
            showSearch: true,
            onSearchPressed: () {
              // 검색 기능 구현
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.primary,
              child: Column(
                children: [
                  // 검색바
                  TextField(
                    decoration: InputDecoration(
                      hintText: '공연장 이름 또는 주소를 검색하세요',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                      _filterVenues();
                    },
                  ),
                  const SizedBox(height: 12),

                  // 필터 바
                  Row(
                    children: [
                      // 카테고리 필터
                      Expanded(
                        child: DropdownButton<String>(
                          value: _selectedCategory,
                          isExpanded: true,
                          style: const TextStyle(
                            color: AppColors.textOnPrimary,
                          ),
                          dropdownColor: AppColors.primary,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                            _filterVenues();
                          },
                          items: const [
                            DropdownMenuItem(
                              value: 'all',
                              child: Text('모든 카테고리'),
                            ),
                            DropdownMenuItem(
                              value: 'jazzBar',
                              child: Text('재즈바'),
                            ),
                            DropdownMenuItem(value: 'club', child: Text('클럽')),
                            DropdownMenuItem(
                              value: 'theater',
                              child: Text('극장'),
                            ),
                            DropdownMenuItem(
                              value: 'liveHouse',
                              child: Text('라이브하우스'),
                            ),
                            DropdownMenuItem(value: 'cafe', child: Text('카페')),
                            DropdownMenuItem(
                              value: 'outdoor',
                              child: Text('야외'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),

                      // 정렬 옵션
                      DropdownButton<String>(
                        value: _selectedSort,
                        style: const TextStyle(color: AppColors.textOnPrimary),
                        dropdownColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() {
                            _selectedSort = value!;
                          });
                          _filterVenues();
                        },
                        items: const [
                          DropdownMenuItem(value: 'name', child: Text('이름순')),
                          DropdownMenuItem(value: 'rating', child: Text('평점순')),
                          DropdownMenuItem(
                            value: 'reviews',
                            child: Text('리뷰순'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _isLoading
              ? const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
              : _filteredVenues.isEmpty
              ? const SliverFillRemaining(
                child: Center(
                  child: Text(
                    '검색 결과가 없습니다.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              )
              : SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  var venue = _filteredVenues[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      16,
                      index == _filteredVenues.length - 1 ? 16 : 8,
                    ),
                    child: VenueCard(venue: venue),
                  );
                }, childCount: _filteredVenues.length),
              ),
        ],
      ),
    );
  }
}
