
import 'package:ecommerce_frontend/features/login/bloc/login_event.dart';
import 'package:ecommerce_frontend/features/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc():super(LoginState());
}