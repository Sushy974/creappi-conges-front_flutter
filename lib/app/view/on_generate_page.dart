import 'package:creappi_conge/app/bloc/app_bloc.dart';
import 'package:creappi_conge/pages/connexion/view/connexion_page.dart';
import 'package:creappi_conge/pages/dashboard_admin/view/dashboard_admin_page.dart';
import 'package:creappi_conge/pages/dashboard_employe/view/dashboard_employe_page.dart';
import 'package:flutter/widgets.dart';

List<Page<dynamic>> onGenerateAppDestinationViewPages(
  AppState state,
  List<Page<dynamic>> pages,
) {
  if (state.utilisateur == null) {
    return [
      ConnexionPage.page(),
    ];
  }
  if (state.utilisateur?.role == 'admin') {
    return [
      DashboardAdminPage.page(),
    ];
  }
  if (state.utilisateur?.role == 'employe') {
    return [
      DashboardEmployePage.page(),
    ];
  }
  return pages;
}
