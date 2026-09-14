import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/model/Get_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class firebase {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final uid=FirebaseAuth.instance.currentUser!.uid;

  static Future<bool> Save(String heading, String data) async {
    try {
      var result = await db.collection("notes").add({
        "title": heading,
        "data": data,
        "time": FieldValue.serverTimestamp(),
        "uid":uid,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> SaveToken(String token) async {
    String uid=FirebaseAuth.instance.currentUser!.uid;
    await db.collection("users").doc(uid).set({
      "fcmtoken": token,
    }, SetOptions(merge: true));
  }

  static Future<List<Note>> get() async {


    var data = await db
        .collection("notes")
        .where("uid", isEqualTo: uid)
        .get();



    List<Note> notes = data.docs.map((item) {
      return Note.database(item.data(), item.id);
    }).toList();

    return notes;
  }

  static Future<bool> delete(String id) async {
    try {
      await db.collection("notes").doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> delete_all() async {
    var data = await db.collection("notes").get();
    for (var value in data.docs) {
      await value.reference.delete();
    }
  }

  static Future<bool> update(String id, String tittle, String data) async {
    try {
      await db.collection("notes").doc(id).update({
        "title": tittle,
        "data": data,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Note> detail_data(String id) async {
    try {
      var data = await db.collection("notes").doc(id).get();
      return Note.database(data.data()!, data.id);
    } catch (e) {
      throw ("failed",e);
    }
  }

  static Future<bool> Signup(String email, String password) async {
    try {
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword
        (email: email, password: password);
      String uid = user.user!.uid;
      await db.collection("users").doc(uid).set({
        "uid": uid,
      });
      return true;
    } catch (e) {
      print("Signup failed: $e");
      throw ("Signup failed: $e");

    }
  }
  static Future<bool> Login(String Email ,String pass)async{
    try{
     var user= await FirebaseAuth.instance.signInWithEmailAndPassword
       (email: Email, password: pass);
      return true;

    }
    catch(e){
     throw("ERROR $e");
    }
  }

}
