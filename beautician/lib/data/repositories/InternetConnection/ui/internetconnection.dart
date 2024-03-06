import 'package:beautician/data/repositories/InternetConnection/bloc/internet_connection_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetConnection extends StatelessWidget {
  InternetConnection({super.key});
  InternetConnectionBloc internetConnectionBloc = InternetConnectionBloc();

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetConnectionBloc, InternetConnectionState>(
      bloc: internetConnectionBloc,
      listener: (context, state) {
        // TODO: implement listener
        if (state is InternetConnectionGainedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Internet Connected!"),
            backgroundColor: Colors.green,
          ));
        } else if (state is InternetConnectionLossState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Internet not Connected!")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Connecting... ")));
        }
      },
      child: Scaffold(
        body: Center(
          child: Text("Hello"),
        ),
      ),
    );
  }
}
