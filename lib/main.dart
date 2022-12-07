import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController serachController = TextEditingController();
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1484876065684-b683cf17d276?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: serachController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (String? value) {
                    print(value);
                    setState(() {
                      search = value.toString();
                    });
                  },
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 500,
                      itemBuilder: (context, index) {
                        late String position = index.toString();
                        if (serachController.text.isEmpty) {
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1619983081563-430f63602796?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                            ),
                            title: Text('A S' + index.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            subtitle: const Text('Anjal Shrestha',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          );
                        } else if (position
                            .toLowerCase()
                            .contains(serachController.text.toLowerCase())) {
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1619983081563-430f63602796?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                            ),
                            title: RichText(
                                text: TextSpan(
                                    text: 'A S',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                  TextSpan(
                                      text: index.toString(),
                                      style: TextStyle(
                                        color: Colors.red,
                                      )),
                                ])),
                            subtitle: const Text('Anjal Shrestha'),
                          );
                        } else {
                          return Container();
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
