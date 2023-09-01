import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../Services/states_sevices.dart';
import 'country_details.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    hintText: 'search by country name',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: statesServices.countryList(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  title: Container(
                                    height: 10,
                                    width: 90,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 90,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            baseColor: Colors.grey.shade900,
                            highlightColor: Colors.grey.shade100);
                      });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchController.text.isEmpty) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DeatailScreen(
                                            name: snapshot.data![index]
                                                ['country'],
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            totalCases: snapshot.data![index]
                                                ['cases'],
                                            totalDeaths: snapshot.data![index]
                                                ['recovered'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            tests: snapshot.data![index]
                                                ['tests'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                          )));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                )
                              ],
                            ),
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
