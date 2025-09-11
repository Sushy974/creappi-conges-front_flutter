import 'package:creappi_conge/app/app.dart';
import 'package:creappi_conge/bootstrap.dart';
import 'package:creappi_conge/repositories/auth_repository.dart';
import 'package:creappi_conge/repositories/demandes_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() {
  bootstrap(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: HydratedStorageDirectory.web,
      );
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (context) => LocalAuthRepository(),
          ),
          RepositoryProvider<DemandesRepository>(
            create: (context) => LocalDemandesRepository(),
          ),
        ],
        child: const App(),
      );
    },
  );
}
