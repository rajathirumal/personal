import 'dart:convert';

import 'package:flutter/foundation.dart';

class SingleExpense {
  String username;
  String expenseID;
  String itemName;
  String count;
  String price;
  List<String> friends;
  String location;
  String timestamp;
  SingleExpense({
    required this.username,
    required this.expenseID,
    required this.itemName,
    required this.count,
    required this.price,
    required this.friends,
    required this.location,
    required this.timestamp,
  });

  SingleExpense copyWith({
    String? username,
    String? expenseID,
    String? itemName,
    String? count,
    String? price,
    List<String>? friends,
    String? location,
    String? timestamp,
  }) {
    return SingleExpense(
      username: username ?? this.username,
      expenseID: expenseID ?? this.expenseID,
      itemName: itemName ?? this.itemName,
      count: count ?? this.count,
      price: price ?? this.price,
      friends: friends ?? this.friends,
      location: location ?? this.location,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'expenseID': expenseID,
      'itemName': itemName,
      'count': count,
      'price': price,
      'friends': friends,
      'location': location,
      'timestamp': timestamp,
    };
  }

  factory SingleExpense.fromMap(Map<String, dynamic> map) {
    return SingleExpense(
      username: map['username'] ?? '',
      expenseID: map['expenseID'] ?? '',
      itemName: map['itemName'] ?? '',
      count: map['count'] ?? '',
      price: map['price'] ?? '',
      friends: List<String>.from(map['friends']),
      location: map['location'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleExpense.fromJson(String source) => SingleExpense.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SingleExpense(username: $username, expenseID: $expenseID, itemName: $itemName, count: $count, price: $price, friends: $friends, location: $location, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SingleExpense &&
      other.username == username &&
      other.expenseID == expenseID &&
      other.itemName == itemName &&
      other.count == count &&
      other.price == price &&
      listEquals(other.friends, friends) &&
      other.location == location &&
      other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return username.hashCode ^
      expenseID.hashCode ^
      itemName.hashCode ^
      count.hashCode ^
      price.hashCode ^
      friends.hashCode ^
      location.hashCode ^
      timestamp.hashCode;
  }
  }
