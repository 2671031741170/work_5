import 'package:work6/models/note.dart';


class NotesRepository {
  static final List<Note> _notes = [
    Note(
      date: "Aug 31\n2024",
      time: "11:24 AM",
      title: "อาหารเช้า",
      content: "Start with soft-boiled eggs, bacon, boiled vegetables, steamed fish and black coffee.",
    ),
    Note(
      date: "Aug 31\n2024",
      time: "11:27 AM",
      title: "กำหนดเรื่องราวงาน",
      content: "ทำการบ้านวิชาภาษาอังกฤษจนถึง 15.00 น.",
    ),
    Note(
      date: "Aug 31\n2024",
      time: "11:28 AM",
      title: "ตารางออกกำลังกาย",
      content: "06:00 น. วิ่ง\n07:00 น. คาร์ดิโอ",
    ),
  ];

  List<Note> getAll() => List.unmodifiable(_notes);

  void add(Note note) {
    _notes.insert(0, note);
  }

  void update(int index, Note note) {
    _notes[index] = note;
  }

  void delete(int index) {
    _notes.removeAt(index);
  }

  static String getMonthAbbr(int month) {
    const list = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return list[month - 1];
  }

  static Note createNow({required String title, required String content}) {
    final now = DateTime.now();
    return Note(
      date: "${getMonthAbbr(now.month)} ${now.day}\n${now.year}",
      time: _formatTime(now),
      title: title.trim().isNotEmpty ? title.trim() : "ไม่มีชื่อเรื่อง",
      content: content.trim().isNotEmpty ? content.trim() : "ไม่มีรายละเอียด",
    );
  }

  static String _formatTime(DateTime d) {
    final h = d.hour > 12 ? d.hour - 12 : d.hour;
    final ap = d.hour >= 12 ? 'PM' : 'AM';
    return "$h:${d.minute.toString().padLeft(2, '0')} $ap";
  }
}