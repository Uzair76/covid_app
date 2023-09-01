import 'package:flutter/material.dart';
import 'states.dart';

class DeatailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases , totalDeaths , todayRecovered, active , critical , tests ;
  DeatailScreen({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.tests,
});

  @override
  State<DeatailScreen> createState() => _DeatailScreenState();
}

class _DeatailScreenState extends State<DeatailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [

              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.067,),
                      ReuseableRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReuseableRow(title: 'Recovered', value: widget.todayRecovered.toString()),
                      ReuseableRow(title: 'Death', value: widget.totalDeaths.toString()),
                      ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          )
        ],
      ),
    );
  }
}

