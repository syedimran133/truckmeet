// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:truckmeet/src/events/TruckData.dart';
import 'package:truckmeet/src/events/UserData.dart';
import 'EventsData.dart';
import 'UrlData.dart';

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

  static Future<List<UserData>> getUseruid(String uid) async {
    final snapshot = await FirebaseDatabase.instance.ref('user/' + uid).get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    print(map); // to debug and see if data is returned
    List<UserData> list = [];
    final user = UserData.fromMap(map);
    list.add(user);
    return list;
  }
  static Future<UrlData> getUrls() async {
    final snapshot = await FirebaseDatabase.instance.ref('url').get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    final user = UrlData.fromMap(map);
    return user;
  }
  static Future<List<UserData>> getHostUid(String uid) async {
    final snapshot = await FirebaseDatabase.instance.ref('user/' + uid).get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    print(map); // to debug and see if data is returned
    List<UserData> list = [];
    final user = UserData.fromMap(map);
    list.add(user);
    return list;
  }
  //.child("events").child(event_uid).child(event_id).child("attendee").child(uid!).
  static Future<List<UserData>> getAttendee(
      String event_uid, String event_id, String uid) async {
    final snapshot = await FirebaseDatabase.instance
        .ref("events/" + event_uid + "/" + event_id + "/attendee/" + uid)
        .get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    print(map); // to debug and see if data is returned
    List<UserData> list = [];
    final user = UserData.fromMap(map);
    list.add(user);
    return list;
  }

  static Future<List<UserData>> getAttendeeList(
      String event_uid, String event_id) async {
    final snapshot = await FirebaseDatabase.instance
        .ref("events/" + event_uid + "/" + event_id + "/attendee")
        .get();
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
    List<UserData> list = [];
    try {
      final snapshot = await FirebaseDatabase.instance.ref('user/' + uid).get();
      final map = snapshot.value as Map<dynamic, dynamic>;
      print(map); // to debug and see if data is returned

      final user = UserData.fromMap(map);
      list.add(user);
    } catch (e) {
      print(e);
    }
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
    await FirebaseFirestore.instance
        .collection("events_locations")
        .doc(id)
        .delete();
  }

  static Future<List<UserData>> getUserList() async {
    final snapshot = await FirebaseDatabase.instance.ref('user').get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    print(map); // to debug and see if data is returned
    List<UserData> list = [];
    for (var i = 0; i < map.length; i++) {
      final inner_map = Map.from(map.values.elementAt(i));
      final user = UserData.fromMap(inner_map);
      list.add(user);
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
