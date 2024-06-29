import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'Client_detail/view/client_detail_screen.dart';
import 'utils/colors.dart';
import 'utils/widgets.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

   late IO.Socket socket;
  List<dynamic> clients = [];
   Map<String, dynamic> _latestData = {};
    Map<String, dynamic> _clientsData = {};
     @override
  void initState() {
    super.initState();
    // Connect to the server
    socket = IO.io('http://192.168.0.137:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.on('connect', (_) {
      print('Connected: ${socket.id}');
    });

    socket.on('clients', (data) {
      //  print('Received clients update: $data'); // Ensure data is received
      setState(() {
        clients = List.from(data); // Ensure clients list is updated correctly
      });
    });
     socket.on('clientDataUpdate_', (data) {
      _clientsData={};
      print('Received JSON data: $data');
      setState(() {
        _clientsData = Map<String, dynamic>.from(data);
      });
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Container(child: Column(children: [
        Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomWidgetContainer(height: size.height*0.12,width: size.width*0.15,gradient: Appcolor.blueGradient,child:  Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Sites',style:GoogleFonts.montserrat(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                           Text('400',style:GoogleFonts.lato(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
                        ],),),
                         CustomWidgetContainer(height: size.height*0.12,width: size.width*0.15,gradient: Appcolor.blackGradient,child:  Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text('Cancelled Sites',style:GoogleFonts.montserrat(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                              Text('0',style:GoogleFonts.lato(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
                        ],),),
                         CustomWidgetContainer(height: size.height*0.12,width: size.width*0.15,gradient: Appcolor.greenGradient,child:  Column(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
                 Text('Active Sites',style:GoogleFonts.montserrat(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                 Text('375',style:GoogleFonts.lato(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
             ],),),
              CustomWidgetContainer(height: size.height*0.12,width: size.width*0.15,gradient: Appcolor.redGradient,child:  Column(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
                  Text('Inactive Sites',style:GoogleFonts.montserrat(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                  Text('380',style:GoogleFonts.lato(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
                  
             ],),),
                    ],
                  ),



                const  SizedBox(height: 30,),
                  Center(
                    child: DataTable(
                      // border: TableBorder.all(width: 0.5),
                      showCheckboxColumn: false,
                      showBottomBorder: true,
                      // decoration: BoxDecoration(border: Border.all()),
                                columns: const [
                                  DataColumn(label: Text('Client')),
                                  DataColumn(label: Text('Status')),
                                  DataColumn(label: Text('Temperature')),
                                  DataColumn(label: Text('Humidity')),
                                  DataColumn(label: Text('Timestamp(ms)')),
                                ],
                                rows: clients.map((client) {
                                  return DataRow(
                                    cells: [
                    DataCell(Text(client['id'].toString())),
                    DataCell(Text(client['data']['text'].toString())),
                    DataCell(Text(client['data']['temperature'].toStringAsFixed(2))),
                    DataCell(Text(client['data']['humidity'].toStringAsFixed(2))),
                    DataCell(Text(client['data']['timestamp'].toString())),
                                    ],
                                    onSelectChanged: (selected) async {
                    // bool isLdrData = client['data'].containsKey('temperature') && client['data'].containsKey('humidity');
                    // print(isLdrData);
                    if (selected != null && selected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClientDetailScreen(
                            clientId: client['id'].toString(),
                          ),
                        ),
                      ).then((value) {
                        // Add any necessary setState or refresh logic here
                      });
                    }
                                    },
                                  );
                                }).toList(),
                              ),
                  ),
            
                  //  Flexible(
                  //              child: Padding(
                  //                padding: const EdgeInsets.all(30.0),
                  //                child: ListView.builder(
                  //                 shrinkWrap: true,
                  //                  itemCount: clients.length,
                  //                  itemBuilder: (context, index) {
                  //                    return Column( mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
                  //                      children: [
                  //   ListTile(
                  //     tileColor: Colors.pink.shade100,
                  //     title: Text('Client -->${index+1}. ${clients[index]['id']}'),
                  //     subtitle: Text('Status: ${clients[index]['data']['text']}'),
                  //     onTap: ()async {
                  //     bool isLdrData = clients[index]['data'].containsKey('temperature') && clients[index]['data'].containsKey('humidity');
                  //     print(isLdrData);
                  //       Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //                 builder: (context) => ClientDetailScreen(clientId: clients[index]['id'].toString(),
                             
                                   
                                   
                  //                 ),
                  //   )
                  //                   ).then((value){
                  //                     setState(() {
                                        
                  //                     });
                  //                   });
                  //     },
                  //   ),
                  //   const SizedBox(height:10),
                  //   Text('Data: ${clients[index]['data']}'),
                                 
                  //                      ],
                  //                    );
                  //                  },
                  //                ),
                  //              ),
                  //            ),
                ],
              ),
            ),
            
    ],),);
  }
}