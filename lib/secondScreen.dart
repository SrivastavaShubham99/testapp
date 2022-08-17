

import 'package:bloc_experiment/blocs/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bloc_events.dart';
import 'blocs/bloc_states.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  NumArrayBloc? numArrayBloc;
  int count=0;
  var countArray=<String>[];
  var responseArray=<String>[];
  @override
  Widget build(BuildContext context) {
    numArrayBloc=BlocProvider.of<NumArrayBloc>(context);
    return MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: numArrayBloc,
            listener: (BuildContext context, state) {
              if(state is NumArrayState){
                _handleNumArrayState(state);
              }
            })
        ],
        child: BlocBuilder(
          bloc: numArrayBloc,
          builder: (BuildContext context, state) {
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    const Text("second screen"),
                    Column(
                      children: responseArray.map((e){
                        return Container(
                          child:Text("Index => $e") ,
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                        onPressed: (){
                          count++;
                          countArray.add(count.toString());
                          numArrayBloc?.add(IncrementNumArrays(countArray));
                        },
                        child: const Text("one")
                    ),
                    ElevatedButton(
                        onPressed: (){},
                        child: const Text("two")
                    )
                  ],
                ),
              ),
            );
          },
        )
    );
  }

  _handleNumArrayState(NumArrayState numArrayState){
      print("state changes are ----->>>>>>>>>>${numArrayState.numArray}");
      responseArray=numArrayState.numArray;
  }
}
