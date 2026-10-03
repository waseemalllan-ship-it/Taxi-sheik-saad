import 'package:flutter/material.dart';

void main() => runApp(TaxiApp());

class TaxiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تاكسي الشيخ سعد',
      theme: ThemeData(primarySwatch: Colors.yellow, fontFamily: 'Cairo'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isClient = true;
  String from = 'الشيخ سعد';
  String to = 'رام الله';

  final List<String> areas = ['الشيخ سعد', 'جبل المكبر', 'السواحرة', 'رام الله', 'بيت لحم', 'القدس'];

  final Map<String, int> prices = {
    'الشيخ سعد-رام الله': 40,
    'الشيخ سعد-بيت لحم': 25,
    'الشيخ سعد-القدس': 30,
    'جبل المكبر-رام الله': 35,
    'السواحرة-رام الله': 45,
    'الشيخ سعد-جبل المكبر': 15,
  };

  int getPrice() {
    String key1 = '$from-$to';
    String key2 = '$to-$from';
    return prices[key1]?? prices[key2]?? 30;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('تاكسي الشيخ سعد 🚕', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => setState(() => isClient =!isClient),
            child: Text(isClient? 'واجهة السائق' : 'واجهة الزبون', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: isClient? buildClient() : buildDriver(),
    );
  }

  Widget buildClient() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.yellow[100], borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Icon(Icons.info),
              SizedBox(width: 8),
              Expanded(child: Text('الدفع كاش فقط 💵 - يتم الدفع للسائق مباشرة', style: TextStyle(fontWeight: FontWeight.bold)))
            ]),
          ),
          SizedBox(height: 20),
          DropdownButtonFormField(value: from, items: areas.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => from = v!), decoration: InputDecoration(labelText: 'من', border: OutlineInputBorder())),
          SizedBox(height: 12),
          DropdownButtonFormField(value: to, items: areas.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => to = v!), decoration: InputDecoration(labelText: 'إلى', border: OutlineInputBorder())),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15)),
            child: Column(children: [
              Text('سعر الرحلة', style: TextStyle(color: Colors.white70)),
              Text('${getPrice()} شيكل', style: TextStyle(color: Colors.yellow, fontSize: 40, fontWeight: FontWeight.bold)),
              Text('دفع كاش', style: TextStyle(color: Colors.white)),
            ]),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow, foregroundColor: Colors.black),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم إرسال طلبك! السائقين في الشيخ سعد سيتواصلون معك قريباً 🚕')));
              },
              child: Text('اطلب تاكسي الآن 🚕', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDriver() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text('طلبات اليوم - الشيخ سعد', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Card(child: ListTile(leading: Icon(Icons.person), title: Text('زبون من الشيخ سعد إلى رام الله'), subtitle: Text('السعر: 40 شيكل - كاش'), trailing: ElevatedButton(onPressed: () {}, child: Text('قبول')))),
        Card(child: ListTile(leading: Icon(Icons.person), title: Text('زبون من السواحرة إلى رام الله'), subtitle: Text('السعر: 45 شيكل - كاش'), trailing: ElevatedButton(onPressed: () {}, child: Text('قبول')))),
        Card(child: ListTile(leading: Icon(Icons.person), title: Text('زبون من الشيخ سعد إلى القدس'), subtitle: Text('السعر: 30 شيكل - كاش'), trailing: ElevatedButton(onPressed: () {}, child: Text('قبول')))),
      ],
    );
  }
}
