import 'package:firebasefirst/component/screen/form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Open Innovations Lab',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF4169e1),
        title: const Text('Open Innovations Lab'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> Snapshot) {
          if (!Snapshot.hasData) {
            return Center(
              child: Text('no data found'),
            );
          }
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: Snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    showDialogFun(context,Snapshot.data?.docs[index]['images'],Snapshot.data?.docs[index]['name'],Snapshot.data?.docs[index]['mobile'],Snapshot.data?.docs[index]['gmail']);
                  },
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${Snapshot.data?.docs[index]['images']}'),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                        color: Color(0XFF4169e1),
                      ),
                      title: Text(
                          '${Snapshot.data?.docs[index]['name']} (${Snapshot.data?.docs[index]['mobile']})'),
                      subtitle: Text('${Snapshot.data?.docs[index]['gmail']}'),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => form()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

showDialogFun(Context, img,name,mobile,gmail){
  return
}
