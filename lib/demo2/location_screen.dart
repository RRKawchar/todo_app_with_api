import 'package:flutter/material.dart';
import 'package:todo_app_with_api/demo2/IpInfo.dart';

class DataDisplay extends StatefulWidget {


  @override
  State<DataDisplay> createState() => _DataDisplayState();
}

class _DataDisplayState extends State<DataDisplay> {
  @override
  void initState() {
   API.fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: API.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return Column(
                children: [
                  Text("${data!['location']['country']['name']}"),
                  ClipRRect(
                    child: Image.network("${data['location']['country']['flag']['wikimedia']}",width: MediaQuery.of(context).size.width,),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}