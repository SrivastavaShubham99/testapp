

abstract class CounterStates{}
abstract class NumArrayStates{}

class CounterStateInitials extends CounterState{
   CounterStateInitials(int counter) : super(counter :counter);
}

class CounterState extends CounterStates{
  int counter=0;
  CounterState({
    required this.counter
  });
}


class NumArrayInitialState extends NumArrayState{
  NumArrayInitialState(List<String> numArray) : super(numArray : numArray);
}

class NumArrayState extends NumArrayStates{
  var numArray=<String>[];
  NumArrayState({
    required this.numArray
});
}


