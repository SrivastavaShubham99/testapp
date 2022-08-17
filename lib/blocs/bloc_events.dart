

abstract class CounterInitials{}
abstract class NumArrayInitials{}

class IncrementCounterEvent extends CounterInitials{}
class DecrementCounterEvent extends CounterInitials{}

class IncrementNumArrays extends NumArrayInitials{
  var tempArray=<String>[];
  IncrementNumArrays(this.tempArray);
}
class DecrementNumArrays extends NumArrayInitials{
  var tempArray=<String>[];
  DecrementNumArrays(this.tempArray);
}



