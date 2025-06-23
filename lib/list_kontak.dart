import 'package:flutter/material.dart';
import 'form_kontak.dart';
 
import 'database/db_helper.dart';
import 'model/kontak.dart';
 
class ListKontakPage extends StatefulWidget {
  const ListKontakPage({Key? key}) : super(key: key);
 
  @override
  // ignore: library_private_types_in_public_api
  _ListKontakPageState createState() => _ListKontakPageState();
}
 
class _ListKontakPageState extends State<ListKontakPage> {
  List<Kontak> listKontak = [];
  DbHelper db = DbHelper();
 
  @override
  void initState() {
    //menjalankan fungsi getallkontak saat pertama kali dimuat
    _getAllKontak();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Contact Apps"),
        ),
        // backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          itemCount: listKontak.length,
          itemBuilder: (context, index) {
            Kontak kontak = listKontak[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(color: Colors.red, width: 3),
              ),
              margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
              // elevation: 50,
              // shadowColor: Colors.black,
              color: const Color.fromARGB(255, 248, 249, 248),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                child: ListTile(
                  leading: const Icon(
                    Icons.person,
                    size: 50,
                  ),
                  title: Text('${kontak.name}'),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text("Email: ${kontak.email}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text("Phone: ${kontak.mobileNo}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text("Company: ${kontak.company}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text("Hobby: ${kontak.hobi}"),
                      )
                    ],
                  ),
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Row(
                      children: [
                        // button edit
                        IconButton(
                            onPressed: () {
                              _openFormEdit(kontak);
                            },
                            icon: const Icon(Icons.edit)),
                        // button hapus
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            //membuat dialog konfirmasi hapus
                            AlertDialog hapus = AlertDialog(
                              title: const Text("Information"),
                              content: SizedBox(
                                height: 100,
                                child: Column(
                                  children: [
                                    Text(
                                        "Yakin ingin Menghapus Data ${kontak.name}")
                                  ],
                                ),
                              ),
                              //terdapat 2 button.
                              //jika ya maka jalankan _deleteKontak() dan tutup dialog
                              //jika tidak maka tutup dialog
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      _deleteKontak(kontak, index);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ya")),
                                TextButton(
                                  child: const Text('Tidak'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                            showDialog(
                                context: context, builder: (context) => hapus);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        hoverColor: Colors.redAccent,
        child: const Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }
 
  //mengambil semua data Kontak
  Future<void> _getAllKontak() async {
    //list menampung data dari database
    var list = await db.getAllKontak();
 
    //ada perubahanan state
    setState(() {
      //hapus data pada listKontak
      listKontak.clear();
 
      //lakukan perulangan pada variabel list
      for (var kontak in list!) {
        //masukan data ke listKontak
        listKontak.add(Kontak.fromMap(kontak));
      }
    });
  }
 
  //menghapus data Kontak
  Future<void> _deleteKontak(Kontak kontak, int position) async {
    await db.deleteKontak(kontak.id!);
    setState(() {
      listKontak.removeAt(position);
    });
  }
 
  // membuka halaman tambah Kontak
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FormKontak()));
    if (result == 'save') {
      await _getAllKontak();
    }
  }
 
  //membuka halaman edit Kontak
  Future<void> _openFormEdit(Kontak kontak) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormKontak(kontak: kontak)));
    if (result == 'update') {
      await _getAllKontak();
    }
  }
}