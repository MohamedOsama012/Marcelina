abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeCategoryState extends AppStates {}

class AppChangeBottomState extends AppStates {}

class AppCartUpdatedState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates {
  final String error;
  AppGetUserErrorState(this.error);
}

class AppUpdateUserLoadingState extends AppStates {}

class AppUpdateUserSuccessState extends AppStates {}

class AppUpdateUserErrorState extends AppStates {
  final String error;
  AppUpdateUserErrorState(this.error);
}

class AppChangeThemeModeLoadingState extends AppStates {}

class AppChangeThemeModeSuccessState extends AppStates {}


