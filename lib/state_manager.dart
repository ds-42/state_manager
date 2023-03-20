library state_manager;

import 'package:flutter/widgets.dart';

class StateManager {

  final BuildContext context;
  final Stater<StateManager> stater;

  StateManager(this.context, this.stater);

  void setState(VoidCallback fn) {
    var state = (stater.key as GlobalKey<_Stater>).currentState;
    if(state == null) return;

    // ignore: invalid_use_of_protected_member
    state.setState(fn);
  }

  void initState() { }

  void invalidate() => setState(() { });

  void dispose() { }

}


class Stater<T extends StateManager> extends StatefulWidget {
  final Widget Function(T) builder;
  final T Function(BuildContext, Stater<T>)? stateBuilder;

  Stater({
    required this.builder,
    this.stateBuilder}) :
        super(key: GlobalKey<_Stater<T>>());

  @override
  State<Stater> createState() => _Stater<T>();

}


class _Stater<T extends StateManager> extends State<Stater<T>> {

  T? _stateManager;
  T get stateManager => _stateManager!;

  @override
  void initState() {
    _stateManager = widget.stateBuilder == null
        ? StateManager(context, widget) as T // exception if T is not StateContext
        : widget.stateBuilder!(context, widget);
    stateManager.initState();
    super.initState();
  }

  @override
  void dispose() {
    if(_stateManager != null) {
      stateManager.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(stateManager);
  }

}

