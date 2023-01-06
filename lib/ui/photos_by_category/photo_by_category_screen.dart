import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/bloc/get_photos_by_category/bloc.dart';
import 'package:gallery/network/model/photo.dart';
import 'package:gallery/widget/card/card_photo.dart';

import '../../common/utils/ad_manager.dart';
import '../../common/utils/app_constant.dart';
import '../../common/utils/argument.dart';
import '../../common/utils/navigation.dart';
import '../../widget/appbar/home_appbar.dart';
import '../../widget/error/error_widget.dart';
import '../../widget/error/no_data_widget.dart';
import '../../widget/error/no_internet_widget.dart';
import '../../ui/detail/detail_screen.dart';
import '../../common/styles/color_palettes.dart';

class PhotoByCategoryScreen extends StatefulWidget {
  static const routeName = '/photo';
  CategoryDetailArgument arguments;

  PhotoByCategoryScreen({Key? key,required this.arguments}) : super(key: key);

  @override
  _PhotoByCategoryScreenState createState() => _PhotoByCategoryScreenState();
}

class _PhotoByCategoryScreenState extends State<PhotoByCategoryScreen> {
  int page = 1;
  bool hasMorePage = false;
  late List<Photo> lists = [];
  late Completer<void> _refreshCompleter = Completer();
  late ScrollController scrollController;

  _getPhotosByCategory(BuildContext context) {
    context.read<GetPhotosByCategoryBloc>().add(GetPhotosByCategory(page: page,categoryId: widget.arguments.category.id));
  }

  Future<void> _refresh() {
    setState(() {
      page = 1;
      lists.clear();
    });
    _getPhotosByCategory(context);
    return _refreshCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() => _onScrollListener(context, scrollController));

    _getPhotosByCategory(context);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalettes.lightAccent,
          systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          title: Text(
            "${widget.arguments.category.categoryName}'s Photo",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: _buildBody(context),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildLives(context)),
      ],
    );
  }

  void _onScrollListener(BuildContext context,
      ScrollController scrollController) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final comicBloc = BlocProvider.of<GetPhotosByCategoryBloc>(context);

    if (currentScroll == maxScroll && hasMorePage) {
      ++page;
      comicBloc.add(GetPhotosByCategory(page: page,categoryId: widget.arguments.category.id));
    }
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                controller: scrollController,
                children: [
                  ...List<Widget>.from(
                    lists.map(
                          (photo) =>
                          Builder(
                              builder: (context) =>
                                  CardPhoto(
                                    photo: photo,
                                     onTap: () {
                                       Navigation.pushScreen(
                                           context,
                                           DetailScreen(
                                               arguments: PhotoDetailArgument(photo)));
                                     },
                                  )),
                    ),
                  ),
                  hasMorePage
                      ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: CupertinoActivityIndicator(),
                  )
                      : Container(),
                  SizedBox(
                    height: 20,
                  )
                ])),
      ],
    );
  }

  Widget _buildLives(BuildContext context) {

    return BlocBuilder<GetPhotosByCategoryBloc, GetPhotosByCategoryState>(
        builder: (context, state) {
          if (state is GetPhotosByCategoryLoading) {
            if (page != 1) {
              return _buildContent(context);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetPhotosByCategoryHasData) {
            _refreshCompleter.complete();
            _refreshCompleter = Completer();
            if (page == 1) {
              lists.clear();
            }
            hasMorePage = state.result.hasMorePages;
            page = state.result.currentPage;
            lists.addAll(state.result.list);

            return _buildContent(context);
          } else if (state is GetPhotosByCategoryNoData) {
            _refreshCompleter.complete();
            _refreshCompleter = Completer();
            if (page != 1) {
              return _buildContent(context);
            }
            return NoDataWidget(
                message: state.message
            );
          } else if (state is GetPhotosByCategoryNoInternetConnection) {
            _refreshCompleter.complete();
            _refreshCompleter = Completer();
            if (page != 1) {
              return _buildContent(context);
            }
            return NoInternetWidget(
              message: AppConstant.noInternetConnection,
              onPressed: () => _getPhotosByCategory(context),
            );
          } else if (state is GetPhotosByCategoryError) {
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
