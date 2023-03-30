import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kedame_gebya/routes.dart';
import 'package:mobile_number/mobile_number.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
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

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    try {
      _mobileNumber = (await MobileNumber.mobileNumber)!;
      _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "Kedame Gebya",
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
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const <Widget>[
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('images/baby.jpg'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Boss baby',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 30,
                      color: Colors.black,
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
              ],
            ),
          ),
          Column(
            children: <Widget>[
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
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 249, 249, 249),
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 25,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.phone,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  title: Text(
                    '+$_mobileNumber',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
