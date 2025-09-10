import 'package:creappi_conge/app/bloc/app_bloc.dart';
import 'package:creappi_conge/pages/connexion/bloc/connexion_bloc.dart';
import 'package:creappi_conge/inputs/email_input.dart';
import 'package:creappi_conge/inputs/mot_de_passe.dart';
import 'package:creappi_conge/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ConnexionView extends StatefulWidget {
  const ConnexionView({super.key});

  @override
  State<ConnexionView> createState() => _ConnexionViewState();
}

class _ConnexionViewState extends State<ConnexionView> {
  final _emailController = TextEditingController();
  final _motDePasseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _motDePasseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo et titre
                        _buildLogo(),
                        const SizedBox(height: 40),

                        // Formulaire de connexion
                        BlocConsumer<ConnexionBloc, ConnexionState>(
                          listener: (context, state) {
                            if (state.status.isSuccess) {
                              context.read<AppBloc>().add(
                                AppTokenChanged(
                                  state.token,
                                ),
                              );
                              context.read<AppBloc>().add(
                                AppUtilisateurChanged(
                                  state.utilisateur!,
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Connexion réussie !'),
                                  backgroundColor: AppTheme.successColor,
                                ),
                              );
                            } else if (state.status.isFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.errorMessage),
                                  backgroundColor: AppTheme.errorColor,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Champ email
                                Text(
                                  'Email',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: AppTheme.textPrimary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _emailController,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (email) {
                                    if (email == null || email.isEmpty) {
                                      return 'Veuillez entrer votre email';
                                    }
                                    return null;
                                  },

                                  onChanged: (email) {
                                    context.read<ConnexionBloc>().add(
                                      ConnexionEmailChanged(email),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Entrez votre email',
                                    suffixIcon: const Icon(
                                      Icons.email_outlined,
                                    ),
                                    errorText:
                                        (state.email.isNotValid &&
                                            !state.email.isPure)
                                        ? state.email.error?.text()
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Champ mot de passe
                                Text(
                                  'Mot de passe',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: AppTheme.textPrimary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _motDePasseController,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (motDePasse) {
                                    if (motDePasse == null ||
                                        motDePasse.isEmpty) {
                                      return 'Veuillez entrer votre mot de passe';
                                    }
                                    return null;
                                  },
                                  onChanged: (motDePasse) {
                                    context.read<ConnexionBloc>().add(
                                      ConnexionMotDePasseChanged(motDePasse),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Entrez votre mot de passe',
                                    suffixIcon: const Icon(Icons.lock_outlined),
                                    errorText:
                                        (state.motDePasse.isNotValid &&
                                            !state.motDePasse.isPure)
                                        ? state.motDePasse.error?.text()
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Bouton de connexion
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed:
                                        context.read<ConnexionBloc>().isValid
                                        ? () =>
                                              context.read<ConnexionBloc>().add(
                                                const ConnexionSubmitted(),
                                              )
                                        : null,
                                    child: state.status.isInProgress
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    AppTheme.textOnPrimary,
                                                  ),
                                            ),
                                          )
                                        : const Text('Connexion'),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/creapp-i.png',
      width: 200,
      fit: BoxFit.cover,
    );
  }

  Widget _buildTextField({
    required String label,
    String? hint,
    TextEditingController? controller,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }
}
