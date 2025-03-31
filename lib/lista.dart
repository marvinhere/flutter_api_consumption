import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //para el http
import 'dart:convert'; //para el json


//Crear un widget de tipo statefull.

//crear de primero un estado

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  List<dynamic> characters = []; //variable para almacenar mi lista
  bool isLoading = true; //variable que me detecta si esta cargando

  @override
  void initState() {
    super.initState(); //inicializar al cargar el widget
    fetchCharacters(); //llamado al metodo que consume la api
  }

  Future<void> fetchCharacters() async {
    final url = Uri.parse("https://dragonball-api.com/api/characters?page=2&limit=5");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        characters = data['items'];
        isLoading = false;
      });
    } else {
      throw Exception("Error al cargar datos");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dragon Ball Characters")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder( //Construye una lista de elementos de manera dinámica según los datos de la API.
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  leading: character['image'] != null
                      ? Image.network(character['image'], width: 50, height: 50, fit: BoxFit.cover)
                      : Icon(Icons.person),
                  title: Text(character['name'] ?? "Desconocido"),
                  subtitle: Text(
                    "Ki: ${character['ki']} / Max Ki: ${character['maxKi']}\nRaza: ${character['race']}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(character['affiliation'] ?? "Sin afiliación"),
                  onTap: () { //Accion que se realiza cuando se da click en cualquier elemento de la lista
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Seleccionaste a ${character['name']}")),
                    );
                  },
                );
              },
            ),
    );
  }
}
