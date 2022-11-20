import 'package:api_httpe/models/post.dart';
import 'package:api_httpe/service/one_server.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  List<Odam>? odam;

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

// get
  getData() async {
    odam = await OneService().getPost();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assalomu aleykum'),
      ),
      body: FutureBuilder(
          future: OneService().getPost(),
          // initialData: const [],
          builder: (context, snapshot) {
            return snapshot.data == null && !snapshot.hasData
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        color: Colors.grey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data?[index].name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              snapshot.data![index].id,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  editDialog(snapshot.data![index]);
                                });
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  OneService.delete(snapshot.data![index]);
                                });
                              },
                              icon: const Icon(Icons.delete_sharp),
                            )
                          ],
                        ),
                      );
                    }),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          show(context);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

//
// [function]
  Future<dynamic> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextFormField(
              controller: _controller..text = 'vektor',
              onChanged: (value) {
                setState(() {});
              },
            ),
            // new post
            IconButton(
              onPressed: () {
                OneService()
                    .post(Odam(name: _controller.text, id: _controller2.text))
                    .then((value) => getData());
                print('${_controller.text}ishladi');
                setState(() {});
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.done),
            ),

            // no pop
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
              icon: const Icon(Icons.close),
            )
          ],
        );
      },
    );
  }

  Future<dynamic> editDialog(Odam psot) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextFormField(
              controller: _controller..text = psot.name,
              onChanged: (value) {
                setState(() {});
              },
            ),
            // new post
            IconButton(
              onPressed: () {
                OneService.put(Odam(name: _controller.text, id: psot.id))
                    .then((value) => getData());
                print('${_controller.text}ishladi');
                setState(() {});
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.done),
            ),

            // no pop
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
              icon: const Icon(Icons.close),
            )
          ],
        );
      },
    );
  }
}
