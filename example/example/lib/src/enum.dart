enum OldEnum { case1, case2 }

enum NewEnum {
  case1('1'),
  case2('2');

  const NewEnum(this.value);
  final String value;
}
