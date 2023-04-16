import 'package:covid_tracker_app/View/countries_list.dart';
import 'package:covid_tracker_app/models/world_states_model.dart';
import 'package:covid_tracker_app/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final ColorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      // backgroundColor: const Color.fromARGB(66, 83, 81, 81),
      // appBar: AppBar(
      //   title: const Text('World_States'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.1,
            // ),
            FutureBuilder(
                future: stateServices.fetchWorldStatesRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        child: SpinKitFadingCircle(
                      color: Colors.green,
                      size: 50,
                      controller: _controller,
                    ));
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06),
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Deaths':
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: const [
                            Color.fromARGB(255, 82, 183, 85),
                            Color.fromARGB(255, 59, 180, 255),
                            Colors.red
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .04),
                          child: Card(
                            // color: Colors.white54,
                            elevation: 0,
                            child: Column(
                              children: [
                                ReuseableRow(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString()),
                                ReuseableRow(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString()),
                                ReuseableRow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                ReuseableRow(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString()),
                                ReuseableRow(
                                    title: 'Critical',
                                    value: snapshot.data!.critical.toString()),
                                ReuseableRow(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                ReuseableRow(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CountriesListScreen()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 59, 180, 255),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  'Track Countries',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.6,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 13, bottom: 6),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Text(value)
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
