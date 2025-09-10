import 'package:creappi_conge/pages/connexion/bloc/connexion_bloc.dart';
import 'package:creappi_conge/pages/connexion/view/connexion_view.dart';
import 'package:creappi_conge/repositories/auth_repository.dart';
import 'package:creappi_conge/usecases/connexion_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnexionPage extends StatelessWidget {
  const ConnexionPage({super.key});

  static Page<ConnexionPage> page() {
    return const MaterialPage(child: ConnexionPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnexionBloc(
        connexionUsecase: ConnexionUsecase(
          authRepository: context.read<AuthRepository>(),
        ),
      ),
      child: const ConnexionView(),
    );
  }
}
