import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_catalogo/profile_screen.dart';

class addnote extends StatelessWidget {
  TextEditingController titulo = TextEditingController();
  TextEditingController ano = TextEditingController();
  TextEditingController director = TextEditingController();
  TextEditingController genero = TextEditingController();
  TextEditingController sinopsis = TextEditingController();
  TextEditingController imagen = TextEditingController();


  CollectionReference ref = FirebaseFirestore.instance.collection('catalogo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo'),
        backgroundColor: Colors.blueGrey,
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'titulo': titulo.text,
                'ano': ano.text,
                'director': director.text,
                'genero': genero.text,
                'sinopsis': sinopsis.text,
                'imagen': imagen.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
              });
            },
            child: const Text(
              "Guardar", style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
                         },
            child: const Text("Cancelar", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/movie_theater.jpg'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                BlendMode.srcOver) )),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                style: const TextStyle(color: Colors. white),
                controller: titulo,
                decoration: const InputDecoration(
                  hintText: 'Título',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 3,
                right: 3,
              ),
              child: SizedBox(
                height: 10,
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                style: const TextStyle(color: Colors. white),
                controller: ano,
                decoration: const InputDecoration(
                  hintText: 'Año',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                style: const TextStyle(color: Colors. white),
                controller: director,
                decoration: const InputDecoration(
                  hintText: 'Director',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                style: const TextStyle(color: Colors. white),
                controller: genero,
                decoration: const InputDecoration(
                  hintText: 'Género',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                style: const TextStyle(color: Colors. white),
                controller: sinopsis,
                decoration: const InputDecoration(
                  hintText: 'Sinopsis',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                style: const TextStyle(color: Colors. white),
                controller: imagen,
                decoration: const InputDecoration(
                  hintText: 'url',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}