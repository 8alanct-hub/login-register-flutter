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

class MiApp extends StatelessWidget {
    const MiApp ({super.key});

    @override
    Widget build(BuildContext context){
        return MaterialApp(
            title: 'Registro e inicio de sesión',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
            home: const RegistroScreen(),
        );
    }
}


class RegistroScreen extends StatefulWidget{
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
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
  String genero = 'Masculino';
  String? ciudad;
  bool aceptaTerminos = false;
  bool verPass = false;


//Aqui va la funcion del paso 4

void registrar(){
  //1 
  final formOk = _formKey.currentState!.validate();
  if (!formOk) return;

  //2 valida lo que no es un TextFormField
  if (ciudad == null){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Elige una ciudad')),
      );
      return; 
  }
  if (!aceptaTerminos) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Debes aceptar los términos')),
      );
      return;
  }

  // 3 Arma el usuario con todos Los Datos
  final nuevo = Usuario(
    nombre: nombreCtrl.text, 
    apellido: apellidoCtrl.text, 
    edad: edad.toInt(), 
    genero: genero, 
    ciudad: ciudad!, 
    sobreMi: sobreMiCtrl.text, 
    usuario: usuarioCtrl.text, 
    constrasena: passCtrl.text,
    );

  //Navega a la confirmacion enviado el usuario por el constructor 
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ConfirmacionScreen(usuario: nuevo),
      ),
  );
}

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: const Text('crear cuenta')),
    body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: nombreCtrl,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
            value == null || value.isEmpty ? 'Escribe tu Nombre': null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: apellidoCtrl,
            decoration: const InputDecoration(
              labelText: 'Apellido',
              border: OutlineInputBorder(),
            ),
            validator: (value) => 
            value == null || value.isEmpty ? 'Escribe tu apellido': null,
          ),
          const SizedBox(height: 20),

          Text('Edad ${edad.toInt()}'),
          Slider(
            value: edad,
            min: 15,
            max: 80,
            divisions: 65,
            label: '${edad.toInt()}',
            onChanged: (nuevoValor){
              setState(() => edad = nuevoValor);
            },
          ),

          //Genero

          const Text('Genero'),
          RadioListTile<String>(
            title: const Text('Masculino'),
            value: 'Masculino',
            groupValue: genero,
            onChanged: (valor) => setState(() => genero = valor!),
          ),
          RadioListTile<String>(
            title: const Text('Feminino'),
            value: 'Femenino',
            groupValue: genero,
            onChanged: (valor) => setState(() => genero = valor!),
          ),
          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            value: ciudad,
            decoration: const InputDecoration(
              labelText: 'Ciudad',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Cartagena', child: Text('Cartagena')),
              DropdownMenuItem(value: 'Bogotá', child: Text('Bogotá')),
              DropdownMenuItem(value: 'Medellín', child: Text('Medellín')),
              DropdownMenuItem(value: 'Cali', child: Text('Cali')),
            ],
            onChanged:(value) => setState(() => ciudad = value),
          ),
          const SizedBox(height: 12),

          //Sobre MI
          TextFormField(
            controller: sobreMiCtrl,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Sobre mí',
              hintText: 'Cuentanos algo sobre ti...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          //usuario
          TextFormField(
            controller: usuarioCtrl,
            decoration: const InputDecoration(
              labelText:'Usuario',
              border: OutlineInputBorder(),
            ),
            validator: (valor) => 
              valor == null || valor.isEmpty ? 'Elige un usuario': null,
          ),
          const SizedBox(height: 12),


          //Contraseña
          TextFormField(
            controller: passCtrl,
            obscureText: !verPass,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  verPass ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => verPass = !verPass),
                ),
            ),
            validator: (valor) => valor == null || valor.length < 4
                ? 'Minimo 4 Caracteres'
                : null,
          ),
          const SizedBox(height: 8),

          CheckboxListTile(
            title: const Text('Acepto términos y condiciones'),
            value: aceptaTerminos,
            onChanged: (valor) => setState(() => aceptaTerminos = valor!),
          ),
          const SizedBox(height: 8),

        // Boton
        ElevatedButton(
          onPressed: registrar, 
          child: const Text('Registrarme'),
          ),
        ],
      ),
    ),
  );
}

}

class ConfirmacionScreen extends StatelessWidget{
  final Usuario usuario;
  const ConfirmacionScreen({super.key, required this.usuario});
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Registor')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 90),
            const SizedBox(height: 16),
            const Text(
              '¡Registro Exitoso!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox (height: 8),
            Text(
              'Bienvenido, ${usuario.nombre}. Tu usuario quedó creado.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){

                  //Va hacia al login asi la flecha atras no regresa al formulario
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(usuario: usuario)
                      ),
                      (ruta) => false,
                  ); 
                },
                child: const Text('Ir a Iniciar Sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 

//La pantalla del Login

class LoginScreen extends StatefulWidget{
  final Usuario usuario;
  const LoginScreen({super.key, required this.usuario});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usuarioCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool verPass = false;


  void entrar() {
    
    final coincide = usuarioCtrl.text == widget.usuario.usuario && 
      passCtrl.text == widget.usuario.constrasena;

    if (coincide){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BienvenidaScreen(usuario: widget.usuario),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [TextField(
          controller: usuarioCtrl,
          decoration: const InputDecoration(
            labelText: 'Usuario',
            border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: passCtrl,
            obscureText: !verPass,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  verPass ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => verPass = !verPass),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: entrar, child: 
              const Text('Entrar'),
            ),
          ],
      ),
    );
  }
}

// Pantalla de Bienvenida

class BienvenidaScreen extends StatelessWidget {
  final Usuario usuario;
  const BienvenidaScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        automaticallyImplyLeading: false, // Ya no puede volver a la pantalla anterior
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, color: Colors.blue, size: 90),
            const SizedBox(height: 16),
            Text(
              '¡Hola ${usuario.nombre}!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Ingreso exitoso',
              style: TextStyle(color: Colors.green)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: (){

                  //Cerrar Sesion
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(usuario: usuario),
                    ),
                    (ruta) => false,
                    );
                }, 
                child: const Text('Cerrar sesión'),
                ),
            ),
          ],
        ),
      ),
    );
  }
}