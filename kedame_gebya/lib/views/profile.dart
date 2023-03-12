import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kedame_gebya/routes.dart';
import 'package:mobile_number/mobile_number.dart';

import 'components/my_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];
  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _mobileNumber = (await MobileNumber.mobileNumber)!;
      _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  Widget fillCards() {
    List<Widget> widgets = _simCard
        .map((SimCard sim) => Text(
            'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'))
        .toList();
    return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text(
            "Kedame Gebya App",
            style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.history);
              },
              icon: const Icon(
                Icons.shopping_bag,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.profile);
              },
              icon: const Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.home);
              },
              icon: const Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('images/baby.jpg'),
              ),
              const Text(
                'Boss baby',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  fontFamily: 'Sacramento',
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(
                height: 20.0,
                width: 150,
                child: Divider(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              // Card(
              //   color: Colors.white,
              //   margin: EdgeInsets.symmetric(
              //     vertical: 10,
              //     horizontal: 25,
              //   ),
              //   child: ListTile(
              //       leading: Icon(
              //         Icons.phone,
              //         color: Color.fromARGB(255, 0, 0, 0),
              //       ),
              //       title: Text(
              //         '+251928983855',
              //         style: TextStyle(
              //             fontFamily: 'Sacramento',
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold,
              //             color: Color.fromARGB(255, 0, 0, 0)),
              //       )),
              // ),
              const Card(
                color: Color.fromARGB(255, 249, 249, 249),
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 25,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  title: Text(
                    'amanuelademe2@gmail.com',
                    style: TextStyle(
                        fontFamily: 'Sacramento',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              Text('Running on: $_mobileNumber\n'),
              fillCards()
            ],
          ),
        ),
      ),
    );
  }
}