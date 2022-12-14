// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:truckmeet/src/events/TruckData.dart';
import 'package:truckmeet/src/events/UserData.dart';
import 'EventsData.dart';

class DatabaseService {
  static Future<List<EventsData>> getEmp() async {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    final snapshot = await FirebaseDatabase.instance.ref('events/' + uid).get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    print(map); // to debug and see if data is returned
    List<EventsData> list = [];
    map.forEach((key, value) {
      final user = EventsData.fromMap(value);
      list.add(user);
    });
    return list;
  }

  static Future<List<String>> getEventKey() async {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    final snapshot = await FirebaseDatabase.instance.ref('events/' + uid).get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    List<String> list = [];
    map.forEach((key, value) {
      list.add(key);
    });
    return list;
  }

  static Future<List<UserData>> getUser() async {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    final snapshot = await FirebaseDatabase.instance.ref('user/' + uid).get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    print(map); // to debug and see if data is returned
    List<UserData> list = [];
    map.forEach((key, value) {
      final user = UserData.fromMap(value);
      list.add(user);
    });
    return list;
  }
  static Future<List<UserData>> getUsercount(String uid) async {
    final snapshot = await FirebaseDatabase.instance.ref('user/' + uid).get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    print(map); // to debug and see if data is returned
    List<UserData> list = [];
    map.forEach((key, value) {
      final user = UserData.fromMap(value);
      list.add(user);
    });
    return list;
  }
  static Future<List<String>> getUserKey() async {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    final snapshot = await FirebaseDatabase.instance.ref('user/' + uid).get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    List<String> list = [];
    map.forEach((key, value) {
      list.add(key);
    });
    return list;
  }

  static Future<List<TruckData>> getTrucks() async {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    final snapshot = await FirebaseDatabase.instance.ref('truck/' + uid).get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    List<TruckData> list = [];
    map.forEach((key, value) {
      final user = TruckData.fromMap(value);
      list.add(user);
    });
    return list;
  }

  static Future<List<String>> getTrucksKey() async {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    final snapshot = await FirebaseDatabase.instance.ref('truck/' + uid).get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    List<String> list = [];
    map.forEach((key, value) {
      list.add(key);
    });
    return list;
  }

  static Future trucksDelete(String id) async {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    await FirebaseDatabase.instance.ref("truck/$uid/$id").remove();
  }

  static Future eventDelete(String id) async {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    await FirebaseDatabase.instance.ref("events/$uid/$id").remove();
  }

  static Future<List<UserData>> getUserList() async {
    final snapshot = await FirebaseDatabase.instance.ref('user').get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    print(map); // to debug and see if data is returned
    List<UserData> list = [];
    for (var i = 0; i < map.length; i++) {
      final inner_map = Map.from(map.values.elementAt(i));
      inner_map.forEach((key, value) {
        final user = UserData.fromMap(value);
        list.add(user);
      });
    }
    return list;
  }
  static Future<List<EventsData>> getEventListAdmin() async {
    final snapshot = await FirebaseDatabase.instance.ref('events').get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    print(map); // to debug and see if data is returned
    List<EventsData> list = [];
    for (var i = 0; i < map.length; i++) {
      final inner_map = Map.from(map.values.elementAt(i));
      inner_map.forEach((key, value) {
        final user = EventsData.fromMap(value);
        list.add(user);
      });
    }
    return list;
  }

}
