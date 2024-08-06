// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:test_hi_bank/models/post_models/post_models.dart';
import 'package:test_hi_bank/repository/google_sign_in.dart';
import 'package:test_hi_bank/repository/post_repository.dart';
import 'package:test_hi_bank/screen/login_screen.dart';

class PostProvider extends ChangeNotifier {
  List<PostModels> posts = [];
  bool isLoading = true;
  String? errorMessage;

  Future<void> getPosts({String? id}) async {
    isLoading = true;
    posts.clear();
    notifyListeners();
    final (err, res) = await PostRepository.getPosts(id: id);
    isLoading = false;
    if (err != null) {
      errorMessage = err;
      notifyListeners();
      return;
    }
    posts = res ?? [];
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await GoogleSignInRepository.logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => const LoginScreen()));
  }
}
