import 'package:dio/dio.dart';
import 'package:test_hi_bank/models/post_models/post_models.dart';

class PostRepository {
  static Future<(String? error, List<PostModels>? posts)> getPosts(
      {String? id}) async {
    final options = BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      validateStatus: (status) {
        return status! < 500;
      },
    );
    Dio dio = Dio(options);
    final String url = id == null
        ? 'https://jsonplaceholder.typicode.com/posts'
        : 'https://jsonplaceholder.typicode.com/posts/$id';
    final res = await dio.get(
      url,
    );
    if (res.statusCode == 200) {
      List<PostModels>? posts = [];
      if (id != null) {
        PostModels postModels = PostModels.fromJson(res.data);
        posts.add(postModels);
      } else {
        for (var element in res.data) {
          PostModels postModels = PostModels.fromJson(element);
          posts.add(postModels);
        }
      }
      return (null, posts);
    }
    return ('Data tidak ditemukan', null);
  }
}
