# state_manager

State manager for flutter widgets

## ChangeLog

[ChangeLog.md](CHANGELOG.md)

## About

State manager allows you to separate the business logic of managing the state of the model and its presentation

## Features

## Getting started

## Usage

Below is a basic sample application using the state_manager library

```dart
import 'package:flutter/material.dart';
import 'package:state_manager/state_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyStaterPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyStaterPage extends StatelessWidget {
  const MyStaterPage({super.key, required this.title});

  final String title;

  static int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Stater<StateManager>(
        builder: (stater) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                _counter++;
                stater.invalidate();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
    );
  }
}
```

Let's take out the logic of processing the states of the counter in a separate class CounterState.
stateBuilder is used to create a counter state management context

```dart
class MyStaterPage extends StatelessWidget {
  const MyStaterPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stater<CounterState>(
      stateBuilder: (context, stater) => CounterState(context, stater),
      builder: (stater) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '${stater.counter}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => stater.counter++,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      }
    );
  }
}

class CounterState extends StateManager {
  CounterState(super.context, super.stater);

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    if(_counter == value) return;
    _counter = value;
    invalidate();
  }
}
```

Now all counter state management logic can be performed in a separate CounterState class.
For example, let's add emulation of a long wait for a response from the server

```dart
class CounterState extends StateManager {
  CounterState(super.context, super.stater);

  int _counter = 0;
  int get counter => _counter;
  set counter(int value) {
    if(_counter == value) return;

    Future.delayed(const Duration(seconds: 1), () {
      _counter = value;
      invalidate();
    });
  }
}
```
Now we can expand and add more options to control the counter state logic

## Additional information

