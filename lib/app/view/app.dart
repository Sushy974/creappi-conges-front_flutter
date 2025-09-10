import 'package:creappi_conge/app/bloc/app_bloc.dart';
import 'package:creappi_conge/app/view/on_generate_page.dart';
import 'package:creappi_conge/l10n/l10n.dart';
import 'package:creappi_conge/theme/app_theme.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Créapp-i Congés',
      theme: AppTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider.value(
        value: AppBloc(),
        child: Builder(
          builder: (context) => FlowBuilder(
            state: context.select((AppBloc bloc) => bloc.state),
            onGeneratePages: onGenerateAppDestinationViewPages,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
