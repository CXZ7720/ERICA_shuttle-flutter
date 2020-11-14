
var now = new DateTime.now().toLocal();

String getDateKind (decoded_json) {
//  print(decoded_json['calendar'][0]['semester']);
  Map<String, dynamic> semester1 = decoded_json['calendar'][0]['semester'][0];
  Map<String, dynamic> semester2 = decoded_json['calendar'][0]['semester'][1];
  Map<String, dynamic> vacation_session = decoded_json['calendar'][1]['vacation_session'];
  Map<String, dynamic> vacation = decoded_json['calendar'][2]['vacation'];

  String semester1_Start = semester1['start'].toString().replaceAll("-", "");
  String semester1_End = semester1['end'].toString().replaceAll("-", "");

  String semester2_Start = semester2['start'].toString().replaceAll("-", "");
  String semester2_End = semester2['end'].toString().replaceAll("-", "");

  String vacationStart = vacation['start'].toString().replaceAll("-", "");
  String vacationEnd = vacation['end'].toString().replaceAll("-", "");
  String vacationSessionStart = vacation_session['start'].toString().replaceAll("-", "");
  String vacationSessionEnd = vacation_session['end'].toString().replaceAll("-", "");
  print(semester2_Start);
  //print(newstr);
  //"사이에 있는지"를 검사하기 때문에 하루를 더하고 뺴줌.
  print(isInDate(semester1_Start, semester1_End));
  print(isInDate(semester2_Start, semester2_End));
  if(isInDate(semester1_Start, semester1_End) || isInDate(semester2_Start, semester2_End)){
    //  학기중
    return "semester";
  } else if(isInDate(vacationSessionStart, vacationSessionEnd)){
    // 계절학기중
    return "vacation_session";
  } else if(isInDate(vacationStart, vacationEnd)){
    // 방학중
    return "vacation";
  } else {
    //에러일 경우 운행안함처리.
    return "halt";
  }

}
bool isInDate(String startDate, String endDate) {
  // ex ) now = 2020/11/14, start = 2020/09/01, end = 2020/12/22, output = true
  bool isAfter = now.isAfter(DateTime.parse(startDate).subtract(new Duration(days: 1)));
  bool isBefore = now.isBefore(DateTime.parse(endDate).add(new Duration(days: 1)));
  return isAfter & isBefore;
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