import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m3u/m3u.dart';

import '../../core/storage/custom_storage_service.dart';
import '../../models/group_model.dart';
import '../../models/playlist.dart';
import 'home_service.dart';

// ignore: constant_identifier_names
enum HomeState { Initial, Busy, Error, Loaded }

class HomeController extends GetxController {
  final _storageService = Get.find<CustomStorageService>();
  final _homeService = Get.find<HomeService>();

  final Rx<HomeState> _state = HomeState.Initial.obs;
  HomeState get state => _state.value;
  set state(HomeState val) => _state.value = val;

  final Rx<Playlist?> _playlist = Rx(null);
  Playlist? get playlist => _playlist.value;
  set playlist(Playlist? val) => _playlist.value = val;

  final RxList<ChannelGroup> _allContent = <ChannelGroup>[].obs;
  List<ChannelGroup> get allContent => _allContent.value;
  set allContent(List<ChannelGroup> val) => _allContent.value = val;

  @override
  void onInit() {
    final argument = Get.arguments?['playlist'] as Playlist?;
    if (argument != null) {
      playlist = argument;
      if (_storageService.isExist(playlist!.id)) {
        final readModel =
            _storageService.readModel<List<ChannelGroup>, ChannelGroup>(key: playlist!.id, parseModel: ChannelGroup());
        if (readModel != null) {
          allContent = readModel;
        }
      } else {
        getPlaylist();
      }
    }

    super.onInit();
  }

  Future<void> getPlaylist() async {
    try {
      state = HomeState.Busy;
      final result = await _homeService.getPlaylist(playlist!.url);
      if (result != null) {
        final _convertedData = await _convertPlaylistData(result);

        allContent = _convertedData;
        await _storageService.write(playlist!.id, allContent);
      }
      state = HomeState.Loaded;
    } catch (exception) {
      state = HomeState.Error;
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
