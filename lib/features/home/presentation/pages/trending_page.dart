import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trending_on_github/constants/constants.dart';
import 'package:trending_on_github/core/ui/helpers/app_navigator.dart';
import 'package:trending_on_github/core/ui/widgets/app_error_widget.dart';
import 'package:trending_on_github/core/ui/widgets/app_loading_widget.dart';
import 'package:trending_on_github/core/ui/widgets/dialogs.dart';
import 'package:trending_on_github/features/home/data/models/github_repo_model.dart';
import 'package:trending_on_github/features/home/presentation/manager/trending_repos_cubit/trending_repos_cubit.dart';
import 'package:trending_on_github/features/home/presentation/manager/trending_repos_cubit/trending_repos_state.dart';
import 'package:trending_on_github/features/home/presentation/manager/trending_repos_scroll_to_top_cubit/trending_repos_scroll_to_top_cubit.dart';
import 'package:trending_on_github/features/login/presentation/pages/login_screen.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({Key? key}) : super(key: key);

  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  final List<RepoItemModel> _reposItems = [];
  int _currentPage = 1;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initWidgetState();
  }

  void _initWidgetState() {
    _scrollController.addListener(_scrollListener);
    _getTrendingRepos();
  }

  void _scrollListener() {
    _getMoreRepos();

    _manipulateBackToTopButton();
  }

  void _getMoreRepos() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _currentPage = _currentPage + 1;
      _getMoreTrendingRepos();
    }
  }

  Future _getMoreTrendingRepos() async {
    await context
        .read<TrendingReposCubit>()
        .getMoreTrendingRepos(_getRequestBody());
  }

  void _manipulateBackToTopButton() {
    if (_scrollController.offset >= 400) {
      context.read<TrendingReposScrollToTopCubit>().showBackToTopButton();
    } else {
      context.read<TrendingReposScrollToTopCubit>().hideBackToTopButton();
    }
  }

  Future _getTrendingRepos() async {
    await context
        .read<TrendingReposCubit>()
        .getTrendingRepos(_getRequestBody());
  }

  Map<String, dynamic> _getRequestBody() {
    return {
      "q": "created:>2017-10-22",
      "sort": "stars",
      "order": "desc",
      "page": _currentPage.toString(),
    };
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<TrendingReposCubit, TrendingReposState>(
      listener: (_, state) {
        if (state is UserLogoutState) {
          AppNavigator.pushReplacement(
            context,
            widget: const LoginScreen(),
          );
        }
      },
      builder: (_, state) {
        if (state is TrendingReposLoadingState) {
          return const AppLoadingWidget();
        } else if (state is TrendingReposLoadedState) {
          _reposItems.addAll(state.model.items ?? []);
          return _buildReposListView(_reposItems);
        } else if (state is TrendingReposErrorState) {
          Dialogs.buildSnackBar(context, state.errorMessage);
          return _reposItems.isNotEmpty
              ? _buildReposListView(_reposItems)
              : AppErrorWidget(refreshCallback: _refreshData);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildReposListView(List<RepoItemModel> items) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.separated(
        controller: _scrollController,
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          if (index == items.length - 1) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: AppLoadingWidget(),
            );
          }
          return RepoItemModelBuilder(repo: items[index]);
        },
      ),
    );
  }

  Future _refreshData() async {
    _currentPage = 0;
    _reposItems.clear();
    await _getTrendingRepos();
  }

  Widget _floatingActionButton() {
    return BlocBuilder<TrendingReposScrollToTopCubit, bool>(
        builder: (context, state) {
      return Visibility(
        visible: state,
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          child: const Icon(Icons.keyboard_arrow_up),
        ),
      );
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 2),
      curve: Curves.ease,
    );
  }
}

class RepoItemModelBuilder extends StatelessWidget {
  final RepoItemModel repo;

  const RepoItemModelBuilder({Key? key, required this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context
          .read<TrendingReposCubit>()
          .launchRepoUrl(repo.htmlUrl ?? kPlaceholderUrl),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(repo.name ?? Strings.noRepositoryName,
                style: kTitleBlackTextStyle),
            const SizedBox(height: 20),
            Text(repo.description ?? Strings.noDescription),
            const SizedBox(height: 20),
            _ownerDetails(),
          ],
        ),
      ),
    );
  }

  Widget _ownerDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.network(
              repo.owner?.avatarUrl ?? kPlaceholderImageUrl,
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 5),
            Text(repo.owner?.login ?? Strings.noOwnerName),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.star),
            const SizedBox(width: 5),
            Text("${repo.stargazersCount ?? 0}"),
          ],
        ),
      ],
    );
  }
}
