import 'package:flutter/material.dart';
import '../../models/note.dart';
import '../../repository/notes_repository.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? existingNote;
  final int? editIndex;

  const AddNoteScreen({super.key, this.existingNote, this.editIndex});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingNote != null) {
      _titleCtrl.text = widget.existingNote!.title;
      _contentCtrl.text = widget.existingNote!.content;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingNote != null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(isEdit ? "แก้ไขบันทึก" : "Add note"),
        centerTitle: true,
        actions: [
          if (isEdit)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => Navigator.pop(context, {
                "action": "delete",
                "index": widget.editIndex,
              }),
            ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final newNote = NotesRepository.createNow(
                title: _titleCtrl.text,
                content: _contentCtrl.text,
              );
              Navigator.pop(context, {
                "action": "save",
                "index": widget.editIndex,
                "note": newNote,
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentCtrl,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Start typing here.......",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  alignLabelWithHint: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}