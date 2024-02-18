import 'package:flavorsph/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:flavorsph/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:flavorsph/ui/views/home/home_view.dart';
import 'package:flavorsph/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flavorsph/ui/views/login/login_view.dart';
import 'package:flavorsph/ui/views/welcome_page/welcome_page_view.dart';
import 'package:flavorsph/ui/views/recipe_list/recipe_list_view.dart';
import 'package:flavorsph/services/recipe_generator_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: WelcomePageView),
    MaterialRoute(page: RecipeListView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: RecipeGeneratorService),
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
