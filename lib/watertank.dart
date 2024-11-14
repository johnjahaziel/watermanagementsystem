// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:watertank/utilities/constrains.dart';

class Watertank extends StatefulWidget {
  const Watertank({super.key});

  @override
  State<Watertank> createState() => _WatertankState();
}

class _WatertankState extends State<Watertank> {
  String motor_status = 'ON';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Stack(
              children: [
                SizedBox(
                  height: 180,
                  child: Image(
                    image: AssetImage('images/waterdripping.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      'WATER MANAGEMENT SYSTEM',
                      style: text1,
                    ),
                  ),
                )
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
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                color: Color(0xff444444),
                              ),
                              height: 50,
                              width: 150,
                              child:  Center(child: Text(motor_status,style: text2,)),
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
            const Padding(
              padding: EdgeInsets.only(left: 80,right: 80,top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('TANK 1',style: text4,),
                  Text('TANK 2',style: text4,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 90,right: 90,top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color(0xff444444),
                    ),
                    height: 25,
                    width: 50,
                    child: const Center(child: Text('100%',style:hundred,)),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color(0xff444444),
                    ),
                    height: 25,
                    width: 50,
                    child: const Center(child: Text('50%',style:fifty,)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 40,top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        'images/wave_gif.gif',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
                        'images/wave_gif.gif',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40,right: 40,top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('13/11/2024 - 1.00 PM',style: text5,),
                  Text('13/11/2024 - 1.00 PM',style: text5,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 145,top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('SUMP 1',style: text4,),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color(0xff444444),
                    ),
                    height: 25,
                    width: 50,
                    child: const Center(child: Text('0%',style:zero,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
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
                          'images/wave_gif.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text('13/11/2024 - 1.00 PM',style: text5,),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
