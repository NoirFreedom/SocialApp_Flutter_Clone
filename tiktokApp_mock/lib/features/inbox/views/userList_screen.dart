import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  static const String routeName = "userList";
  static const String routeURL = "/userList";
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final Stream<QuerySnapshot> _userList;

  @override
  void initState() {
    super.initState();

    _userList = FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _userList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(data['profileImageUrl'] ?? '기본 이미지 URL'),
                    ),
                    title: Text(data['name'] ?? '이름 없음'),
                    subtitle: Text(data['lastMessage'] ?? '마지막 메시지 없음'),
                    onTap: () {
                      // 대화방을 탭했을 때 상세 화면으로 이동하도록 구현
                    },
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
