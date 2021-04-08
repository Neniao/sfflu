import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class Constants {
  static final String survey1 = "{\"Title\":\"survey1\",\"Creator\":\"abc\",\"Date\":\"12.11\",\"Questions\":[{\"QuestionInfo\":\"what’s your name?\",\"QuestionType\":\"input\"},{\"QuestionInfo\":\"what’s your favoriate color?\",\"QuestionType\":\"selection\",\"Items\":[\"banana\",\"apple\",\"orange\",\"lemon\"]}]}";
  static final int ConstantB = 100;
  static final surveyDir = "surveys";
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
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  bool survey_on_tap = false;
  int survey_status = 0;
  int question_status = 0;
  List<dynamic> surveys =  List<dynamic>();

  _MyHomePageState() {
    Map<String,dynamic> map = json.decode(Constants.survey1);
    print(map);
    surveys.add(map);
    print(surveys[0]['Title']);
    print('survey_on_tap');
    print(survey_on_tap);
    // Get the survey directory.



    getExternalStorageDirectory().then((dir)=>_loadSurveyPath(dir.path+'/'+Constants.surveyDir));
    // List directory contents, recursing into sub-directories,
    // but not following symbolic links.
    /*
    var dirStream=surDir.list(recursive: true, followLinks: false);
    print('in constructor dirlist:');
    print(dirStream);
    dirStream.forEach((element) {
      print('in constructor for each');
      print('element');
    });


     */
  }
  void _loadSurveyPath(String path){
    print('int loading survey path:');
    print(path);
    var surDir = Directory(path);
    var dirStream=surDir.list(recursive: true, followLinks: false);
    dirStream.forEach((element) {
      print('in surDir for each');
      print(element);
      File(element.path).readAsString().then((content) {
        _loadSurvey(content);
      });
    });
  }
  void _loadSurvey(String content){
    print('in load survey');
    print(content);
    Map<String,dynamic> map = json.decode(content);
    surveys.add(map);
  }
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  void _surveyOnTap(int x) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      survey_status=x;
      survey_on_tap=true;
    });
  }
  void _nextOnPressed(){
    int _len=surveys[survey_status]['Questions'].length;
    print('in _nextOnPressed: _len');
    print(_len);
    if (question_status<_len -1){
      setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
        question_status++;
        print('question_status');
        print(question_status);
      });
    }
  }
  void _backOnPressed(){
    int _len=surveys[survey_status]['Questions'].length;
    print('in _backOnPressed: _len');
    print(_len);
    if (question_status>0){
      setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
        question_status--;
        print('question_status');
        print(question_status);
      });
    }
  }
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
      body:Builder(
        builder:(context){
          print('survey_status:');
          print(survey_status);
          // if no survey was selected, display the default main body
          if (!survey_on_tap){
            return  Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Please select a survey to view',
                  ),
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            );
          }
          //if survey was selected, display the survey
          //should based on survey_stauts and question_status
          if (survey_on_tap){
            //return input type question
            if (surveys[survey_status]['Questions'][question_status]['QuestionType']=='input') {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${surveys[survey_status]['Questions'][question_status]['QuestionInfo']}'),
                      TextField(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                              onPressed: () => _backOnPressed(),
                              child:Text('Back')
                          ),
                          TextButton(
                              onPressed: () => _nextOnPressed(),
                              child: Text('Next')
                          ),
                        ],
                      )
                    ],
                  )
              );
            }
            //return selection type question
            if (surveys[survey_status]['Questions'][question_status]['QuestionType']=='selection') {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${surveys[survey_status]['Questions'][question_status]['QuestionInfo']}'),
                      Text('${surveys[survey_status]['Questions'][question_status]['Items'][0]}'),
                      Text('${surveys[survey_status]['Questions'][question_status]['Items'][1]}'),
                      Text('${surveys[survey_status]['Questions'][question_status]['Items'][2]}'),
                      Text('${surveys[survey_status]['Questions'][question_status]['Items'][3]}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                              onPressed:(){
                                _backOnPressed();
                              },
                              child:Text('Back')
                          ),
                          TextButton(
                              onPressed:(){
                                _nextOnPressed();
                              },
                              child: Text('Next')
                          ),
                        ],
                      )
                    ],
                  )
              );
            }
          }
        }
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.

        child: ListView.builder(
          itemCount:surveys.length,
          itemBuilder: (context,index){
            return Card(
                child:ListTile(
                  title:Text('${surveys[index]['Title']}'),
                  onTap:(){
                    Navigator.pop(context);
                    _surveyOnTap(index);
                  }
                )

            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
