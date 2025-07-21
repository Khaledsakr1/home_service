import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryItem {
  final String id;
  final String prompt;
  final Uint8List imageBytes;
  final DateTime createdAt;

  HistoryItem({
    required this.id,
    required this.prompt,
    required this.imageBytes,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'prompt': prompt,
      'imageBytes': base64Encode(imageBytes),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'],
      prompt: json['prompt'],
      imageBytes: base64Decode(json['imageBytes']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class HistoryService {
  static const String _historyKey = 'furniture_history';
  static final HistoryService _instance = HistoryService._internal();
  factory HistoryService() => _instance;
  HistoryService._internal();

  Future<void> saveToHistory(String prompt, Uint8List imageBytes) async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = await getHistory();
    
    final newItem = HistoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      prompt: prompt,
      imageBytes: imageBytes,
      createdAt: DateTime.now(),
    );
    
    historyList.insert(0, newItem);
    
    // Keep only last 50 items to avoid storage issues
    if (historyList.length > 50) {
      historyList.removeLast();
    }
    
    final jsonList = historyList.map((item) => item.toJson()).toList();
    await prefs.setString(_historyKey, jsonEncode(jsonList));
  }

  Future<List<HistoryItem>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_historyKey);
    
    if (jsonString == null) return [];
    
    final jsonList = jsonDecode(jsonString) as List;
    return jsonList.map((json) => HistoryItem.fromJson(json)).toList();
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}