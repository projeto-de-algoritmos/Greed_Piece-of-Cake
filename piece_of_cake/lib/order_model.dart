import 'dart:convert';

class OrderModel {
  final String? name;
  final String? duration;
  final String? deadline;
  final String? start;
  final String? end;
  final String? lateness;
  OrderModel({
    this.name,
    this.duration,
    this.deadline,
    this.start,
    this.end,
    this.lateness,
  });

  OrderModel copyWith({
    String? name,
    String? duration,
    String? deadline,
    String? start,
    String? end,
    String? lateness,
  }) {
    return OrderModel(
      name: name ?? this.name,
      duration: duration ?? this.duration,
      deadline: deadline ?? this.deadline,
      start: start ?? this.start,
      end: end ?? this.end,
      lateness: lateness ?? this.lateness,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
      'deadline': deadline,
      'start': start,
      'end': end,
      'lateness': lateness,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      name: map['name'],
      duration: map['duration'],
      deadline: map['deadline'],
      start: map['start'],
      end: map['end'],
      lateness: map['lateness'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(name: $name, duration: $duration, deadline: $deadline, start: $start, end: $end, lateness: $lateness)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.name == name &&
        other.duration == duration &&
        other.deadline == deadline &&
        other.start == start &&
        other.end == end &&
        other.lateness == lateness;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        duration.hashCode ^
        deadline.hashCode ^
        start.hashCode ^
        end.hashCode ^
        lateness.hashCode;
  }
}
