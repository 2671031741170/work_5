import 'package:flutter/material.dart';
import '../../models/note.dart';
import '../../repository/notes_repository.dart';
import '../add-note/add_note_screen.dart';
import './widgets/item_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _repo = NotesRepository();

  void _refresh() => setState(() {});

  Future<void> _openAdd() async {
    final res = await Navigator.push(context,
      MaterialPageRoute(builder: (_) => const AddNoteScreen()),
    );
    if (res != null && res["action"] == "save") {
      _repo.add(res["note"]);
      _refresh();
    }
  }

  Future<void> _openEdit(int index, Note note) async {
    final res = await Navigator.push(context,
      MaterialPageRoute(builder: (_) => AddNoteScreen(
        existingNote: note,
        editIndex: index,
      )),
    );
    if (res == null) return;
    setState(() {
      if (res["action"] == "delete") {
        _repo.delete(res["index"]);
        _showMsg("ลบรายการเรียบร้อยแล้ว 🗑️");
      } else if (res["action"] == "save") {
        _repo.update(res["index"], res["note"]);
        _showMsg("บันทึกการแก้ไขเรียบร้อยแล้ว ✅");
      }
    });
  }

  void _showMsg(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final items = _repo.getAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Diary"),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _refresh),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (_, i) => ItemNote(
          note: items[i],
          onTap: () => _openEdit(i, items[i]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAdd,
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}