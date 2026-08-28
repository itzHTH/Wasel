/// Lenient JSON number coercion.
int intFromJson(Object? value) => switch (value) {
  num n => n.toInt(),
  String s => int.tryParse(s) ?? 0,
  _ => 0,
};

double doubleFromJson(Object? value) => switch (value) {
  num n => n.toDouble(),
  String s => double.tryParse(s) ?? 0,
  _ => 0,
};

int? nullableIntFromJson(Object? value) => switch (value) {
  num n => n.toInt(),
  String s => int.tryParse(s),
  _ => null,
};

double? nullableDoubleFromJson(Object? value) => switch (value) {
  num n => n.toDouble(),
  String s => double.tryParse(s),
  _ => null,
};
