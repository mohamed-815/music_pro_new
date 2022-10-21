import 'package:flutter/material.dart';
import 'package:music_pro_1/db/dbfetching.dart';
import 'package:music_pro_1/presentation/home/mainscreen.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenhight = MediaQuery.of(context).size.height;
    // final double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: (() => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((context) => const MainScreen())),
                  (route) => false)),
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Settings'),
          backgroundColor: const Color(0xFF2F3E46),
        ),
        backgroundColor: const Color(0xFF2F3E46),
        body: SafeArea(
            child: ListView(
          children: [
            SizedBox(
              height: screenhight / 20,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => LicensePage())));
              },
              leading: const Icon(
                Icons.privacy_tip,
                color: Colors.white,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Privacy',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Security',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Notification',
                    style: TextStyle(color: Colors.white),
                  ),
                  // Text(
                  //   'Message, group & call tones',
                  //   style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                  // )
                ],
              ),
              trailing: Switch(
                  value: notificationison,
                  onChanged: ((value) async {
                    final Pref1 = await SharedPreferences.getInstance();
                    final notificationon = Pref1.getBool('isturnon')!;

                    if (notificationon == false) {
                      setState(() {
                        notificationison = true;
                      });
                      await Pref1.setBool('isturnon', notificationison);
                    } else {
                      setState(() {
                        notificationison = false;
                      });
                      await Pref1.setBool('isturnon', notificationison);
                    }
                  })),
            ),
            ListTile(
              onTap: () {
                Alert(
                    context: context,
                    title: "Help",
                    desc: "mail @ mohmedvgd34@gmail.com",
                    buttons: [
                      DialogButton(
                        color: Color.fromARGB(255, 29, 64, 51),
                        child: SizedBox(
                          child: Text(
                            'close',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ]).show();
              },
              leading: const Icon(
                Icons.support_agent_rounded,
                color: Colors.white,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Help',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Help centre.',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Share.share(
                    'https://play.google.com/store/apps/details?id=in.mohamedkutty.music_pro');
              },
              child: ListTile(
                leading: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Share',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "music pro",
                  applicationVersion: "1.0",
                  children: [
                    const Text("music player created by mohamed kutty")
                  ],
                );
              },
              leading: const Icon(
                Icons.roundabout_left,
                color: Colors.white,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'About',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'terms and conditions.',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenhight / 2.8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      'version',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Text(
                      '1.1',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ],
            )
          ],
        )));
  }
}
