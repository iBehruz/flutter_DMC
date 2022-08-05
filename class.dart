import 'mc.dart';
import 'controllers.dart';

class Test extends MC {
  late Map<String, dynamic> controllers;

  Test(Map<String, dynamic> data) {
    this.controllers = jsonToController(data);
  }

  update() {}

  clone() {
    var _terms = Test(this.jsonToController(this.getJson()));
    _terms.update();
    return _terms;
  }

  //turn json to flutter TextController
  jsonToController(dynamic json) {
    Map template = TestController();
    return this.templateBuilderFromJson(template, json);
  }
}
