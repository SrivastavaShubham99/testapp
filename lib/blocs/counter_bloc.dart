

import 'package:bloc/bloc.dart';
import 'package:bloc_experiment/blocs/bloc_events.dart';
import 'package:bloc_experiment/blocs/bloc_states.dart';


class CounterBloc extends Bloc<CounterInitials,CounterState>{
  CounterBloc(int initialState) : super(CounterStateInitials(0)){
   on<IncrementCounterEvent>(_handleIncrementCounter);
   on<DecrementCounterEvent>(_handleDecrementCounter);
  }

  _handleIncrementCounter(IncrementCounterEvent event,Emitter<CounterState> emit){
    emit(CounterState(
      counter: state.counter+1
    ));
  }
  _handleDecrementCounter(DecrementCounterEvent event,Emitter<CounterState> emit){
    emit(CounterState(
      counter: state.counter-1
    ));
  }
}


class NumArrayBloc extends Bloc<NumArrayInitials,NumArrayState>{
  NumArrayBloc(List<String> initialState) : super(NumArrayInitialState([''])){
    on<IncrementNumArrays>(_handleIncrementArrays);
    on<DecrementNumArrays>(_handleDecrementArrays);
  }

  _handleIncrementArrays(IncrementNumArrays event,Emitter<NumArrayState> emit){
    emit(NumArrayState(numArray: event.tempArray));
  }
  _handleDecrementArrays(DecrementNumArrays event,Emitter<NumArrayState> emit){
    emit(NumArrayState(numArray: event.tempArray));
  }
}

