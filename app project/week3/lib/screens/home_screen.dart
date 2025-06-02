import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final void Function(bool)? onThemeChanged;
  HomeScreen({this.onThemeChanged});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _excludedKeywords = []; // ← 필터 키워드 리스트
  List<Map<String, String>> allNews = [];
  List<Map<String, String>> filteredNews = [];
  DateTime? _lastUpdated;

  String _selectedTopic = '전체';
  String _selectedPeriod = '3일';

  @override
  void initState() {
    super.initState();
    _loadSettingsAndNews();
  }

  Future<void> _loadSettingsAndNews() async {
    final prefs = await SharedPreferences.getInstance();
    _excludedKeywords = prefs.getStringList('excludeKeywords') ?? [];
    _selectedTopic = prefs.getString('newsTopic') ?? '전체';
    _selectedPeriod = prefs.getString('newsPeriod') ?? '3일';

    // 뉴스 더미 데이터 (topic, date 추가됨)
    allNews = [
      {
        'title': '경제 뉴스',
        'summary': '경제에 대한 요약입니다. 시장이 상승했습니다.',
        'full': '전체 경제 기사 내용',
        'topic': '경제',
        'date': '2025-05-25',
      },
      {
        'title': '정치 뉴스',
        'summary': '정치적 긴장 상황 요약입니다.',
        'full': '전체 정치 기사 내용',
        'topic': '정치',
        'date': '2025-05-24',
      },
      {
        'title': '사회 뉴스',
        'summary': '사회 이슈에 대한 뉴스입니다.',
        'full': '전체 사회 기사 내용',
        'topic': '사회',
        'date': '2025-05-22',
      },
      {
        'title': '스포츠 뉴스',
        'summary': '어제 축구 경기 결과입니다.',
        'full': '전체 스포츠 기사 내용',
        'topic': '스포츠',
        'date': '2025-05-26',
      },
    ];
    _filterNews();
  }

  void _filterNews() {
    DateTime now = DateTime.now();
    int days = int.tryParse(_selectedPeriod) ?? 3;

    DateTime minDate = now.subtract(Duration(days: days));

    setState(() {
      filteredNews = allNews.where((news) {
        final topic = news['topic'] ?? '';
        final title = news['title'] ?? '';
        final summary = news['summary'] ?? '';
        final dateStr = news['date'] ?? '';
        final newsDate = DateTime.tryParse(dateStr) ?? now;

        // ❗ 필터 적용 조건 (기본값이면 무시)
        final isTopicActive = _selectedTopic != '전체';
        final isKeywordActive = _excludedKeywords.isNotEmpty;
        final isPeriodActive = _selectedPeriod != '7일';

        bool topicMatch = !isTopicActive || topic == _selectedTopic;
        bool keywordOk = !isKeywordActive || !_excludedKeywords.any((kw) =>
        title.toLowerCase().contains(kw.toLowerCase()) ||
            summary.toLowerCase().contains(kw.toLowerCase()));
        bool inDateRange = !isPeriodActive || newsDate.isAfter(minDate);

        return topicMatch && keywordOk && inDateRange;
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: filteredNews.length,
        itemBuilder: (context, index) {
          final news = filteredNews[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news['title']!,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text(news['summary']!,
                      maxLines: 4, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13)),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(content: news['full']!),
                          ),
                        );
                      },
                      child: Text('전체 보기'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildBottomButton(
              icon: Icons.settings,
              label: '설정',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(onThemeChanged: widget.onThemeChanged!),
                  ),
                ).then((_) {
                  _loadSettingsAndNews();
                });
              },
            ),

            // ✅ 버튼 사이에 구분선 추가
            Container(
              width: 1,
              height: 40,
              color: Colors.grey[300],
            ),

            _buildBottomButton(
              icon: Icons.refresh,
              label: '갱신',
              onTap: () {
                setState(() {
                  _lastUpdated = DateTime.now();
                });
                _loadSettingsAndNews();
              },
              lastUpdated: _lastUpdated, // ← 이 줄 추가
            ),

          ],
        ),
      ),
    );
  }
}
Widget _buildBottomButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  DateTime? lastUpdated,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.grey.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.black87),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.black87)),
          if (label == '갱신' && lastUpdated != null)
            Text(
              '오늘 ${lastUpdated!.hour.toString().padLeft(2, '0')}:${lastUpdated!.minute.toString().padLeft(2, '0')} 갱신됨',
              style: TextStyle(fontSize: 11, color: Colors.grey[700]),
            ),
        ],
      ),
    ),
  );
}

