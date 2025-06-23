import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/kontak.dart';
 
class FormKontak extends StatefulWidget {
  final Kontak? kontak;
 
  const FormKontak({super.key, this.kontak});
 
  @override
  // ignore: library_private_types_in_public_api
  _FormKontakState createState() => _FormKontakState();
}
 
class _FormKontakState extends State<FormKontak> {
  DbHelper db = DbHelper();
 
  TextEditingController? name;
  TextEditingController? lastName;
  TextEditingController? mobileNo;
  TextEditingController? email;
  TextEditingController? company;
  TextEditingController? hobi;
 
  @override
  void initState() {
    name = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.name);
 
    mobileNo = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.mobileNo);
 
    email = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.email);
 
    company = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.company);

    hobi = TextEditingController(
        text: widget.kontak == null  ? '' : widget.kontak!.hobi); 
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Form'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: mobileNo,
              decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: company,
              decoration: InputDecoration(
                  labelText: 'Company',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: hobi,
              decoration: InputDecoration(
                  labelText: 'Hobby',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                child: (widget.kontak == null)
                    ? const Text(
                        'Add',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      )
                    : const Text(
                        'Update',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                onPressed: () {
                  upsertKontak();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
 
  Future<void> upsertKontak() async {
    if (widget.kontak != null) {
      //update
      await db.updateKontak(Kontak.fromMap({
        'id': widget.kontak!.id,
        'name': name!.text,
        'mobileNo': mobileNo!.text,
        'email': email!.text,
        'company': company!.text,
        'hobi': hobi!.text
      }));
      // ignore: use_build_context_synchronously
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveKontak(Kontak(
        name: name!.text,
        mobileNo: mobileNo!.text,
        email: email!.text,
        company: company!.text,
        hobi: hobi!.text,
      ));
      // ignore: use_build_context_synchronously
      Navigator.pop(context, 'save');
    }
  }
}