import 'package:flutter/material.dart';
import 'package:musicplayer/model/playlist_provider.dart';
import 'package:musicplayer/presentation/util/resource/drawer.dart';
import 'package:provider/provider.dart';

class FavoriteSongs extends StatelessWidget {
  const FavoriteSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          onPressed: () {
            return Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 15,
          ),
        ),
        title: const Center(
          child: Text(
            "F A V O R I T E",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      endDrawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, child) {
          final favoriteList = playlistProvider.favoriteList;
          return ListView.builder(
            itemCount: favoriteList.length,
            itemBuilder: (context, index) {
              final song = favoriteList[index];
              return ListTile(
                leading: Image.asset(song.albumArtImagePath,width: 50,height: 50,),
                title: Text(
                  song.songName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: Text(
                  song.artistName,
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.primary),
                ),
                onTap: () => playlistProvider.goToSong(context, playlistProvider.playlist.indexOf(song)),
              );
            },
          );
        },
      ),
    );
  }
}
