import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:test_multiple_client/aboutus.dart';
import 'package:test_multiple_client/contact.dart';
import 'package:test_multiple_client/dashboard.dart';

import 'settings.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late IO.Socket socket;
  List<dynamic> clients = [];
   Map<String, dynamic> _latestData = {};
    Map<String, dynamic> _clientsData = {};
      int selectedIndex =0;

    List<Map<String,dynamic>> menuItems =[{"icon":const Icon(Icons.dashboard),"text":'DashBoard'},{"icon":const Icon(Icons.phone),"text":'Contact'},{"icon":const Icon(Icons.home),"text":'About Us'},{"icon":const Icon(Icons.settings),"text":'Settings'},{"icon":const Icon(Icons.logout),"text":'Logout'}];

 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      
     
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            
            child: Container(
              color: Colors.black,
              child:
            Column(children: [  
              
              const SizedBox(height: 30,),
              const Divider(),
              Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: ListTile(
                   
                    onTap:(){
                      setState(() {
                        selectedIndex=index;
                        print('selectedIndex is $selectedIndex');
                      });
                    } ,
                     selected: selectedIndex == index,
                            // tileColor: selectedIndex == index
                            //     ? Colors.blue
                            //     : Colors.black,
                   selectedTileColor: Colors.purple,
                    leading: menuItems[index]['icon'],
                    title: Text(menuItems[index]['text'],style: GoogleFonts.poppins(color:Colors.white,fontSize: 14),),),
                );
              },),
            ),],),
            
          ),),
           
          Expanded(
          flex:9,
          child:IndexedStack(
              index: selectedIndex,
              children: const [
                DashBoardPage(),
                ContactScreen(),
                AboutUsScreen(), 
                SettingsScreen(), 
                // ContactScreen(), 
              ],
            ),),

         
         
          
        ],
      ),
    );
  }
}

