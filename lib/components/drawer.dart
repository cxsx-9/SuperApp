import 'package:superapp/components/drawer_tile.dart';
import 'package:superapp/pages/notes_page.dart';
import 'package:superapp/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:superapp/pages/weather_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context){
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // header
          const DrawerHeader(
            decoration: BoxDecoration(
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.check_box_rounded,
                  size: 64,
                ),
                Text(
                  'SuperApp',
                  style: TextStyle(
                  ),
                ),
              ],
            ),
          ),

          // note title
          DrawerTile(title: "Notes",
          leading: const Icon(Icons.edit_calendar_outlined),
          onTap: (){ 
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const NotesPage()));
          }),


          // weather
          DrawerTile(title: "Weather",
          leading: const Icon(Icons.cloud),
          onTap: (){ 
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const WeatherPage()));
          }),
          
          
          // setting
          DrawerTile(title: "Setting",
          leading: const Icon(Icons.settings),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsPage()));
          })
        ],
      )
    );
  }
}