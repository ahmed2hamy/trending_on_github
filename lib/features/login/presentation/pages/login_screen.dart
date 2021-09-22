import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trending_on_github/constants/constants.dart';
import 'package:trending_on_github/core/ui/helpers/app_navigator.dart';
import 'package:trending_on_github/core/ui/helpers/validator.dart';
import 'package:trending_on_github/core/ui/widgets/dialogs.dart';
import 'package:trending_on_github/features/home/presentation/pages/home_screen.dart';
import 'package:trending_on_github/features/login/presentation/manager/login_cubit.dart';
import 'package:trending_on_github/injection_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String _emailAddress = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: sl<LoginCubit>(),
      listener: (_, state) {
        if (state is LoginLoadedState) {
          final String? token = state.userCredential.user?.refreshToken;
          if (token != null) {
            AppNavigator.pushReplacement(context, widget: const HomeScreen());
          }
        } else if (state is LoginErrorState) {
          Dialogs.buildSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: Strings.loginScreenHeroTag,
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset(kLogoImage),
                    ),
                  ),
                ),
                const SizedBox(height: 48.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return Validator.validateEmail(value ?? "");
                  },
                  onChanged: (value) {
                    _emailAddress = value;
                  },
                  decoration: kTextInputDecoration.copyWith(
                    labelText: Strings.enterEmail,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  obscureText: _obscureText,
                  validator: (value) {
                    return Validator.validatePassword(value ?? "");
                  },
                  onChanged: (value) {
                    _password = value;
                  },
                  decoration: kTextInputDecoration.copyWith(
                    labelText: Strings.enterPassword,
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (_, state) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const StadiumBorder()),
                      ),
                      child: state is LoginLoadingState
                          ? const CircularProgressIndicator.adaptive()
                          : const Text(
                              Strings.login,
                              style: kWhiteTextStyle,
                            ),
                      onPressed: state is LoginLoadingState
                          ? null
                          : () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                context
                                    .read<LoginCubit>()
                                    .loginWithEmailAndPassword(
                                        email: _emailAddress,
                                        password: _password);
                              }
                            },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
