import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences;
String note;
String data = 'key';
const String noteRoute = '/note';
const String valueKey = 'value';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  runApp(
    NotesApp(),
  );
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotesPage(),
      routes: <String, WidgetBuilder>{
        noteRoute: (BuildContext context) => NotePage(),
      },
    );
  }
}

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> notes = <String>[];

  @override
  void initState() {
    note = preferences.getString(valueKey);
    notes.add(note);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {},
            title: Text('${note[index]}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, noteRoute);
        },
      ),
    );
  }
}

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your notes'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: controller1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Write a note',
            ),
            onChanged: (String notite) {
              preferences.setString(note, notite);
            },
          ),
        ],
      ),
    );
  }
}
