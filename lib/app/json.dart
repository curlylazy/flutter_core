import 'dart:convert';

class IJson {
  var name = "";
  var tablesArr = {};
  var rowArr = {};
  var rowArrs = [];

  newTable(tablename) {
    this.name = tablename;
  }

  addRow(rowname, value) {
    this.rowArr[rowname] = value;
  }

  endRow() {
    this.rowArrs.add(this.rowArr);
    this.rowArr = {};
  }

  addRowFromObject(obj) {
    this.rowArrs.add(obj);
    this.rowArr = {};
  }

  createTableFromObjectCollection(obj) {
    this.tablesArr[this.name] = obj;
    this.name = "";
  }

  createTable() {
    this.tablesArr[this.name] = this.rowArrs;
    this.name = "";
  }

  generateJson() {
    var str = jsonEncode(this.tablesArr);
    return str;
  }

  static jsontodata(data, name) {
    var ret = []; // error parse //
    try {
      var obj = jsonDecode(data);
      ret = obj[name];
      return ret;
    } catch (e) {
      ret = [];
      return ret;
    }
  }
}
