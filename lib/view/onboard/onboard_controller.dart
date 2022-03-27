import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m3u_nullsafe/m3u_nullsafe.dart';

import '../../core/routes/app_routes.dart';
import '../../core/storage/custom_storage_service.dart';
import '../../core/storage/storage_key_enums.dart';
import '../../models/group_model.dart';
import 'onboard_service.dart';

// ignore: constant_identifier_names
enum OnBoardState { Initial, Busy, Error, Loaded }

class OnBoardController extends GetxController {
  final _onBoardService = Get.find<OnBoardService>();
  final _storageService = Get.find<CustomStorageService>();

  final Rx<OnBoardState> _state = OnBoardState.Initial.obs;
  OnBoardState get state => _state.value;
  set state(OnBoardState val) => _state.value = val;

  final formKey = GlobalKey<FormState>();

  Future<void> getPlaylist(String url) async {
    try {
      state = OnBoardState.Busy;
      final result = await _onBoardService.getPlaylist(url);
      if (result != null) {
        final allContent = await _convertPlaylistData(result);
        await _storageService.write(StorageKeys.allContent, allContent);
        Get.offAndToNamed(AppRoutes.home, arguments: {'allContent': allContent});
      }
      state = OnBoardState.Loaded;
    } catch (exception) {
      state = OnBoardState.Error;
      // ignore: avoid_print
      print('GET PLAYLIST' + exception.toString());
      if (Platform.isAndroid || Platform.isIOS) {
        Fluttertoast.showToast(msg: 'Error: $exception');
      }
    }
  }

  Future<List<ChannelGroup>> _convertPlaylistData(String playlist) async {
    final m3uGenericEntyList = await M3uParser.parse(playlist);
    List<ChannelGroup> channelGroupList = [];
    for (var item in m3uGenericEntyList) {
      final tvSerieTitle = item.title.split(RegExp(r'S[0-9][0-9]')).first;
      final tvSerieSeasonTitle = item.title.split(RegExp(r'E[0-9][0-9]')).first;
      final groupTitle = item.attributes['group-title'];
      final imgUrl = item.attributes['tvg-logo'];
      final content = Episode(
        title: item.title,
        imgUrl: imgUrl,
        link: item.link,
      );
      //Channel grup var mı?
      if (channelGroupList.contains(ChannelGroup(groupTitle: groupTitle ?? 'Other'))) {
        //Channel grubu bul
        var channelGroup = channelGroupList.firstWhere((element) => element.groupTitle == groupTitle);
        //item dizi mi
        if (item.title.contains(RegExp(r'S[0-9][0-9]'))) {
          //dizi var mı
          if (channelGroup.tvSerie.contains(TvSerie(title: tvSerieTitle))) {
            //diziyi bul
            var tvSerie = channelGroup.tvSerie.firstWhere((element) => element.title == tvSerieTitle);
            //Sezon var mı
            if (tvSerie.seasons.contains(Season(title: tvSerieSeasonTitle))) {
              //Sezonu bul
              var season = tvSerie.seasons.firstWhere((element) => element.title == tvSerieSeasonTitle);
              season.episodes.add(content);
            } else {
              tvSerie.seasons.add(Season(
                title: tvSerieSeasonTitle,
                imgUrl: imgUrl,
                episodes: [content],
              ));
            }
          } else {
            channelGroup.tvSerie.add(
              TvSerie(
                title: tvSerieTitle,
                imgUrl: imgUrl,
                seasons: [
                  Season(
                    title: tvSerieSeasonTitle,
                    imgUrl: imgUrl,
                    episodes: [content],
                  ),
                ],
              ),
            );
          }
        } else {
          channelGroup.contentList.add(content);
        }
      } else {
        if (item.title.contains(RegExp(r'S[0-9][0-9]'))) {
          channelGroupList.add(
            ChannelGroup(
              groupTitle: groupTitle ?? 'Other',
              imgUrl: imgUrl,
              tvSerie: [
                TvSerie(
                  title: tvSerieTitle,
                  imgUrl: imgUrl,
                  seasons: [
                    Season(
                      title: tvSerieSeasonTitle,
                      imgUrl: imgUrl,
                      episodes: [content],
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          channelGroupList.add(
            ChannelGroup(
              groupTitle: groupTitle ?? 'Other',
              imgUrl: imgUrl,
              contentList: [content],
            ),
          );
        }
      }
    }
    return channelGroupList;
  }
}
