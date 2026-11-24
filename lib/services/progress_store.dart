import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class ProgressStore {
  static const _key='chemmaster_progress_v1';
  static Future<Map<String,dynamic>> read() async {
    final prefs=await SharedPreferences.getInstance();
    final raw=prefs.getString(_key);
    if(raw==null)return {'lessons':<String>[], 'answers':<String,dynamic>{}, 'bestScores':<String,dynamic>{}};
    try{return jsonDecode(raw) as Map<String,dynamic>;}catch(_){return {'lessons':<String>[], 'answers':<String,dynamic>{}, 'bestScores':<String,dynamic>{}};}
  }
  static Future<void> completeLesson(String id) async {
    final data=await read(); final lessons=List<String>.from(data['lessons']??[]);
    if(!lessons.contains(id))lessons.add(id);
    data['lessons']=lessons; await _write(data);
  }
  static Future<void> saveQuiz(String id,int score,int total) async {
    final data=await read(); final scores=Map<String,dynamic>.from(data['bestScores']??{});
    final old=scores[id] as int? ?? 0; if(score>old)scores[id]=score;
    data['bestScores']=scores;
    final answers=Map<String,dynamic>.from(data['answers']??{});
    answers[id]={'score':score,'total':total,'date':DateTime.now().toIso8601String()};
    data['answers']=answers; await _write(data);
  }
  static Future<void> _write(Map<String,dynamic> data) async {
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString(_key,jsonEncode(data));
  }
}
