import 'package:flutter/material.dart';

void main(){
  runApp(const MiApp());
}

class Usuario {
  final String nombre;
  final String apellido;
  final int edad;
  final String genero;
  final String ciudad;
  final String sobreMi;
  final String usuario;
  final String constrasena;

  const Usuario({
    required this.nombre,
    required this.apellido,
    required this.edad,
    required this.genero,
    required this.ciudad,
    required this.sobreMi,
    required this.usuario,
    required this.constrasena,
  });
}
