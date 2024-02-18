import 'package:flavorsph/app/app.locator.dart';
import 'package:flavorsph/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    bool isLogin = true;

    if (isLogin) {
      _navigationService.replaceWithWelcomePageView();
    } else {
      _navigationService.replaceWithHomeView();
    }
  }
}
