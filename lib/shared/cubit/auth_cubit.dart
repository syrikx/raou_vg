// lib/shared/cubit/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../utils/ui_helper.dart';

class AuthCubit extends Cubit<User?> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(null);

  /// 앱 시작 시 현재 로그인된 사용자 확인
  void checkAuthStatus() {
    final user = _authService.getCurrentUser();
    if (user != null) {
      emit(user);
    }
  }

  /// 구글 로그인 시도 및 상태 반영
  Future<void> signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
      if (user == null) return;

      final isNew = await _authService.isNewUser(user.uid);
      if (isNew) {
        await _authService.createUserDoc(user);
        UIHelper.showSnack('환영합니다, ${user.displayName ?? user.email}님!');
      } else {
        UIHelper.showSnack('다시 오신 걸 환영합니다, ${user.displayName}님!');
      }

      emit(user);
    } catch (e) {
      UIHelper.showSnack('로그인 실패: $e');
    }
  }

  /// Apple 로그인 시도 및 상태 반영
  Future<void> signInWithApple() async {
    try {
      final user = await _authService.signInWithApple();
      if (user == null) return;

      final isNew = await _authService.isNewUser(user.uid);
      if (isNew) {
        await _authService.createUserDoc(user);
        UIHelper.showSnack('환영합니다, ${user.displayName ?? user.email}님!');
      } else {
        UIHelper.showSnack(
            '다시 오신 걸 환영합니다, ${user.displayName ?? user.email}님!');
      }

      emit(user);
    } catch (e) {
      UIHelper.showSnack('Apple 로그인 실패: $e');
    }
  }

  /// 로그아웃 처리
  Future<void> signOut() async {
    await _authService.signOut();
    emit(null);
    UIHelper.showSnack('로그아웃 되었습니다.');
  }
}
