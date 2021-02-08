import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
void main() {
  runApp(MyApp(

  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Custom widgets'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

// final List<Employee> _employees = <Employee>[];

@override
void initState() {
  super.initState();
  populateData();
}
  
void populateData() {
  _employees.add(Employee(10001, 'James', 'Project Lead', 20000));
  _employees.add(Employee(10002, 'Kathryn', 'Manager', 30000));
  _employees.add(Employee(10003, 'Lara', 'Developer', 15000));
  _employees.add(Employee(10004, 'Michael', 'Designer', 15000));
  _employees.add(Employee(10005, 'Martin', 'Developer', 15000));
  _employees.add(Employee(10006, 'Newberry', 'Developer', 15000));
  _employees.add(Employee(10007, 'Balnc', 'Developer', 15000));
  _employees.add(Employee(10008, 'Perry', 'Developer', 15000));
  _employees.add(Employee(10009, 'Gable', 'Developer', 15000));
  _employees.add(Employee(10010, 'Grimes', 'Developer', 15000));
}
final EmployeeDataSource _employeeDataSource = EmployeeDataSource();

final data = Employee(1,"test","SE", 111222);
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:SfDataGrid(
      source: _employeeDataSource,
      columns: [
        GridNumericColumn(mappingName: 'id', headerText: 'ID'),
        GridTextColumn(mappingName: 'name', headerText: 'Name'),
        GridTextColumn(mappingName: 'designation', headerText: 'Designation'),
        GridNumericColumn(mappingName: 'salary', headerText: 'Salary'),
      ],
      selectionMode: SelectionMode.single,
      onCellDoubleTap:(DataGridCellDoubleTapDetails args){
        // my actions goes here
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChartScreen(data: data)),
            );
      } ,
    ),
    );
}
}


class ChartScreen extends StatelessWidget {

  final Employee data;
  ChartScreen ({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cartesian Chart"),
      ),
      body: Center(
      child: Container(
          //Initialize chart
          child: SfCartesianChart(
            // Initialize category axis
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                    // Initialize line series
                            LineSeries<SalesData, String>(
                            dataSource: [
                                // Bind data source
                                SalesData('Jan', 35),
                                SalesData('Feb', 28),
                                SalesData('Mar', 34),
                                SalesData('Apr', 32),
                                SalesData('May', 40)
                            ],
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales)
                        ]
          )
      )
      )
    );
  }
}

// chart data for testing
   class SalesData{
        SalesData(this.year, this.sales);
        final String year;
        final double sales;
    }

// data for chart
class Data {
  Data(this.id, this.salary);
  final int id;
  final int salary;
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}


final List<Employee> _employees = <Employee>[];

final EmployeeDataSource _employeeDataSource = EmployeeDataSource();

class EmployeeDataSource extends DataGridSource<Employee> {
  @override
  List<Employee> get dataSource => _employees;
  
  @override
  getValue(Employee employee, String columnName) {
    switch (columnName) {
      case 'id':
        return employee.id;
        break;
      case 'name':
        return employee.name;
        break;
      case 'salary':
        return employee.salary;
        break;
      case 'designation':
        return employee.designation;
        break;
      default:
        return ' ';
        break;
    }
  }
}