import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_catalogo/profile_screen.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState();
}

class _editnoteState extends State<editnote> {
  TextEditingController titulo = TextEditingController();
  TextEditingController ano = TextEditingController();
  TextEditingController director = TextEditingController();
  TextEditingController genero = TextEditingController();
  TextEditingController sinopsis = TextEditingController();
  TextEditingController imagen = TextEditingController();

  @override
  void initState() {
    titulo = TextEditingController(text: widget.docid.get('titulo'));
    ano = TextEditingController(text: widget.docid.get('ano'));
    director = TextEditingController(text: widget.docid.get('director'));
    genero = TextEditingController(text: widget.docid.get('genero'));
    sinopsis = TextEditingController(text: widget.docid.get('sinopsis'));
    imagen = TextEditingController(text: widget.docid.get('imagen'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
        backgroundColor: Colors.blueGrey,
        actions: [
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'titulo': titulo.text,
                'ano': ano.text,
                'director': director.text,
                'genero': genero.text,
                'sinopsis': sinopsis.text,
                'imagen': sinopsis.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
              });
            },
            child: const Text("Guardar", style: TextStyle(color: Colors.white),),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
              });
            },
            child: const Text("Borrar", style: TextStyle(color: Colors.white),),
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
            const SizedBox(
              //child: Text("Título", style: TextStyle(fontSize: 20),),
              height: 25,
            ),
            const SizedBox(
              child: Text("Imagen url", style: TextStyle(fontSize: 20, color: Colors.grey ),),
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: imagen,
                decoration: const InputDecoration(
                  //hintText: 'Título',
                ),
              ),
            ),
            const SizedBox(
              child: Text("Título", style: TextStyle(fontSize: 20, color: Colors.grey ),),
            height: 25,
          ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: titulo,
                decoration: const InputDecoration(
                  hintText: 'Título',
                ),
              ),
            ),
            const SizedBox(
              child: Text("Año", style: TextStyle(fontSize: 20, color: Colors.grey),),
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: ano,
                decoration: const InputDecoration(
                  hintText: 'Año',
                ),
              ),
            ),
            const SizedBox(
              child: Text("Director", style: TextStyle(fontSize: 20, color: Colors.grey),),
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                style: TextStyle(color: Colors. white),
                controller: director,
                decoration: const InputDecoration(
                  hintText: 'Director',
                ),
              ),
            ),
            const SizedBox(
              child: Text("Género", style: TextStyle(fontSize: 20, color: Colors.grey),),
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                style: TextStyle(color: Colors. white),
                controller: genero,
                decoration: const InputDecoration(
                  hintText: 'Género',
                ),
              ),
            ),
            const SizedBox(
              child: Text("Sinopsis", style: TextStyle(fontSize: 20, color: Colors.grey),),
              height: 25,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                child: TextField(
                  style: const TextStyle(height: 2, color: Colors. white),
                  controller: sinopsis,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Sinopsis',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}