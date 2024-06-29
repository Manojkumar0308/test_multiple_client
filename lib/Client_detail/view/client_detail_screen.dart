import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../homepage.dart';
import '../../utils/colors.dart';
import '../model/client_detail_humidity.dart';
import '../model/client_detail_temp_model.dart';
import '../view_model/client_detail_view_model.dart';
import 'package:intl/intl.dart';


class ClientDetailScreen extends StatelessWidget {
  final String clientId;

  const ClientDetailScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SocketProvider()..connectToSocket(clientId),
      child: ClientDetailView(clientId: clientId),
    );
  }
}

class ClientDetailView extends StatelessWidget {
  final String clientId;

  const ClientDetailView({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final socketProvider = Provider.of<SocketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Text(
              'Client Detail',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              'Client ID: $clientId',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            socketProvider.clientData['temperature'] == 0.0 && socketProvider.clientData['humidity'] == 0.0
                ? Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: Container(
                        height: size.height * 0.12,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: Appcolor.blackGradient,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Value',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              socketProvider.clientData['lightState'].toString(),
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.12,
                            width: size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: Appcolor.pinkGradient,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.thermostat,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Temperature',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    socketProvider.clientData['temperature'].toStringAsFixed(2) + '°C',
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: size.width * 0.10),
                          AnimatedContainer(
                            height: size.height * 0.12,
                            width: size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: Appcolor.greenGradient,
                            ),
                            duration: const Duration(seconds: 5),
                            curve: Curves.easeInOut,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.waves,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Humidity',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    socketProvider.clientData['humidity'].toStringAsFixed(2) + '%',
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(height: 50),
            socketProvider.clientData['temperature'] == 0.0
                ? Icon(Icons.lightbulb,
                    size: 150, color: socketProvider.clientData['lightState'] == 1 ? Colors.black : Colors.yellow)
                : Column(
                    children: [
                      SizedBox(
                        height: size.width >= 550 ? size.height * 0.4 : size.height * 0.3,
                        width: size.width * 0.45,
                        child: SfCartesianChart(
                          primaryYAxis: const NumericAxis(
                            title: AxisTitle(
                              text: 'Temperature in Celsius',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat.Hms(),
                            title: const AxisTitle(
                              text: 'Time',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          series: <CartesianSeries>[
                            FastLineSeries<TempData, DateTime>(
                              dataSource: socketProvider.temperatureData,
                              xValueMapper: (TempData data, _) => data.time,
                              yValueMapper: (TempData data, _) => data.temperature,
                              color: Colors.red,
                            ),
                          ],
                          backgroundColor: Colors.black,
                          plotAreaBorderColor: Colors.white,
                        ),
                      ),


                      const SizedBox(height: 20),
                      SizedBox(
                        height: size.width >= 550 ? size.height * 0.4 : size.height * 0.3,
                        width: size.width * 0.45,
                        child: SfCartesianChart(
                          primaryYAxis: const NumericAxis(
                            title: AxisTitle(
                              text: 'Humidity in Percentage',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat.Hms(),
                            title: const AxisTitle(
                              text: 'Time',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          series: <CartesianSeries>[
                            FastLineSeries<HumidityData, DateTime>(
                              dataSource: socketProvider.humidityData,
                              xValueMapper: (HumidityData data, _) => data.times,
                              yValueMapper: (HumidityData data, _) => data.humidity,
                              color: Colors.blue,
                            ),
                          ],
                          backgroundColor: Colors.black,
                          plotAreaBorderColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            socketProvider.clientData['humidity'] == 0.0 ? const SizedBox() : Container(),
          ],
        ),
      ),
    );
  }
}
