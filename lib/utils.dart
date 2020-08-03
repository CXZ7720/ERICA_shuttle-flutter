
var now = new DateTime.now().toLocal();

String getDateKind (decoded_json) {
//  print(decoded_json['calendar'][0]['semester']);
  Map<String, dynamic> semester = decoded_json['calendar'][0]['semester'];
  Map<String, dynamic> vacation_session = decoded_json['calendar'][1]['vacation_session'];
  Map<String, dynamic> vacation = decoded_json['calendar'][2]['vacation'];

  String semesterStart = semester['start'].toString().replaceAll("-", "");
  String semesterEnd = semester['end'].toString().replaceAll("-", "");
  String vacationStart = vacation['start'].toString().replaceAll("-", "");
  String vacationEnd = vacation['end'].toString().replaceAll("-", "");
  String vacationSessionStart = vacation_session['start'].toString().replaceAll("-", "");
  String vacationSessionEnd = vacation_session['end'].toString().replaceAll("-", "");


//  print(newstr);
  //"사이에 있는지"를 검사하기 때문에 하루를 더하고 뺴줌.
  if(now.isAfter(DateTime.parse(semesterStart).subtract(new Duration(days: 1))) & now.isBefore(DateTime.parse(semesterEnd).add(new Duration(days: 1)))){
    //  학기중
    return "semester";
  } else if(now.isAfter(DateTime.parse(vacationSessionStart).subtract(new Duration(days: 1))) & now.isBefore(DateTime.parse(vacationSessionEnd).add(new Duration(days: 1)))){
    // 계절학기중
    return "vacation_session";
  } else if(now.isAfter(DateTime.parse(vacationStart).subtract(new Duration(days: 1))) & now.isBefore(DateTime.parse(vacationEnd).add(new Duration(days: 1)))){
    // 방학중
    return "vacation";
  } else {
    //에러일 경우 운행안함처리.
    return "halt";
  }

}

String getDaykind(decoded_json) {
  switch(now.weekday) {
    case 6:
      return 'weekend';
    case 7:
      return 'weekend';
    default:
      return "week";
  }
}