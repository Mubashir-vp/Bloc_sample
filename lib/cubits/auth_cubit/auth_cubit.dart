import 'package:bloc_sample/cubits/auth_cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  AuthCubit() : super(AuthInitialState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      emit(AuthLoggedoutState());
    } else {
      emit(AuthLoggedInState(firebaseUser: currentUser));
    }
  }
  void sendOtp(String phno) async {
    emit(AuthLoadingState());
    _auth.verifyPhoneNumber(
      phoneNumber: phno,
      verificationCompleted: (phoneAuthCredential) {
        signInwithphone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(
          AuthErrorState(
            errorMessage: error.message.toString(),
          ),
        );
      },
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(
          AuthCodeSendState(),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOtp(String otp) async {
    emit(AuthLoadingState());

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );
    signInwithphone(credential);
  }

  void signInwithphone(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredentional = await _auth.signInWithCredential(
        credential,
      );
      if (userCredentional.user != null) {
        emit(
          AuthLoggedInState(
            firebaseUser: userCredentional.user!,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(
        AuthErrorState(
          errorMessage: e.message.toString(),
        ),
      );
    }
  }

  void logout() {
    _auth.signOut();
    emit(AuthLoggedoutState());
  }
}
