import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'network.state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  late final StreamSubscription _subscription;

  NetworkCubit() : super(NetworkInitial()) {
    // 🔍 Initial check
    _checkInitialConnection();

    // 🔁 Listen for changes
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      final isConnected =
          results.contains(ConnectivityResult.wifi) ||
          results.contains(ConnectivityResult.mobile);

      if (isConnected) {
        emit(NetworkConnected());
      } else {
        emit(NetworkDisconnected());
      }
    });
  }

  Future<void> _checkInitialConnection() async {
    final results = await Connectivity().checkConnectivity();

    final isConnected =
        results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.mobile);

    if (isConnected) {
      emit(NetworkConnected());
    } else {
      emit(NetworkDisconnected());
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  void checkConnection() async {
    final result = await Connectivity().checkConnectivity();

    if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile)) {
      emit(NetworkConnected());
    } else {
      emit(NetworkDisconnected());
    }
  }
}
