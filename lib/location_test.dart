// import 'dart:convert';
//
// import 'package:http/http.dart'as http;
// import 'package:flutter/material.dart';
//
// class LocationTest extends StatefulWidget {
//   const LocationTest({Key? key}) : super(key: key);
//
//   @override
//   State<LocationTest> createState() => _LocationTestState();
// }
//
// class _LocationTestState extends State<LocationTest> {
//
//   var item;
//
// @override
//   void initState() {
//  getLocation();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
// body: ListView.builder(,
//     itemBuilder: (context,index){
//
//   return ListTile(
//     title: Text(item['name_native']),
//   );
// }),
//     );
//   }
//   Future<void> getLocation()async{
//     const url="https://api.ipregistry.co/?key=tryout";
//     final uri=Uri.parse(url);
//     final response=await http.get(uri);
//     if(response.statusCode==200){
//
//       final json=jsonDecode(response.body) as Map;
//       dynamic result=json['currency'];
//       setState(() {
//        item=result;
//        print(item);
//       });
//     }else{
//       throw Exception();
//     }
//
//
//   }
// }
