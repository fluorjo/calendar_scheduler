class ScheduleModel {
  final int startTime;
  final int endTime;
  final String content;
  final String id;
  final DateTime date;

  ScheduleModel({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.content,
  });

  ScheduleModel.fromJson({
    required Map<String, dynamic> json,
  })  : id = json['id'],
        content = json['content'],
        date = DateTime.parse(json['date']),
        startTime = json['startTime'],
        endTime = json['endTime'];

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'content': content,
      'date':
          '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  ScheduleModel copyWith({
    int? startTime,
    int? endTime,
    String? content,
    String? id,
    DateTime? date,
  }) {
    return ScheduleModel(
        id: id ?? this.id,
        //?? 기호 = 만약 이 값이 null이면 뒤의 값을 가져와라. ,
        //즉 만약 id가 null이면 this.id를 가져와라. 
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        content: content ?? this.content);
  }
}
