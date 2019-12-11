import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:xml_parser/xml_parser.dart';


getKey() async {
  try {
    String keyURL =
        'https://gist.githubusercontent.com/CXZ7720/838e0b7df070ddc6b01e7c699539be85/raw/5b9954083689e31a18ad9c31061e042c5bd84103/BIS_token';
    final key = await http.read(keyURL);
//    print("key == " + key);
    return key.toString();
  } catch (e) {
    print(e);
  }
}

getData(target) async {
  var key = await getKey();
  final Map<String, int> parsedData = {
    "resultCode": 0,
    "predictTime1": 0,
    "remainSeatCnt1": 0,
    "routeId": 0,
  };
//  final Xml2Json trans = Xml2Json();
  print(key);
  try {
    var url =
        'http://openapi.gbis.go.kr/ws/rest/busarrivalservice?serviceKey=' +
            key.toString() +
            '&stationId=$target' + '&routeId=216000061&staOrder=12';
    print(url);
//    var response = await http.read(url);

    XmlDocument xmlDocument = await XmlDocument.fromUri(url);

    final String resultCode = xmlDocument.getElement("resultCode").text;
    if (resultCode == "4") {
      parsedData['resultCode'] =
          int.parse(xmlDocument.getElement("resultCode").text);
      parsedData.remove('predictTime1');
      parsedData.remove('remainSeatCnt1');
      parsedData.remove('routeId');
      return parsedData;
    } else if (resultCode == "0") {
      parsedData['resultCode'] =
          int.parse(xmlDocument.getElement("resultCode").text);
      parsedData['predictTime1'] =
          int.parse(xmlDocument.getElement("predictTime1").text);
      parsedData['remainSeatCnt1'] =
          int.parse(xmlDocument.getElement("remainSeatCnt1").text);
      parsedData['routeId'] =
          int.parse(xmlDocument.getElement("routeId").text);
    }

    return parsedData;
  } catch (e) {
    print("An error occured!");
    print(e);
  }
}

class Bus {

  final int resultCode;
  final int predictTime1;
  final int remainSeatCnt1;
  final int routeId;

  Bus({this.predictTime1, this.resultCode, this.remainSeatCnt1, this.routeId});

  factory Bus.fromMap(Map<String, int> data) {
    return Bus(
      resultCode: data['resultCode'],
      predictTime1: data['predictTime1'],
      remainSeatCnt1: data['remainSeatCnt1'],
      routeId: data['remainSeatCnt1']
    );
  }

}

Future<Bus> queryBus(target) async {
  final Map bus_response = await getData(target);
  print("!!!!" + bus_response['predictTime1'].toString());

//  String predictTime1 = '0';
//  String remainSeatCnt1 = '0';
//  String routeId = '0';
//
//  final String result_code = bus_response['resultCode'];
//
//  if(result_code != "4"){
//    predictTime1 = bus_response['predictTime1'];
//    remainSeatCnt1 = bus_response['remainSeatCnt1'];
//    routeId = bus_response['routeId'];
//  }
//


//  print(bus_response);

//  result_code = bus_response.findElements('returnCode');

//  print(result_code);
  return Bus.fromMap(bus_response);
}

//@TODO : 데이터 긁어오는 것 완료. 위젯에 띄우는데 생기는 오류 고치기.