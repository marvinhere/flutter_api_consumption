import 'package:flutter/material.dart';
import 'personaje.dart';

class PersonajeScreen extends StatelessWidget {
  final int personajeId;

  const PersonajeScreen({Key? key, required this.personajeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles del Personaje")),
      body: Center(
        child: PersonajeWidget(id:personajeId) // Pasamos el ID del personaje
      ),
    );
  }
}
