import 'package:bruteforce_wifi/MatrixEffect.dart';
import 'package:flutter/material.dart';
import 'package:signal_strength_indicator/signal_strength_indicator.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() {
  runApp(MaterialApp(
    title: 'Bruteforce Wifi',
    debugShowCheckedModeBanner: false,
    home: MyApp()
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  List<WifiNetwork> listWifi;

  @override
  void initState() {
    listWifi = new List<WifiNetwork>();
    GetWifi();
  }

  GetWifi() async {
    listWifi = await WiFiForIoTPlugin.loadWifiList();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Stack(
              children: [
                MatrixEffect(),
                Container(
                  alignment: Alignment.center,
                  child: Text('Bruteforce Wifi',style: TextStyle(color: Colors.green, fontSize: 28),),
                )
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
            ),
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left:20,right:20),
            width: MediaQuery.of(context).size.width-40,
            height: MediaQuery.of(context).size.height-220,
            child: ListView.builder(
              itemCount: listWifi.length,
              itemBuilder: (BuildContext context, int index){
                WifiNetwork wifi = listWifi[index];
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(wifi.ssid),
                      SignalStrengthIndicator.sector(
                        value: wifi.level/5.0,
                        size: 50,
                        barCount: 4,
                        spacing: 0.5,
                      )
                    ],
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}