import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:php_flutter/components/crud.dart';
import 'package:php_flutter/main.dart';

import '../../components/customtextgform.dart';
import '../../components/valid.dart';
import '../../constant/api.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  bool isLoading = false;

  addnotes() async {
    if (myfile == null) return   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please choose a photo')));
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequestWithFile(linkAddnotes, {
        'title': titleController.text,
        'content': contentController.text,
        'id': sharedPref.getString('id'), 
      }, myfile!);
      isLoading = false;
      setState(() {});
      if (response['status'] == 'success') {
        Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustomTextFormSign(
                      valid: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }else if (value.length > 10){
                              return 'make the text shorter';
                            }
                            return null;
                          },
                      hint: 'Title',
                      mycontroller: titleController,
                    ),
                    CustomTextFormSign(
                      valid: (value) {
                             if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }else if (value.length < 3){
                              return 'make the text longer';
                            }
                            return null;
                          },
                        hint: 'Content', mycontroller: contentController),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 10),
                      color: myfile == null ? Colors.redAccent : Colors.grey,
                      textColor: Colors.white,
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                            XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                            Navigator.of(context).pop();
                                            myfile = File(xfile!.path); 
                                            setState(() {
                                              
                                            });
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(10),
                                          child: const Center(
                                            child: Text(
                                              'Choose Image Forme Gallery',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        height: 2,
                                        thickness: 1,
                                        indent: 5,
                                        endIndent: 0,
                                        color: Colors.grey,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                           XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
                                           Navigator.of(context).pop();
                                            myfile = File(xfile!.path); 
                                            setState(() {
                                              
                                            });
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(10),
                                          child: const Center(
                                            child: Text(
                                              'Choose Image Forme Camera',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      },
                      child: const Text('Upload Image'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 10),
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      onPressed: () async {
                        await addnotes();
                      },
                      child: const Text('Add Note'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
