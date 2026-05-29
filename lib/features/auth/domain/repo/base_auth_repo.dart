import 'package:wasal/features/auth/data/models/login/request/login_request.dart';
import 'package:wasal/features/auth/data/models/login/response/login_response.dart';

abstract class BaseAuthRepo {
  Future<LoginResponse> login(LoginRequest loginRequest);
}
