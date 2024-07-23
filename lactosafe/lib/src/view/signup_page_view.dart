import 'package:LactoSafe/src/components/custom_text_field.dart';
import 'package:LactoSafe/src/controller/sign_up_page_controller.dart';
import 'package:LactoSafe/src/controller/textfield_controller.dart';
import 'package:LactoSafe/src/model/auth_service.dart';
import 'package:LactoSafe/src/view/home_page.dart';
import 'package:LactoSafe/src/view/signin_page_view.dart';
import 'package:flutter/material.dart';
import 'package:LactoSafe/src/shared/app_images.dart';
import 'package:LactoSafe/src/shared/app_colors.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const routeName = '/signup';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextFieldController textFieldController = TextFieldController();
  String errorMesage = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, auth, _) {
      if (auth.currentUser != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.popAndPushNamed(context, HomePage.routeName);
        });
      }
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(AppImages.logo),
              ),
            ),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(errorMesage),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Nome de usuário"),
                        ),
                      ),
                      CustomTextField(
                        icon: Icons.person,
                        label: "Insira o nome de usuário",
                        controller: TextEditingController(),
                        validator: (value) {
                          return null;
                        },
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("E-mail"),
                        ),
                      ),
                      CustomTextField(
                        icon: Icons.email,
                        label: "nome@dominio.com",
                        controller: textFieldController.emailController,
                        validator: (value) {
                          return null;
                        },
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Senha"),
                        ),
                      ),
                      CustomTextField(
                        icon: Icons.lock,
                        label: "Insira sua senha",
                        isObscure: true,
                        controller: textFieldController.passwordController,
                        validator: (value) {
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const StadiumBorder()),
                          onPressed: () {},
                          child: Text(
                            'Cadastro com o Google',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Ou",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const StadiumBorder()),
                          onPressed: () async {
                            String email =
                                textFieldController.getEmailFromTextField();
                            String password =
                                textFieldController.getPasswordFromTextField();
                            errorMesage = await singUpController(
                                context, email, password);
                            if (errorMesage != '') setState(() {});
                          },
                          child: Text(
                            'Fazer cadastro',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const StadiumBorder()),
                          onPressed: () {
                            Navigator.popAndPushNamed(
                                context, SignIn.routeName);
                          },
                          child: Text(
                            'Voltar',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ),
      );
    });
  }
}
