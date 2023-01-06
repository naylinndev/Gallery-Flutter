import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/bloc/get_category/bloc.dart';
import 'package:gallery/network/model/photo.dart';
import 'package:gallery/widget/card/card_photo.dart';
import '../../network/model/category.dart';

import '../../common/utils/ad_manager.dart';
import '../../common/utils/app_constant.dart';
import '../../common/utils/argument.dart';
import '../../common/utils/navigation.dart';
import '../../widget/appbar/home_appbar.dart';
import '../../widget/error/error_widget.dart';
import '../../widget/error/no_data_widget.dart';
import '../../widget/error/no_internet_widget.dart';
import '../../widget/card/card_category.dart';
import '../../ui/photos_by_category/photo_by_category_screen.dart';
class CategoryScreen extends StatefulWidget {
  static const routeName = '/category';

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int page = 1;
  bool hasMorePage = false;
  late List<Category> lists = [];
  late Completer<void> _refreshCompleter = Completer();
  late ScrollController scrollController;

  _getCategory(BuildContext context) {
    context.read<GetCategoryBloc>().add(GetCategory(page: page));
  }

  Future<void> _refresh() {
    setState(() {
      page = 1;
      lists.clear();
    });
    _getCategory(context);
    return _refreshCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() => _onScrollListener(context, scrollController));

    _getCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: HomeAppBar(title: "Category",)),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: _buildBody(context),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildCategory(context)),
      ],
    );
  }

  void _onScrollListener(
      BuildContext context, ScrollController scrollController) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final comicBloc = BlocProvider.of<GetCategoryBloc>(context);

    if (currentScroll == maxScroll && hasMorePage) {
      ++page;
      comicBloc.add(GetCategory(page: page));
    }
  }

  Widget _buildContent(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverGrid(
          delegate: SliverChildBuilderDelegate((c, index) {
            final category = lists[index];
            return CardCategory(
                category: category,
                onTap: () {
                  Navigation.pushScreen(
                      context,
                      PhotoByCategoryScreen(
                          arguments: CategoryDetailArgument(category)));
                });
          }, childCount: lists.length),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.7),
        ),
        SliverToBoxAdapter(
          child: hasMorePage
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: CupertinoActivityIndicator(),
                )
              : SizedBox(
                  height: 20,
                ),
        ),
      ],
    );
  }

  Widget _buildCategory(BuildContext context) {
    return BlocBuilder<GetCategoryBloc, GetCategoryState>(
        builder: (context, state) {
      if (state is GetCategoryLoading) {
        if (page != 1) {
          return _buildContent(context);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is GetCategoryHasData) {
        _refreshCompleter.complete();
        _refreshCompleter = Completer();
        if (page == 1) {
          lists.clear();
        }
        hasMorePage = state.result.hasMorePages;
        page = state.result.currentPage;
        lists.addAll(state.result.list);

        return _buildContent(context);
      } else if (state is GetCategoryNoData) {
        _refreshCompleter.complete();
        _refreshCompleter = Completer();
        if (page != 1) {
          return _buildContent(context);
        }
        return NoDataWidget(message: state.message);
      } else if (state is GetCategoryNoInternetConnection) {
        _refreshCompleter.complete();
        _refreshCompleter = Completer();
        if (page != 1) {
          return _buildContent(context);
        }
        return NoInternetWidget(
          message: AppConstant.noInternetConnection,
          onPressed: () => _getCategory(context),
        );
      } else if (state is GetCategoryError) {
        _refreshCompleter.complete();
        _refreshCompleter = Completer();
        if (page != 1) {
          return _buildContent(context);
        }
        return CustomErrorWidget(message: state.errorMessage);
      } else {
        _refreshCompleter.complete();
        _refreshCompleter = Completer();
        if (page != 1) {
          return _buildContent(context);
        }
        return Container();
      }
    });
  }
}
