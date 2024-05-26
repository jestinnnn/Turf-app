import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_nest/constants.dart';
import 'package:turf_nest/models/ticket_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> bookTicket(String game, String date, int time, String price,
      String phone, String email, String bookingtime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userid = prefs.getString('userid');
    Random random = Random();
    int id = random.nextInt(1000);

    _firebaseFirestore
        .collection("users")
        .doc(userid)
        .collection("bookedtickets")
        .add({
      "ticketid": id,
      "id": userid,
      "sport": game,
      "date": date,
      "time": time,
      "status": "active",
      "price": price,
      "phone": phone,
      "email": email,
      "bookingtime": bookingtime
    });
  }

  Future<List<int>> getSlotsGreaterThanCurrentHour() async {
    int currentHour = DateTime.now().hour;
    print(currentHour);

    CollectionReference slotsCollection =
        FirebaseFirestore.instance.collection('slots');

    QuerySnapshot snapshot =
        await slotsCollection.where('slot', isGreaterThan: currentHour).get();

    List<int> slots = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null && data['slot'] != null) {
        slots.add(data['slot'] as int);
      }
    });

    return slots;
  }

  Future<List<int>> getTicketsForDate(DateTime selectedDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userid = prefs.getString('userid');

    CollectionReference usersCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('bookedtickets');

    QuerySnapshot snapshot = await usersCollection
        .where('date', isEqualTo: selectedDate.toString())
        .get();

    List<int> ticketSlots = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null && data['time'] != null) {
        ticketSlots.add(data['time'] as int);
      }
    });

    return ticketSlots;
  }

  Future<List<int>> holidayDates(DateTime selectedDate) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('holidays');

    QuerySnapshot snapshot = await usersCollection
        .where('date', isEqualTo: selectedDate.toString())
        .get();

    List<int> ticketSlots = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null && data['time'] != null) {
        ticketSlots.add(data['time'] as int);
      }
    });

    return ticketSlots;
  }

  Future<List<String>> getAllGames() async {
    List<String> names = [];

    try {
      CollectionReference institutions =
          FirebaseFirestore.instance.collection('games');

      QuerySnapshot querySnapshot = await institutions.get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String name = data['game'];
        names.add(name);
      }
    } catch (e) {
      print("Error fetching names: $e");
    }

    return names;
  }

  bool compareDateWithCurrent(DateTime providedDateTime) {
    DateTime currentDate = DateTime.now();

    return providedDateTime.day == currentDate.day &&
        providedDateTime.month == currentDate.month &&
        providedDateTime.year == currentDate.year;
  }

  Future<List<int>> getAllSlots() async {
    int currentHour = DateTime.now().hour;
    print(currentHour);

    CollectionReference slotsCollection =
        FirebaseFirestore.instance.collection('slots');

    QuerySnapshot snapshot = await slotsCollection.get();

    List<int> slots = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null && data['slot'] != null) {
        slots.add(data['slot'] as int);
      }
    });

    return slots;
  }

  confirmslots(DateTime date) async {
    bool a = compareDateWithCurrent(date);
    if (a) {
      List<int> slot = await getSlotsGreaterThanCurrentHour();
      List<int> slot2 = await getTicketsForDate(date);
      List<int> slot3 = await holidayDates(date);

      slot.removeWhere((element) => slot2.contains(element));
      slot.removeWhere((element) => slot3.contains(element));
      slot.sort();
      return slot;
    } else {
      List<int> slot = await getAllSlots();
      List<int> slot2 = await getTicketsForDate(date);
      List<int> slot3 = await holidayDates(date);
      slot.removeWhere((element) => slot2.contains(element));
      slot.removeWhere((element) => slot3.contains(element));
      slot.sort();
      return slot;
    }
  }

  Future<String?> getPhoneById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userid = prefs.getString('userid');

    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot =
        await collection.where('id', isEqualTo: userid).get();

    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          snapshot.docs.first.data() as Map<String, dynamic>;

      return data['phonenumber']?.toString();
    } else {
      return null;
    }
  }

  get_email() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    return email;
  }

  Future<void> feedback(String content, String phone, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userid = prefs.getString('userid');

    _firebaseFirestore.collection("feedback").add({
      "id": userid,
      "content": content,
      "phone": phone,
      "email": email,
    });
  }

  Future<List<ticket_Model>> getticket() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? action = prefs.getString('userid');
      QuerySnapshot<Map<String, dynamic>> querrysnapshot =
          await _firebaseFirestore
              .collection("users")
              .doc(action)
              .collection("bookedtickets")
              .get();

      List<ticket_Model> boardingrequestdetails = querrysnapshot.docs
          .map((e) => ticket_Model.fromJson(e.data()))
          .toList();
      return boardingrequestdetails;
    } catch (e) {
      showmessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<String?> getGameCost(String gameName) async {
    CollectionReference gamesCollection =
        FirebaseFirestore.instance.collection('games');

    QuerySnapshot snapshot =
        await gamesCollection.where('game', isEqualTo: gameName).get();

    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          snapshot.docs.first.data() as Map<String, dynamic>;

      return data['price']?.toString();
    } else {
      return null;
    }
  }
}
