# -----USAGE EXAMPLE-----
`
import 'class.dart';
import 'stores.dart';

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  Test doc = Test(data);

  var args;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: "Tuitle",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                TextField(
                  controller: doc.controllers['data']['field1'],
                ),
                TextField(
                  controller: doc.controllers['data']['field2'],
                ),
                TextField(
                  controller: doc.controllers['data']['field3'],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
`