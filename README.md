
A date time picker form field

## How to use

```
class MyApp extends StatelessWidget {
  final String title;
  final DateTime initialDateTime;

  MyApp({Key key, this.title, this.initialDateTime}) : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DateTimeFormField Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: title ?? 'Home Page',
        initialDateTime: initialDateTime ?? DateTime.now(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title, @required this.initialDateTime})
      : super(key: key);

  final String title;
  final DateTime initialDateTime;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> _formKey;
  DateTime _dateTime;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DateTimeFormField(
                initialValue: widget.initialDateTime,
                label: "Date Time",
                validator: (DateTime dateTime) {
                  if (dateTime == null) {
                    return "Date Time Required";
                  }
                  return null;
                },
                onSaved: (DateTime dateTime) => _dateTime = dateTime,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Date Time"),
                            content: Text(_dateTime.toIso8601String()),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Parameters
initialValue - The intial date time, default value is 'DateTime.now()'  
label - The label of form field, default value is 'Date Time'  
onlyDate - Only show and edit date, defalut value is false  
onlyTime - Only show and edit time, default value is false. onlyDate and onlyTime can not both be true.
format - The format of displaying date time in form field, default value is 'DateFormat("EE, MMM d, yyyy h:mma")' in date and time mode, 'DateFormat("EEE, MMM d, yyyy")' in date only mode, 'DateFormat("h:mm a") in time only mode  
autovalidate - Whether validate every time, default value is false  
validate - Validate function of form field  
save - Save value function of form field
  
  
> **Notice** DateTimeFormField must has Material Widget ancestor such as MaterialApp
