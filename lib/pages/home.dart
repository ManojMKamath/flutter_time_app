import 'package:flutter/material.dart';

class Home extends StatefulWidget {
@override
_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};
  List lists = [];

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    //background
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      appBar: AppBar(
        title: const Text('World Time'),
      ),
      drawer: Drawer(
        elevation: 20,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color:Colors.blue[900],
              ),
              child: Text('Settings',
                style: TextStyle(color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            VerticalDivider(color: Colors.grey[150]),
            SizedBox(height:35),
            ListTile(
              leading: Icon(Icons.edit_location),
              title: Text('Edit Location'),
              onTap: () async{
                dynamic result = await Navigator.pushNamed(context, '/location');
                setState(() {
                  data = {
                    'time' : result['time'],
                    'location' : result['location'],
                    'flag' : result['flag'],
                    'isDayTime' : result['isDayTime']
                  };
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: Column(
                children: <Widget>[
                  SizedBox(height:20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    data['time'],
                    style:TextStyle(
                      color: Colors.white,
                      fontSize: 66,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
