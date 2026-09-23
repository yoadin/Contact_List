import 'package:contact_list_app/contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}): super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

TextEditingController nameController = TextEditingController();
TextEditingController contactController = TextEditingController();
List<Contact> contacts = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts List"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
             TextField(
              controller: nameController,
              decoration:const InputDecoration(
                hintText: "Contact Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10))
                )
              ),
            ),
            const SizedBox(height: 15),
             TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 12,
              decoration:const InputDecoration(
                hintText: "Contact Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10))
                )
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  String name = nameController.text.trim();
                  String contact = contactController.text.trim();

                  if(name.isNotEmpty && contact.isNotEmpty){
                    setState(() {
                      nameController.text = ' ';
                      contactController.text = ' ';
                      contacts.add(Contact(name: name, contact: contact));
                    });
                  }
                }, child: const Text("save")),
                ElevatedButton(onPressed: (){

                }, child: const Text("Update"))
              ],
            ),
            const SizedBox(height: 20,),
            contacts.isEmpty ? const Text("No contacts registered yet..", style: TextStyle(fontSize: 22,)) :
            Expanded(
              child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) => getRow(index)
            ),)
          ],
        ),
      ),
    );
  }
  Widget getRow(int index){
      return Card(
        child: ListTile(
          leading: CircleAvatar(

            backgroundColor: index%2 == 0? Colors.deepPurple : Colors.indigoAccent,
            foregroundColor: Colors.white,
            child: Text(
              contacts[index].name[0], 
              style: const TextStyle(fontWeight: FontWeight.bold ),
            ),
          ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contacts[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
            Text(contacts[index].contact, style: TextStyle(fontStyle: FontStyle.italic ),),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children:  [
              InkWell(
                onTap:( () {
                  //
                }),
                child: const Icon(Icons.edit)),
              InkWell(
                onTap: (() {
                  setState(() {
                    contacts.removeAt(index);
                  });
                }),
                child: const Icon(Icons.delete))
            ],
          )
        ),
      )
      );
    }
}