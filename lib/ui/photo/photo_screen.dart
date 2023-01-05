import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/bloc/get_photos/bloc.dart';
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
class PhotoScreen extends StatefulWidget {
  static const routeName = '/photo';

  const PhotoScreen({Key? key}) : super(key: key);

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  String keyword = "";
  int page = 1;
  int genreSelectedIndex = 0;
  bool hasMorePage = false;
  late List<Photo> lists = [];
  late Completer<void> _refreshCompleter = Completer();
  late ScrollController scrollController;

  _getPhotos(BuildContext context) {
    context.read<GetPhotosBloc>().add(GetPhotos(page: page));
  }

  Future<void> _refresh() {
    setState(() {
      page = 1;
      lists.clear();
    });
    _getPhotos(context);
    return _refreshCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() => _onScrollListener(context, scrollController));

    _getPhotos(context);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: HomeAppBar()),
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
    final comicBloc = BlocProvider.of<GetPhotosBloc>(context);

    if (currentScroll == maxScroll && hasMorePage) {
      ++page;
      comicBloc.add(GetPhotos(page: page));
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
                                       // Navigation.pushScreen(
                                       //     context,
                                       //     PostDetailScreen(
                                       //         arguments: PostDetailArgument(post)));
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

    return BlocBuilder<GetPhotosBloc, GetPhotosState>(
        builder: (context, state) {
          if (state is GetPhotosLoading) {
            if (page != 1) {
              return _buildContent(context);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetPhotosHasData) {
            _refreshCompleter.complete();
            _refreshCompleter = Completer();
            if (page == 1) {
              lists.clear();
            }
            hasMorePage = state.result.hasMorePages;
            page = state.result.currentPage;
            lists.addAll(state.result.list);

            return _buildContent(context);
          } else if (state is GetPhotosNoData) {
            _refreshCompleter.complete();
            _refreshCompleter = Completer();
            if (page != 1) {
              return _buildContent(context);
            }
            return NoDataWidget(
                message: state.message
            );
          } else if (state is GetPhotosNoInternetConnection) {
            _refreshCompleter.complete();
            _refreshCompleter = Completer();
            if (page != 1) {
              return _buildContent(context);
            }
            return NoInternetWidget(
              message: AppConstant.noInternetConnection,
              onPressed: () => _getPhotos(context),
            );
          } else if (state is GetPhotosError) {
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
