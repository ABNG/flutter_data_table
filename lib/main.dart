import 'package:flutter/material.dart';

import 'model/data.dart';

void main() {
  runApp(MyApp());
}

//we can also use paginatedDataTable. as DataTable is expensive widget. because of rows and columns combination
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _ascending = true;
  List<Data> selectedData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            DataTable(
                sortColumnIndex: 0,
                sortAscending: _ascending,
                columns: [
                  DataColumn(
                    label: Text("Name"),
                    onSort: (i, b) {
                      setState(() {
                        if (_ascending) {
                          names.sort(
                              (a, b) => a.firstName.compareTo(b.firstName));
                          _ascending = !_ascending;
                        } else {
                          //reverse sort.
                          names.sort(
                              (a, b) => b.firstName.compareTo(a.firstName));
                          _ascending = !_ascending;
                        }
                      });
                    },
                  ),
                  DataColumn(
                    label: Text(
                      "Year",
                    ),
                    onSort: (i, b) {},
                  ),
                ],
                rows: names
                    .map(
                      (name) => DataRow(
                          cells: [
                            DataCell(Text(name.firstName)),
                            DataCell(Text(name.lastName)),
                          ],
                          onSelectChanged: (b) {
                            //to get checkboxes
                            setState(() {
                              if (b)
                                selectedData.add(name);
                              else
                                selectedData.remove(name);
                            });
                          },
                          selected: selectedData.contains(
                              name)), //true mean all values selected //name.firstName == 'Bisam' ? true : false
                    )
                    .toList()),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: OutlineButton(
                    child: Text("selected ${selectedData.length}"),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: OutlineButton(
                    child: Text("Delete Selected"),
                    onPressed: () {
                      setState(() {
                        if (selectedData.isNotEmpty) {
                          List<Data> temp = [];
                          temp.addAll(selectedData);
                          for (Data data in temp) {
                            names.remove(data);
                            selectedData.remove(data);
                          }
                        }
                      });
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
