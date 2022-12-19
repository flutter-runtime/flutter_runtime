enum OldEnum { case1, case2 }

enum NewEnum {
  case1('1'),
  case2;

  final String name;
  const NewEnum([this.name = '']);
}
