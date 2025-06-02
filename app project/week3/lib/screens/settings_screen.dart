import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool)? onThemeChanged;

  const SettingsScreen({super.key, required this.onThemeChanged});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> _excludedKeywords = [];
  TextEditingController _keywordController = TextEditingController();
  TextEditingController _periodController = TextEditingController();


  bool _isDarkMode = false;
  String _selectedTopic = '전체';
  String _selectedPeriod = '3';

  final List<String> _topics = ['전체', '정치', '경제', '사회', '스포츠', '과학'];
  final List<String> _periods = ['1일', '3일', '7일'];

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
    await prefs.setString('newsTopic', _selectedTopic);
    await prefs.setString('newsPeriod', _selectedPeriod);
    await prefs.setStringList('excludeKeywords', _excludedKeywords);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
      _selectedTopic = prefs.getString('newsTopic') ?? '전체';
      _selectedPeriod = prefs.getString('newsPeriod') ?? '3';
      _periodController.text = _selectedPeriod;
      _excludedKeywords = prefs.getStringList('excludeKeywords') ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('설정')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: Text('다크모드'),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
              widget.onThemeChanged?.call(value);
              _saveSettings();
            },
          ),
          SizedBox(height: 8),
          Divider(),
          SizedBox(height: 8),
          // 뉴스 주제 선택
          Text('뉴스 주제', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            isExpanded: true,
            value: _selectedTopic,
            items: _topics.map((topic) {
              return DropdownMenuItem(value: topic, child: Text(topic));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedTopic = value!;
              });
              _saveSettings();
            },
          ),
          SizedBox(height: 16),
          // 키워드 입력 필드 + 추가 버튼
          Text('제외할 키워드', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: _keywordController,
            decoration: InputDecoration(
              hintText: '예: 연예, 코로나 등',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  final keyword = _keywordController.text.trim();
                  if (keyword.isNotEmpty && !_excludedKeywords.contains(keyword)) {
                    setState(() {
                      _excludedKeywords.add(keyword);
                      _excludedKeywords.sort((a, b) => a.compareTo(b)); // 🔥 알파벳/한글순 정렬
                    });
                    _saveSettings();
                    _keywordController.clear();
                  } else {
                    // 중복 키워드일 때 사용자에게 피드백
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('이미 추가된 키워드입니다')),
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 8),
          // 키워드 리스트 표시 (Chip)
          Wrap(
            spacing: 8,
            children: _excludedKeywords.map((keyword) {
              return Chip(
                label: Text(keyword),
                onDeleted: () {
                  setState(() {
                    _excludedKeywords.remove(keyword);
                  });
                  _saveSettings();
                },
              );
            }).toList(),
          ),
          SizedBox(height: 8),
          Divider(),
          SizedBox(height: 8),
          // 뉴스 기간 선택
          Text('뉴스 기간 (일)', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: _periodController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '예: 1, 3, 7',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _selectedPeriod = value;
              });
              _saveSettings();
            },
          ),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              await _saveSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('설정이 저장되었습니다')),
              );
            },
            child: Text('설정 완료'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),

        ],
      ),
    );
  }
}
