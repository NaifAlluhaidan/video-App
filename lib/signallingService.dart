import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SignallingService {
  // instance of Socket
  Socket? socket;

  SignallingService._();
  static final instance = SignallingService._();

  init(
      {required String websocketUrl,
      required String websocketUrl2,
      required String selfCallerID,
      required String websocketUrl3}) {
    // init Socket
    // socket = io(websocketUrl3, {
    //   "transports": ['websocket'],
    //   "query": {"callerId": selfCallerID}
    // });
    socket = io(websocketUrl3, {
      "transports": ['websocket'],
      "query": {"callerId": selfCallerID}
    });
    // socket = io(websocketUrl2, {
    //   "transports": ['websocket'],
    //   "query": {"callerId": selfCallerID}
    // });
    // socket = io(websocketUrl3, {
    //   "transports": ['websocket'],
    //   "query": {"callerId": selfCallerID}
    // });

    Completer<IO.Socket> completer = Completer<IO.Socket>();
    checkConnectivity();

    // listen onConnect event
    socket!.onConnect((data) {
      log("Socket connected !!");
      if (!completer.isCompleted) {
        completer.complete(socket);
      }
    });

    // listen onConnectError event
    socket!.onConnectError((data) {
      log("Connect Error $data");
      if (!completer.isCompleted) {
        completer.completeError(Exception('Connection faild to !'));
      }
    });

    socket!.onConnectTimeout((data) {
      log("Connect timeout $data");
      if (!completer.isCompleted) {
        completer.completeError(Exception('Connection timeout to !'));
      }
    });

    // connect socket
    socket!.connect();
  }
}

checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
}
