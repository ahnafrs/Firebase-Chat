import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createChatRoom(String chatRoomId) async {
    try {
      await _firestore.collection('messages').doc(chatRoomId).set({});
    } catch (e) {
      print('Error creating chat room: $e');
    }
  }

  Future<bool> checkChatRoomExists(String chatRoomId) async {
    final docSnapshot =
        await _firestore.collection('messages').doc(chatRoomId).get();
    return docSnapshot.exists;
  }

  String getChatRoomId(String user1, String user2) {
    if (user1.compareTo(user2) < 0) {
      return '$user1-$user2';
    } else {
      return '$user2-$user1';
    }
  }

  Future<void> sendMessage(
      String chatRoomId, String sender, String message) async {
    try {
      final messageData = {
        'sender': sender,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      };
      await _firestore
          .collection('messages')
          .doc(chatRoomId)
          .collection('message1')
          .add(messageData);
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
