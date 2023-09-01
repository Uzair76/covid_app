import 'package:covid_tracker/Models/WorldStatesModel.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'country_details.dart';

import '../Services/states_sevices.dart';

class states extends StatefulWidget {
  const states({Key? key}) : super(key: key);

  @override
  State<states> createState() => _statesState();
}

class _statesState extends State<states> with TickerProviderStateMixin{
  late final AnimationController Controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa268),
    const Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices= StatesServices();

    return Scaffold(
     body: SafeArea(
       child: Padding(
         padding: EdgeInsets.all(16),
         child: Column(
           children: [
             // SizedBox(height: MediaQuery.of(context).size.height* 0.1,),
             FutureBuilder(
                 future: statesServices.fetchWorldStatesRecord(),

                 builder: (context, AsyncSnapshot<WorldStatesModel> snapshot)
                 {
                   if(!snapshot.hasData){
                    return Expanded(
                     flex: 1,
                       child: SpinKitFadingCircle(
                        color: Colors.white,
                         size: 50.0,
                         controller: Controller,
                       ),
                     );
                   }else
                   {
                    return Column(
                       children: [
                         PieChart(
                           dataMap:{
                             "Total": double.parse(snapshot.data!.cases!.toString()),
                             "Recover": double.parse(snapshot.data!.recovered.toString()),
                             "Death": double.parse(snapshot.data!.deaths.toString()),
                           },
                           chartValuesOptions: const ChartValuesOptions(
                             showChartValuesInPercentage: true,

                           ),
                           animationDuration: Duration(milliseconds: 1200),
                           legendOptions: const LegendOptions(
                               legendPosition: LegendPosition.left
                           ),
                           chartType: ChartType.ring,
                           colorList: colorlist,
                         ),
                         Padding(
                           padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height* 0.06),
                           child: Card(
                             child: Column(
                               children: [
                                 ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString(),),
                                 ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                 ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                 ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                 ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                 //ReuseableRow(title: 'Tests', value: snapshot.data!.tests.toString()),


                               ],
                             ),
                           ),
                         ),
                         GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesListScreen()));
                             },
                           child: Container(
                             height: 50,
                             decoration: BoxDecoration(
                               color: Color(0xff1aa268),
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: const Center(
                               child: Text("Track Countries"),
                             ),
                           ),
                         )
                       ],
                     );
                   }
                 }),

           ],
         ),
       ),
     )


    );
  }
}
class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({Key? key,required this.title ,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 10,),
          Divider(),
        ],
      ),
    );
  }
}
