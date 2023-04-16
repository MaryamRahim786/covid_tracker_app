import 'package:covid_tracker_app/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen({
    super.key,
    required this.name,
    required this.image,
    // required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.todayRecovered,
    required this.totalRecovered,
    required this.test,
    required this.active,
    required this.critical,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

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
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      ReuseableRow(
                          title: 'Cases', value: widget.totalCases.toString()),
                      ReuseableRow(
                          title: 'Deaths',
                          value: widget.totalDeaths.toString()),
                      ReuseableRow(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString()),
                      ReuseableRow(
                          title: 'Active', value: widget.active.toString()),
                      ReuseableRow(
                          title: 'Critical', value: widget.critical.toString()),
                      ReuseableRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString()),
                      ReuseableRow(
                          title: 'Test', value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
               CircleAvatar(
                radius: 59,
                backgroundImage: NetworkImage(widget.image.toString()),
                backgroundColor: Color.fromARGB(255, 216, 224, 193),
              )
            ],
          )
        ],
      ),
    );
  }
}
