import 'package:covid_tracker_app/View/detail_screen.dart';
import 'package:covid_tracker_app/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: ' Search with a country name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: stateServices.countriesListApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      //!has no data
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100,
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
                                          width: 89,
                                          color: Colors.white,
                                        ),
                                        subtitle: Container(
                                          height: 10,
                                          width: 89,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ));
                            });
                      } else {
                        //!has data
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if (searchController.text.isEmpty) {
                                return Column(
                                  children: [
                                    //!fetching without model
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      name:
                                                          snapshot.data![index]
                                                              ['country'],
                                                      image: snapshot
                                                                  .data![index]
                                                              ['countryInfo']
                                                          ['flag'],
                                                      totalCases:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      totalRecovered:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      totalDeaths:
                                                          snapshot.data![index]
                                                              ['deaths'],
                                                      active:
                                                          snapshot.data![index]
                                                              ['active'],
                                                      test:
                                                          snapshot.data![index]
                                                              ['tests'],
                                                      todayRecovered: snapshot
                                                              .data![index]
                                                          ['todayRecovered'],
                                                      critical:
                                                          snapshot.data![index]
                                                              ['critical'],
                                                    )));
                                      },
                                      child: ListTile(
                                        leading: Image(
                                            height: 55,
                                            width: 60,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag'])),
                                        title: Text(
                                          snapshot.data![index]['country'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                      ),
                                    )
                                  ],
                                );
                              } else if (name.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    //!fetching without model
                                    InkWell(
                                      onTap: () {
                                        onTap:
                                        () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailScreen(
                                                        name: snapshot
                                                                .data![index]
                                                            ['country'],
                                                        image: snapshot.data![
                                                                    index]
                                                                ['countryInfo']
                                                            ['flag'],
                                                        totalCases: snapshot
                                                                .data![index]
                                                            ['cases'],
                                                        totalRecovered: snapshot
                                                                .data![index]
                                                            ['cases'],
                                                        totalDeaths: snapshot
                                                                .data![index]
                                                            ['deaths'],
                                                        active: snapshot
                                                                .data![index]
                                                            ['active'],
                                                        test: snapshot
                                                                .data![index]
                                                            ['tests'],
                                                        todayRecovered: snapshot
                                                                .data![index]
                                                            ['todayRecovered'],
                                                        critical: snapshot
                                                                .data![index]
                                                            ['critical'],
                                                      )));
                                        };
                                      },
                                      child: ListTile(
                                        leading: Image(
                                            height: 60,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag'])),
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            });
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
