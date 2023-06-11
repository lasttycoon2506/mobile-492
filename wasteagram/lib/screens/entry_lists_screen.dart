import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../widgets/list_header.dart';
import '../widgets/new_post_button.dart';
import 'post_details_screen.dart';

class EntryListsScreen extends StatefulWidget {
  static const routeName = '/';

  const EntryListsScreen({Key? key}) : super(key: key);

  @override
  EntryListsScreenState createState() => EntryListsScreenState();
}

class EntryListsScreenState extends State<EntryListsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          listHeader(context),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var post = snapshot.data!.docs[index];
                          return Dismissible(
                              onDismissed: (direction) {
                                deleteEntry(snapshot.data!.docs[index].id);
                              },
                              key: ObjectKey(post),
                              background: Container(color: Colors.red),
                              child: listEntryTile(context, post));
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: const NewPostButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget listEntryTile(BuildContext context, dynamic post) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Semantics(
      enabled: true,
      hint: 'Tap for Details',
      child: ListTile(
        title: Text(
            style: const TextStyle(
              fontSize: 30,
            ),
            DateFormat.yMMMd().format(post['date'].toDate())),
        trailing: Text(post['quantity'].toString(),
            style: const TextStyle(
              color: Color.fromARGB(255, 4, 209, 232),
              fontSize: 30,
            )),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostDetailsScreen(post: post)));
        },
      ),
    ),
  );
}

Future<void> deleteEntry(String entryId) {
  return FirebaseFirestore.instance.collection('posts').doc(entryId).delete();
}
