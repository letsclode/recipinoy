import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flavorsph/services/firestore_service.dart';
import 'package:flavorsph/services/recipe_generator_service.dart';
import 'package:flavorsph/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:flavorsph/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:flavorsph/ui/views/home/home_view.dart';
import 'package:flavorsph/ui/views/recipe_list/recipe_list_view.dart';
import 'package:flavorsph/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RecipeListView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: RecipeGeneratorService),
    LazySingleton(classType: FirestoreService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
