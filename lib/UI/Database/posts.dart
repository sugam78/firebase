import 'package:all_firebase/UI/Database/add_posts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final con = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PostScreen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              defaultChild: Text('Loading'),
              itemBuilder: (context,snapshot,animation,index){
                return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                  trailing: PopupMenuButton(
                    itemBuilder: (context)=>[
                      PopupMenuItem(
                          child: IconButton(
                            onPressed: (){
                              fetchData(snapshot.child('title').value.toString(), snapshot.child('id').value.toString());
                            },
                            icon: Icon(Icons.edit),
                          )
                      ),
                      PopupMenuItem(
                          child: IconButton(
                            onPressed: (){
                              ref.child(snapshot.child('id').value.toString()).remove();
                            },
                            icon: Icon(Icons.delete),
                          )
                      ),

                    ],
                    icon: Icon(Icons.menu),
                  )
                );
              }
            )
          ),
        ],
      ),
    );
  }
  Future<void> fetchData(String title,String id) async{
    con.text = title;
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
              TextButton(onPressed: (){
                ref.child(id).update({
                  'title': con.text.toString().toLowerCase(),
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
