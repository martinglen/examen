import 'package:flutter/material.dart'; 
import 'package:flutter_examen/providers/login_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_examen/services/auth_service.dart';
import '../ui/input_decorations.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 150),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text('Login'),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: const LoginForm(),
                  ),
                  const SizedBox(height: 30),
              TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                            shape: MaterialStateProperty.all(StadiumBorder()),
                          ),
                          child: const Text('No tienes cuenta? Regístrate aquí'),
                        ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    
    return Container(
      child: Form(
        key: loginFormProvider.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Ingrese su correo',
              labelText: 'Email',
              prefixIcon: Icons.people,
            ),
            onChanged: (value) => loginFormProvider.email = value,
            validator: (value) {
              return (value != null && value.length >= 6) 
                  ? null 
                  : 'El usuario no puede estar vacío o debe tener al menos 6 o mas caracteres';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              hintText: '************',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => loginFormProvider.password = value,
            validator: (value) {
              return (value != null && value.length >= 6) 
                  ? null 
                  : 'La contraseña no puede estar vacía o debe tener al menos 6 o mas caracteres';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: Colors.orange,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: const Text(
                'Ingresar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            elevation: 0,
            onPressed: loginFormProvider.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService = Provider.of<AuthService>(context, listen: false);
                    if (!loginFormProvider.isValidForm()) return;
                    loginFormProvider.isLoading = true;
                    
                    final String? errorMessage = await authService.login(
                      loginFormProvider.email, 
                      loginFormProvider.password,
                    );
                    
                    if (errorMessage == null) {
                      // Si no hay error, redirige a la pantalla de lista
                      Navigator.pushReplacementNamed(context, 'principal');

                    } else {
                      // Muestra el mensaje de error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Usuario o contraseña incorrecta'),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                    
                    loginFormProvider.isLoading = false;
                  },
          ),
        ]),
      ),
    );
  }
}
