import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PersonajeWidget extends StatefulWidget {
  final int id;

  const PersonajeWidget({Key? key, required this.id}) : super(key: key);

  @override
  _PersonajeWidgetState createState() => _PersonajeWidgetState();
}

class _PersonajeWidgetState extends State<PersonajeWidget> {
  Map<String, dynamic>? personaje;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPersonaje();
  }

  Future<void> fetchPersonaje() async {
    final url = 'https://dragonball-api.com/api/characters/${widget.id}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          personaje = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Error al cargar los datos');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : personaje == null
              ? Text('Error al cargar el personaje')
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(personaje!['image'], height: 200),
                    SizedBox(height: 10),
                    Text(
                      personaje!['name'],
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text('Raza: ${personaje!['race']}'),
                    Text('Género: ${personaje!['gender']}'),
                    Text('Ki: ${personaje!['ki']}'),
                    Text('Planeta de origen: ${personaje!['originPlanet']['name']}'),
                  ],
                ),
    );
  }
}
