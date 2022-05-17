import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_catalogo/profile_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //inicializar firebase
Future<FirebaseApp> _initializeFirebase() async{
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return LoginScreen();
        }
        return const Center(child: CircularProgressIndicator(),);
      },
    ),);
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Funcion login
  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){
        print("Usuario inexistente");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/pop.jpg'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                BlendMode.srcOver) )),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Bienvenido a Mexflis", style: TextStyle(color: Colors.white, fontSize: 44.0, fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 44.0,
            ),
            const Text("Iniciar sesión", style: TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold,),),
            const SizedBox(
              height: 44.0,
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Correo electrónico",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.mail, color: Colors.blue,)
              ),
            ),
            const SizedBox(height: 26.0,),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Contraseña",
                  hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.lock, color: Colors.blue,)
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text("¿Olvidaste tu contraseña?", style: TextStyle(color: Colors.blue),),
            const SizedBox(
              height: 88.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.blue,
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                onPressed: () async {
                  User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, BuildContext: BuildContext);
                  print(user);
                  if(user != null){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen()));
                  }
                }, child: const Text("Enviar", style: TextStyle(color: Colors.white, fontSize: 20.0),),),
            )
          ],
        ),
      ),
    );
  }
}
