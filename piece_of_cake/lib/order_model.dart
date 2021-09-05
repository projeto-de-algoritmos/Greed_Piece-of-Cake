import 'dart:convert';

class OrderModel {
  final String? name;
  final String? duration;
  final String? deadline;
  OrderModel({
    this.name,
    this.duration,
    this.deadline,
  });

  OrderModel copyWith({
    String? name,
    String? duration,
    String? deadline,
  }) {
    return OrderModel(
      name: name ?? this.name,
      duration: duration ?? this.duration,
      deadline: deadline ?? this.deadline,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
      'deadline': deadline,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      name: map['name'],
      duration: map['duration'],
      deadline: map['deadline'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OrderModel(name: $name, duration: $duration, deadline: $deadline)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.name == name &&
        other.duration == duration &&
        other.deadline == deadline;
  }

  @override
  int get hashCode => name.hashCode ^ duration.hashCode ^ deadline.hashCode;
}
