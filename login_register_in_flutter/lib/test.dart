class MiApp extends StatelessWiget {
    const MyApp ({super.key});

    @override
    Wiget bild(BuildContext){
        return MaterialApp(
            title: 'Registro e inicio de secion'
            debugShowCheckedModeBanner: false,
            theme: THemeData(colorSchemeSeed: Colors.blue, useMaterial3: true)
            home: const RegistroScreen(),

        );
    }
}