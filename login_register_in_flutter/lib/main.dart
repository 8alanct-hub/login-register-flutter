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


class RegistroScreen extends StatefulWidget{
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState()
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();

  final nombreCtrl = TextEditingController();
  final apellidoCtrl = TextEditingController();
  final sobreMiCtrl = TextEditingController();
  final usuarioCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  
//Datos que cambian con los widgetes de selccion osea los de arriba

  double edad = 18;
  String? genero = 'Masculino';
  String? ciudad;
  bool aceptaTerminos = false;
  bool verPass = false;

//Aqui va la funcion del paso 4
void registra(){
  final formOk = _formKey.currentState!.validate();
  if (!formOk)
}

}