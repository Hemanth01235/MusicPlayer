import 'package:flutter/material.dart';
import 'package:musicplayer/presentation/favorite_songs/favorite_songs.dart';
import 'package:musicplayer/presentation/home_screen/home_Screen.dart';
import 'package:musicplayer/presentation/settings_screen/settings_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.music_note,
                  size: 30,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: ListTile(
                title: const Text("H O M E"),
                leading: const Icon(Icons.home),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 0),
              child: ListTile(
                title: const Text("S E T T I N G S"),
                leading: const Icon(Icons.settings),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SettingsScreen();
                  },));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,top: 10),
              child: ListTile(
                title: const Text("F A V O R I T E"),
                leading: const Icon(Icons.favorite),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FavoriteSongs();
                  },));
                },
              ),
            ),
          ],
        ));
  }
}
