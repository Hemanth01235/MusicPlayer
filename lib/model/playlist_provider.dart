import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:musicplayer/model/song_model.dart';
import 'package:musicplayer/presentation/song_screen/song_screen.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: "I Am Albatraoz",
        artistName: "Aronchupa",
        albumArtImagePath: "assets/images/Aronchupa.jpg",
        audioPath: "audio/Albatraoz.mp3",
        videoPath: "video/AronChupa.mp4"
    ),
    Song(
        songName: "Magenta Riddim",
        artistName: "DJ Snake",
        albumArtImagePath: "assets/images/Magenta_riddim.jpg",
        audioPath: "audio/Magenta_Riddim.mp3",
        videoPath: "video/Magenta_Riddim.mp4"
    ),
  ];

  int? _currentSongIndex=0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlaylistProvider() {
    listenToDuration();
    print("inside constructor");
  }
  final List<Song> _favoriteList = [];

  bool _isPlaying = false;

  bool _isRepeat = false;

  bool _isShuffle = false;

  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void pauseOrResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else
      if (_isRepeat) {
        currentSongIndex = 0;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        if (_isRepeat) {
          currentSongIndex = _playlist.length - 1;
        } else {
          currentSongIndex = _playlist.length - 1;
        }
      }
    }
  }

  void resume() async {
    _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      if (_isRepeat) {
        play();
      } else {
        playNextSong();
      }
    });
  }

  List<Song> get playlist => _playlist;

  List<Song> get favoriteList => _favoriteList;

  int? get currentSongIndex => _currentSongIndex;

  bool get isPlaying => _isPlaying;

  Duration get currentDuration => _currentDuration;

  Duration get totalDuration => _totalDuration;

  bool get isRepeat => _isRepeat;

  bool get isShuffle => _isShuffle;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if(newIndex != null)
      {
        play();
      }
    notifyListeners();
  }

  set isRepeat(bool value){
    _isRepeat = value;
    notifyListeners();
  }

  set isShuffle(bool value) {
    _isShuffle = value;
    notifyListeners();
  }

  void shufflePlaylist() {
    _playlist.shuffle();
    if (_currentSongIndex != null) {
      _currentSongIndex = _playlist.indexOf(_playlist[_currentSongIndex!]);
    }
    notifyListeners();
  }

  void toggleFavorite(Song song) {
    if (_favoriteList.contains(song)) {
      _favoriteList.remove(song);
    } else {
      _favoriteList.add(song);
    }
    notifyListeners();
  }

  bool isFavorite(Song song) {
    return _favoriteList.contains(song);
  }

  void goToSong(BuildContext context, int songIndex) {
    currentSongIndex = songIndex;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongScreen(),
      ),
    );
  }

}
