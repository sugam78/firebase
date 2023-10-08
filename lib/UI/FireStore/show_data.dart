import 'package:all_firebase/UI/FireStore/add_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final fireStore = FirebaseFirestore.instance.collection('user').snapshots();
  final ref = FirebaseFirestore.instance.collection('user');
  final con =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PostScreen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDataScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else{
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                return ListTile(
                  title: Text(snapshot.data!.docs[index]['title'].toString()),
                  subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                  trailing: PopupMenuButton(
                    itemBuilder: (context)=>[
                      PopupMenuItem(
                          child: IconButton(
                            onPressed: (){
                              fetchData(snapshot.data!.docs[index]['title'].toString(), snapshot.data!.docs[index]['id'].toString());
                            },
                            icon: Icon(Icons.edit),
                          )
                      ),
                      PopupMenuItem(
                          child: IconButton(
                            onPressed: (){
                              ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                            },
                            icon: Icon(Icons.delete),
                          )
                      ),
                    ],
                    icon: Icon(Icons.menu),
                  ),
                );
              }),
            );
          }
            },
          )
        ],
      ),
    );
  }
  Future<void> fetchData(String conn,String id) async{
    con.text = conn;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: con,
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: (){
                  ref.doc(id).set({
                    'title': con.text,
                  });
                  Navigator.pop(context);
                },
                child: Text('Update'),
              )
            ],
          );
        }
    );
  }
}
