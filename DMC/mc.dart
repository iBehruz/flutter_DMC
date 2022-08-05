abstract class MC {
  late Map<String, dynamic> controllers;

  parseToType(List types, dynamic value) {
    if (types.length < 1 || types[0] == null) return value;

    switch (types[0]) {
      case 'double':
        return parseDouble(value.toString());
      case 'String':
        return value.toString();
      case 'int':
        return parseInt(value.toString());
      default:
        return value;
    }
  }

  int parseInt(dynamic n) {
    try {
      if (n.toString().isEmpty) return 0;
      return int.parse(n.toString());
    } catch (err) {
      return 0;
    }
  }

  double parseDouble(dynamic n) {
    try {
      if (n.toString().isEmpty) return 0;
      return double.parse(n.toString());
    } catch (err) {
      return 0;
    }
  }

  literal(dynamic arr, recursive, value) {
    var r = recursive.split('.');
    if (arr[r.first.toString()] == null) {
      var type = r.first.toString().split('|');

      Map<String, dynamic> v = {type[0]: ''};
      arr.addAll(v);
    }
    if (r.length == 1) {
      var type = r.first.toString().split('|');
      r.first = type[0];
      type.removeAt(0);

      switch (value.runtimeType) {
        case TextEditingController:
          arr[r.first.toString()] = this.parseToType(type, value.text);
          break;
        case DateTime:
          arr[r.first.toString()] = DateFormat('yyyy-MM-dd').format(value);
          break;
        case irrarhClass:
          arr[r.first.toString()] = value.getJsonList();
          break;
        case TimeDate:
          arr[r.first.toString()] =
              DateFormat('yyyy-MM-dd').format(value.value);
          break;
        case Boolean:
          arr[r.first.toString()] = value.value;
          break;
        default:
          arr[r.first.toString()] = this.parseToType(type, value);
          break;
      }
      return true;
    }
    if (arr['${r.first.toString()}'].runtimeType == String)
      arr['${r.first.toString()}'] = {};
    return literal(
        arr['${r.first.toString()}'],
        recursive.substring(recursive.indexOf('.') + 1, recursive.length),
        value);
  }

  ///turn json to Flutter TextController
  templateBuilderFromJson(Map template, Map jsonDoc) {
    late Map<String, dynamic> data = {
      'dart1': {
        'k1': 'v1',
        'r1': {
          'k2': 'v2',
          'r2': {
            'k3': 'v3',
            'r3': {
              'k4': 'v4',
              'r4': {'k5': 'v5'}
            }
          }
        }
      },
      ...jsonDoc
    };

    template.forEach((key, value) {
      reverseLiteral(data, key, value);
    });
    data.remove('dart1');
    return template;
  }

  reverseLiteral(dynamic arr, recursive, value) {
    var d = DateTime.now();

    var r = recursive.split(".");
    if (arr[r.first.toString()] == null) {
      Map<String, dynamic> v = {r.first: ''};
      arr.addAll(v);
    }
    if (r.length == 1) {
      var type = r.first.toString().split('|');
      r.first = type[0];
      if (arr[r.first.toString()].toString().isNotEmpty)
        switch (value.runtimeType) {
          case TextEditingController:
            value.text = arr[r.first.toString()].toString();
            break;
          case TimeDate:
            value.set(arr[r.first.toString()]);
            break;
          case ParticipantsList:
            value.JsonListToController(arr[r.first.toString()]);
            break;
          case GoodsList:
            value.JsonListToController(arr[r.first.toString()]);
            break;
          case TermsList:
            value.JsonListToController(arr[r.first.toString()]);
            break;
          case Boolean:
            value.set(arr[r.first.toString()]);
            break;
          default:
            value = arr[r.first.toString()];
            break;
        }
      return true;
    }
    if (arr['${r.first.toString()}'].runtimeType == String)
      arr['${r.first.toString()}'] = {};

    return reverseLiteral(
        arr['${r.first.toString()}'],
        recursive.substring(recursive.indexOf('.') + 1, recursive.length),
        value);
  }

  ///turn TextController to json
  getJson() {
    late Map<String, dynamic> data = {
      'dart1': {
        'k1': 'v1',
        'kn': 1,
        'kb': true,
        'r1': {
          'k2': 'v2',
          'r2': {
            'k3': 'v3',
            'r3': {
              'k4': 'v4',
              'r4': {'k5': 'v5'}
            }
          }
        }
      }
    };
    controllers.forEach((key, value) {
      literal(data, key, value);
    });
    data.remove('dart1');
    return data;
  }

  getControllers() {
    return this.controllers;
  }

  getControllerKey(String key) {
    if (controllers[key] != null) return key;

    if (controllers[key + '|double'] != null) key += '|double';

    if (controllers[key + '|int'] != null) key += '|int';

    return key;
  }

  getControllerValue(String key) {
    if (controllers[getControllerKey(key)] == null) return null;

    if (controllers[getControllerKey(key)].runtimeType == TextEditingController)
      return controllers[getControllerKey(key)].text;

    return this.controllers[getControllerKey(key)];
  }

  get(String key) {
    if (controllers[getControllerKey(key)] == null) return null;

    if (controllers[getControllerKey(key)].runtimeType == TextEditingController)
      return controllers[getControllerKey(key)].text;

    return this.controllers[getControllerKey(key)];
  }

  set(key, value) {
    if (controllers[getControllerKey(key)] == null) return null;

    if (controllers[getControllerKey(key)].runtimeType == TextEditingController)
      return controllers[getControllerKey(key)].text = value;

    return controllers[getControllerKey(key)] = value;
  }
}
