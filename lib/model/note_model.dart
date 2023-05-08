class NoteModel {
  int? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImages;
  int? notesUser;

  NoteModel(
      {this.notesId,
      this.notesTitle,
      this.notesContent,
      this.notesImages,
      this.notesUser});

  NoteModel.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'];
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImages = json['notes_images'];
    notesUser = json['notes_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes_id'] = this.notesId;
    data['notes_title'] = this.notesTitle;
    data['notes_content'] = this.notesContent;
    data['notes_images'] = this.notesImages;
    data['notes_user'] = this.notesUser;
    return data;
  }
}