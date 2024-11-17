// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:watertank/utilities/constrains.dart';

class Watertank extends StatefulWidget {
  static String id = "Watertank";
  const Watertank({super.key});

  @override
  State<Watertank> createState() => _WatertankState();
}

class _WatertankState extends State<Watertank> {
  bool isLoading = false;
  String motor_status = 'Loading';
  Color motorTextColor = Colors.white;
  String date = "Loading...";
  String datetank2 = "Loading...";
  String tank1Percentage = '0%';
  String tank2Percentage = '0%';
  String sumpPercentage = '0%';
  Color tank1Color = Colors.white;
  Color tank2Color = Colors.white;
  Color sumpColor = Colors.white;
  Color tank1andsumpstatus = yellow;
  Color tank2status = yellow;
  DateTime currentdate = DateTime.now();
  
  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    const String apiUrl = "http://104.237.9.130/Test_Grace/input_oht_sump.php";
    const String apiUrltank2 = "http://104.237.9.130/Test_Grace/input_oht_right.php";
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          date = data['date'];
          motor_status = data['m_status'] == 1 ? 'ON' : 'OFF';
          motorTextColor = motor_status == 'ON' ? green : red;
          DateTime apidate = DateTime.parse(date);

          int tank1Level = data['tank1_level1'] + data['tank1_level2'];
          tank1Percentage = tank1Level == 0
              ? '100%'
              : tank1Level == 1
                  ? '50%'
                  : '0%';
          
          if(tank1Level == 0) {
            tank1Color = green;
          } else if (tank1Level == 1) {
            tank1Color = yellow;
          } else {
            tank1Color = red;
          }

          if (apidate.year == currentdate.year &&
              apidate.month == currentdate.month &&
              apidate.day == currentdate.day &&
              apidate.hour == currentdate.hour &&
              apidate.minute == currentdate.minute) {
            tank1andsumpstatus = green;
          } else {
            tank1andsumpstatus = red;
          }

          int sumpLevel = data['sump_level1'] + data['sump_level2'];
          sumpPercentage = sumpLevel == 0
              ? '100%'
              : sumpLevel == 1
                  ? '50%'
                  : '0%';

          if(sumpLevel == 0) {
            sumpColor = green;
          } else if (sumpLevel == 1) {
            sumpColor = yellow;
          } else {
            sumpColor = red;
          }

        });
      } else {
        setState(() {
          date = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        date = "Error fetching data";
      });
    }

    try {
      final response = await http.get(Uri.parse(apiUrltank2));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          datetank2 = data['date'];
          DateTime apidate = DateTime.parse(datetank2);

          int tank2Level = data['tank1_level1'] + data['tank1_level2'];
          tank2Percentage = tank2Level == 0
              ? '100%'
              : tank2Level == 1
                  ? '50%'
                  : '0%';

          if(tank2Level == 0) {
            tank2Color = green;
          } else if (tank2Level == 1) {
            tank2Color = yellow;
          } else {
            tank2Color = red;
          }

          if (apidate.year == currentdate.year &&
              apidate.month == currentdate.month &&
              apidate.day == currentdate.day &&
              apidate.hour == currentdate.hour &&
              apidate.minute == currentdate.minute) {
            tank2status = green;
          } else {
            tank2status = red;
          }

        });
      } else {
        setState(() {
          datetank2 = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        datetank2 = "Error fetching data";
      });
    }
  }

  String getWaveGif(String percentage) {
    switch (percentage) {
      case '100%':
        return 'images/wave_100.gif';
      case '50%':
        return 'images/wave_50.gif';
      case '0%':
      default:
        return 'images/wave_0.gif';
    }
  }

  void reload() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushNamed(context, Watertank.id);
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
                ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    const SizedBox(
                      height: 180,
                      child: Image(
                        image: AssetImage('images/waterdripping.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          'WATER MANAGEMENT SYSTEM',
                          style: text1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 115,right: 22),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            reload();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 2,
                                  color: Colors.grey
                                ),
                              ],
                              color: Color.fromARGB(255, 244, 244, 244)
                            ),
                            height: 50,
                            width: 50,
                            child:  const Icon(
                              Icons.replay,
                              color: Colors.black,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25,top: 10),
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              color: Color(0xffEDEDED),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: Colors.grey
                                )
                              ]
                            ),
                            height: 140,
                            width: 190,
                          ),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20,top: 15),
                                child: Text('Motor',style: text3,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,top: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    color: grey,
                                  ),
                                  height: 50,
                                  width: 150,
                                  child:  Center(
                                    child: Text(
                                      motor_status,
                                      style: text2.copyWith(color: motorTextColor)
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Image(
                      image: AssetImage('images/watermotor.png'),
                      height: 176,
                      width: 169,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 30,top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 20),
                            child: CircleAvatar(
                              backgroundColor: tank1andsumpstatus,
                              radius: 7,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 60),
                                child: Text('TANK 1',style: text4,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    color: grey,
                                  ),
                                  height: 25,
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      tank1Percentage,
                                      style:numbers.copyWith(color: tank1Color),
                                    )
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                                          color: grey
                                        ),
                                        height: 170,
                                        width: 8  ,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12,left: 2),
                                        child: Column(
                                          children: [
                                            Container(
                                              color: green,
                                              height: 5,
                                              width: 6,
                                            ),
                                            const SizedBox(
                                              height: 55,
                                            ),
                                            Container(
                                              color: yellow,
                                              height: 5,
                                              width: 6,
                                            ),
                                            const SizedBox(
                                              height: 55,
                                            ),
                                            Container(
                                              color: red,
                                              height: 5,
                                              width: 6,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)
                                          ),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(0, 3),
                                                blurRadius: 5,
                                                color: Colors.grey
                                              )
                                            ]
                                          ),
                                        height: 170,
                                        width: 150,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          child: Image.asset(
                                            getWaveGif(tank1Percentage),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Text(date,style: text5,),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 20),
                            child: CircleAvatar(
                              backgroundColor: tank2status,
                              radius: 7,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 60),
                                child: Text('TANK 2',style: text4,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    color: grey,
                                  ),
                                  height: 25,
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      tank2Percentage,
                                      style:numbers.copyWith(color: tank2Color),
                                    )
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                                          color: grey
                                        ),
                                        height: 170,
                                        width: 8  ,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12,left: 2),
                                        child: Column(
                                          children: [
                                            Container(
                                              color: green,
                                              height: 5,
                                              width: 6,
                                            ),
                                            const SizedBox(
                                              height: 55,
                                            ),
                                            Container(
                                              color: yellow,
                                              height: 5,
                                              width: 6,
                                            ),
                                            const SizedBox(
                                              height: 55,
                                            ),
                                            Container(
                                              color: red,
                                              height: 5,
                                              width: 6,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)
                                          ),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(0, 3),
                                                blurRadius: 5,
                                                color: Colors.grey
                                              )
                                            ]
                                          ),
                                        height: 170,
                                        width: 150,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          child: Image.asset(
                                            getWaveGif(tank2Percentage),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Text(datetank2,style: text5,),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 125,top: 20),
                  child: Stack(
                    children: [
                      Padding(
                            padding: const EdgeInsets.only(top: 30,left: 20),
                            child: CircleAvatar(
                              backgroundColor: tank1andsumpstatus,
                              radius: 7,
                            ),
                          ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 60),
                            child: Text('SUMP 1',style: text4,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 70),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                color: grey,
                              ),
                              height: 25,
                              width: 50,
                              child: Center(
                                child: Text(
                                  sumpPercentage,
                                  style:numbers.copyWith(color: sumpColor),
                                )
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: grey
                                    ),
                                    height: 170,
                                    width: 8  ,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12,left: 2),
                                    child: Column(
                                      children: [
                                        Container(
                                          color: green,
                                          height: 5,
                                          width: 6,
                                        ),
                                        const SizedBox(
                                          height: 55,
                                        ),
                                        Container(
                                          color: yellow,
                                          height: 5,
                                          width: 6,
                                        ),
                                        const SizedBox(
                                          height: 55,
                                        ),
                                        Container(
                                          color: red,
                                          height: 5,
                                          width: 6,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)
                                      ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 3),
                                            blurRadius: 5,
                                            color: Colors.grey
                                          )
                                        ]
                                      ),
                                    height: 170,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      child: Image.asset(
                                        getWaveGif(sumpPercentage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Text(date,style: text5,),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
    );
  }
}
