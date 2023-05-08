import 'package:flutter/material.dart';
import 'package:php_flutter/app/notes/edit.dart';
import 'package:php_flutter/components/crud.dart';
import 'package:php_flutter/main.dart';
import '../components/cardnote.dart';
import '../constant/api.dart';
import '../model/note_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  getNotes() async {
    var response =
        await postRequest(viewNotes, {'id': sharedPref.getString('id')});
    return response;
  }

  Future refresh () async {
      setState(()  {
          getNotes();
      });
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('login', (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('add');
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: refresh,
          child: ListView(children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'failed') {
                      return const Center(child: Text('No Notes'));
                    }
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Cardnote(
                              onDelete: () async {
                                var response = postRequest(linkDeleteNotes, {
                                  'id': snapshot.data['data'][index]['notes_id']
                                      .toString(),
                                   'imagename' : snapshot.data['data'][index]['notes_images']
                                });
                                if (snapshot.data["status"] == "success") {
                                  Navigator.of(context)
                                      .pushReplacementNamed('home');
                                }
                              },
                              ontab: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditNotes(
                                          notes: snapshot.data['data'][index],
                                        )));
                              },
                              noteModel: NoteModel.fromJson(
                                  snapshot.data['data'][index]));
                        });
                  }
            
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.redAccent,
                    ));
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.redAccent,
                  ));
                })
          ]),
        ),
      ),
    );
  }
}
