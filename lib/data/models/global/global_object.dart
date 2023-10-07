class GlobalObject<I, V> {
  I id;
  V? value;

  GlobalObject({
    required this.id,
    this.value,
  });

  factory GlobalObject.fromJson(Map<String, dynamic> json) => GlobalObject(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
      };
}
