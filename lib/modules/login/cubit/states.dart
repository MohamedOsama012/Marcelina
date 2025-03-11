abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginChangePasswordVisibility extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String uId;
  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class RegisterLoadingState extends LoginStates {}

class RegisterSuccessState extends LoginStates {
  final String uId;
  RegisterSuccessState(this.uId);
}

class RegisterErrorState extends LoginStates {
  final String error;
  RegisterErrorState(this.error);
}

class CreateUserLoadingState extends LoginStates {}

class CreateUserSuccessState extends LoginStates {
  final String uId;
  CreateUserSuccessState(this.uId);
}

class CreateUserErrorState extends LoginStates {
  final String error;
  CreateUserErrorState(this.error);
}

