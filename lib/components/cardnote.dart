import 'package:flutter/material.dart';

import '../constant/api.dart';
import '../model/note_model.dart';

class Cardnote extends StatelessWidget {
  const Cardnote(
      {super.key,  this.ontab, this.onDelete, required this.noteModel});

  // final String title;
  // final String content;

  final void Function()? ontab;
  final void Function()? onDelete;
  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontab,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    '$linkimages/${noteModel.notesImages}',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text('${noteModel.notesTitle}'),
                  subtitle: Text('${noteModel.notesContent}'),
                  trailing:  IconButton(
                    onPressed: onDelete, 
                  icon: Icon(Icons.delete,color: Colors.red,)),
                )),
          ],
        ),
      ),
    );
  }
}
