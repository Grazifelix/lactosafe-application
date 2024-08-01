import 'package:LactoSafe/src/controller/sign_in_page_controller.dart';
import 'package:LactoSafe/src/controller/textfield_controller.dart';
import 'package:LactoSafe/src/model/auth_service.dart';
import 'package:LactoSafe/src/shared/app_colors.dart';
import 'package:LactoSafe/src/shared/app_images.dart';
import 'package:LactoSafe/src/view/home_page.dart';
import 'package:LactoSafe/src/view/signup_page_view.dart';
import 'package:flutter/material.dart';
import 'package:LactoSafe/src/components/custom_text_field.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static const routeName = '/SignIn';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextFieldController textFieldController = TextFieldController();
  String loginStatus = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, auth, _) {
        if (auth.currentUser != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.popAndPushNamed(context, HomePage.routeName);
          });
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    color: Colors.white, child: Image.asset(AppImages.logo)),
              ),
              SizedBox(
                child: Text(
                  loginStatus,
                  style: TextStyle(color: AppColors.orange, fontSize: 18),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 50,
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Email
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: CustomTextField(
                            icon: Icons.email,
                            label: 'Email',
                            isObscure: false,
                            controller: textFieldController.emailController,
                          ),
                        ),
                        //Senha
                        CustomTextField(
                          icon: Icons.lock,
                          label: 'Senha',
                          isObscure: true,
                          controller: textFieldController.passwordController,
                        ),
                        //Esqueceu a senha
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/resetPassword');
                            },
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(color: AppColors.orange),
                            ),
                          ),
                        ),
                        //Entrar
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder()),
                            onPressed: () async {
                              String email =
                                  textFieldController.getEmailFromTextField();
                              String password = textFieldController
                                  .getPasswordFromTextField();

                              loginStatus = await signInController(
                                  context, email, password);
                              setState(() {});
                            },
                            child: const Text(
                              'Entrar',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'ou',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // GoogleButton
                        InkWell(
                          onTap: () {
                            //Vai pro login com google
                            Navigator.pushReplacementNamed(context, "/home");
                          },
                          child: Image.asset(
                            AppImages.googleIcon,
                            width: 60,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                        ),

                        ///CadastroButton
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Não possui uma conta?',
                                style: TextStyle(fontSize: 13),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.popAndPushNamed(
                                          context, SignUpPage.routeName);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        'Cadastre-se aqui!',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.orange),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
