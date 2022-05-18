import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'addnote.dart';
import 'editnote.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('catalogo').snapshots();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => addnote()));
      },
      child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Catálogo'),
        backgroundColor: Colors.blueGrey,
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return const Text("Algo salió mal");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/cinema.jpg'),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                    BlendMode.srcOver) )),
           /* decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),*/
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>editnote(docid: snapshot.data!.docs[index])));
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        child: Image.network(snapshot.data!.docChanges[index].doc['imagen'].toString()),
                          width: 150.0,
                          height: 150.0
                        ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            snapshot.data!.docChanges[index].doc['titulo'],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data!.docChanges[index].doc['ano'],
                            style: const TextStyle(
                              fontSize: 15,
                                color: Colors.white
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );

  }
}
