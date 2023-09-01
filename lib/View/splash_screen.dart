import 'dart:async';

import 'package:flutter/material.dart';
import 'states.dart';
import 'dart:math' as math;

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> with TickerProviderStateMixin {

 late final AnimationController Controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this)..repeat();

 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Controller.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) => states()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            AnimatedBuilder(
                animation: Controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Image(
                    image: AssetImage('images/Coronavirus.png')),
                ),
                builder: (BuildContext context, Widget? child){
                  return Transform.rotate(
                      angle: Controller.value * 2 * math.pi,
                  child: child,);

                }),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
            const Align(
              alignment: Alignment.center,
              child: Text('Covid19\nTracker App',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,

              ),),
            )
          ],
        ),
      ),
    );
  }
}
