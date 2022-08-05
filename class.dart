import 'mc.dart';
import 'controllers.dart';

class Test extends MC {
  late String? type_id = 'test';
  late Map<String, dynamic> controllers;
  bool expended = true;
  String? id;

  Test(Map<String, dynamic> data) {
    this.type_id = 'test';
    this.controllers = TestController();
    controllers.addAll(data);
  }

  update() {}

  clone() {
    var _terms = Test(this.jsonToController(this.getJson()));
    _terms.id = this.id;
    _terms.update();
    return _terms;
  }

  //turn json to flutter TextController
  jsonToController(dynamic json) {
    Map template = TestController()[type_id];
    return this.templateBuilderFromJson(template, json);
  }
}
