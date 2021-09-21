import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trending_on_github/constants/constants.dart';
import 'package:trending_on_github/core/data/network/api_helper.dart';
import 'package:trending_on_github/core/data/network/network_helper.dart';
import 'package:trending_on_github/features/home/data/models/github_repo_model.dart';

abstract class TrendingReposRemoteDataSource {
  Future<GithubRepoModel> getTrendingRepos(Map<String, dynamic> request);

  Future launchUrl(String url);

  Future logoutCurrentUser();
}

class TrendingReposRemoteDataSourceImpl
    implements TrendingReposRemoteDataSource {
  final Dio _dio;
  final FirebaseAuth _auth;

  TrendingReposRemoteDataSourceImpl({
    required Dio dio,
    required FirebaseAuth auth,
  })  : _dio = dio,
        _auth = auth;

  @override
  Future<GithubRepoModel> getTrendingRepos(Map<String, dynamic> request) async {
    Map<String, dynamic> json = await ApiHelper.getData(
      _dio,
      endPoint: kSearchRepositoriesEndpoint,
      body: request,
    );
    GithubRepoModel model = GithubRepoModel.fromJson(json);
    return model;
  }

  @override
  Future launchUrl(String url) async {
    await NetworkHelper.launchURL(url);
  }

  @override
  Future logoutCurrentUser() async {
    await _auth.signOut();
  }
}
