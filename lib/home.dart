import 'package:flutter/material.dart';

import 'database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('C R U D  A P P'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              OutlinedButton(
                style: OutlinedButton.styleFrom(fixedSize: const Size(200, 50)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Create()));
                },
                child: const Text('Create'),
              ),
              const SizedBox(height: 25),
              OutlinedButton(
                style: OutlinedButton.styleFrom(fixedSize: const Size(200, 50)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Read()));
                },
                child: const Text('Read'),
              ),
              const SizedBox(height: 25),
              OutlinedButton(
                style: OutlinedButton.styleFrom(fixedSize: const Size(200, 50)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Update()));
                },
                child: const Text('Update'),
              ),
              const SizedBox(height: 25),
              OutlinedButton(
                style: OutlinedButton.styleFrom(fixedSize: const Size(200, 50)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Delete()));
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController textEditingController = TextEditingController();
  List<String> items = <String>[];
  Future<void> addItem() async {
    await SQLHelper.createItem(textEditingController.text);
    refreshData();
    textEditingController.text = '';
  }

  void refreshData() async {
    setState(() {
      items.add(textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('C R E A T E'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        labelText: 'Item',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.save),
                          onPressed: () {
                            addItem();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[100],
                      ),
                      height: 500,
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(items[index]),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Read extends StatefulWidget {
  const Read({Key? key}) : super(key: key);

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  List<Map<String, dynamic>> items = [];
  void refreshDate() async {
    final data = await SQLHelper.getItems();
    setState(() {
      items = data;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshDate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('R E A D'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]['item']),
                );
              }),
        ),
      ),
    );
  }
}

class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  bool editing = false;
  TextEditingController textEditingController = TextEditingController();
  int? selectedId;
  List<Map<String, dynamic>> items = [];
  void refreshDate() async {
    final data = await SQLHelper.getItems();
    setState(() {
      items = data;
    });
  }

  Future<void> updateItem(int id) async {
    await SQLHelper.updateItem(id, textEditingController.text);
    refreshDate();
  }

  @override
  void initState() {
    super.initState();
    refreshDate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('U P D A T E'),
        ),
        body: Visibility(
          visible: editing,
          replacement: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]['item']),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        selectedId = items[index]['id'];
                        textEditingController.text = items[index]['item'];
                        setState(() {
                          editing = true;
                        });
                      },
                    ),
                  );
                }),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Updated item',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        updateItem(selectedId!);
                        setState(() {
                          editing = false;
                        });

                        //updateItem(items[index]['id']);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Delete extends StatefulWidget {
  const Delete({Key? key}) : super(key: key);

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  List<Map<String, dynamic>> items = [];
  void refreshDate() async {
    final data = await SQLHelper.getItems();
    setState(() {
      items = data;
    });
  }

  void deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    refreshDate();
  }

  @override
  void initState() {
    super.initState();
    refreshDate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('D E L E T E'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]['item']),
                  trailing: IconButton(
                    onPressed: () {
                      deleteItem(items[index]['id']);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
