import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_test_app/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = 'Alam';
  Future getData()async{
    List<Map<String,dynamic>> queryRows = await DatabaseHelper.queryAll();

    setState(() {
      print(queryRows);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqlite Test"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlatButton(onPressed: ()async{
            int? i = await DatabaseHelper.insert(name);
            print('the inserted id is $i');

          }, child: Text('insert'),color: Colors.blue,),
          FlatButton(onPressed: ()async{
            List<Map<String,dynamic>> queryRows = await DatabaseHelper.queryAll();
            print(queryRows.length);
          }, child: Text('query'),color: Colors.blue,),
          FlatButton(onPressed: (){}, child: Text('update'),color: Colors.blue,),
          FlatButton(onPressed: (){}, child: Text('delete'),color: Colors.blue,),
        ],
      ),
    );
  }
}
