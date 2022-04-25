import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

const request = "https://api.covid19api.com/summary";

void main() async {
  runApp(const CovidApp());
}

class CovidApp extends StatefulWidget {
  const CovidApp({Key? key}) : super(key: key);

  @override
  State<CovidApp> createState() => _CovidAppState();
}

Future<Map?> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

class _CovidAppState extends State<CovidApp> {
  double? newConfirmed;
  double? totalConfirmed;
  double? newDeaths;
  double? totalDeaths;
  double? newRecovered;
  double? totalRecovered;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(230, 22, 22, 22),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<Map?>(
                  future: getData(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: Container(
                            width: 200,
                            height: 200,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 255, 255)),
                              strokeWidth: 5.0,
                            ),
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              'Erro ao carregar dados!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 20.0),
                            ),
                          );
                        } else {
                          newConfirmed =
                              snapshot.data!['Countries'][24]['NewConfirmed'];
                          totalConfirmed =
                              snapshot.data!['Countries'][24]['TotalConfirmed'];
                          newDeaths =
                              snapshot.data!['Countries'][24]['NewDeaths'];
                          totalDeaths =
                              snapshot.data!['Countries'][24]['TotalDeaths'];
                          newRecovered =
                              snapshot.data!['Countries'][24]['NewRecovered'];
                          totalRecovered =
                              snapshot.data!['Countries'][24]['TotalRecovered'];

                          return CustomScrollView(
                            slivers: <Widget>[
                              SliverAppBar(
                                backgroundColor:
                                    const Color.fromARGB(246, 34, 34, 34),
                                pinned: true,
                                expandedHeight: 260,
                                flexibleSpace: FlexibleSpaceBar(
                                  background: Image.asset('../assets/header.jpg',
                                      fit: BoxFit.cover),
                                  title: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.coronavirus,
                                          color: Color.fromARGB(206, 255, 255, 255),
                                          ),
                                      ),
                                      Text(
                                        'Histórico da Covid no Brasil',
                                        style: TextStyle(
                                          color: Color.fromARGB(206, 255, 255, 255),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    if (index == 0) {
                                      return Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.fromLTRB(
                                            15, 15, 15, 0),
                                        child: Container(
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: index.isOdd
                                                ? const Color.fromARGB(
                                                    255, 48, 47, 47)
                                                : const Color.fromARGB(
                                                    255, 68, 68, 68),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    169, 20, 20, 20),
                                                spreadRadius: 0.5,
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: ListTile(
                                              leading: const CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage(
                                                    '../assets/covid_1.jpg'
                                                ),
                                              ),
                                              title: const Text(
                                                'Novos Casos da Covid Confirmados:',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Text(
                                                  newConfirmed.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (index == 1) {
                                      return Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.fromLTRB(
                                            15, 15, 15, 0),
                                        child: Container(
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: index.isOdd
                                                ? const Color.fromARGB(
                                                    255, 48, 47, 47)
                                                : const Color.fromARGB(
                                                    255, 68, 68, 68),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    169, 20, 20, 20),
                                                spreadRadius: 0.5,
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: ListTile(
                                              leading: const CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage(
                                                    '../assets/covid_2.jpg'
                                                ),
                                              ),
                                              title: const Text(
                                                'Total de Casos da Covid:',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Text(
                                                  totalConfirmed.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (index == 2) {
                                      return Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.fromLTRB(
                                            15, 15, 15, 0),
                                        child: Container(
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: index.isOdd
                                                ? const Color.fromARGB(
                                                    255, 48, 47, 47)
                                                : const Color.fromARGB(
                                                    255, 68, 68, 68),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    169, 20, 20, 20),
                                                spreadRadius: 0.5,
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: ListTile(
                                              leading: const CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage(
                                                    '../assets/vacina_1.jpg'
                                                ),
                                              ),
                                              title: const Text(
                                                'Novos Casos Recuperados:',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Text(
                                                  newRecovered.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.greenAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (index == 3) {
                                      return Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.fromLTRB(
                                            15, 15, 15, 0),
                                        child: Container(
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: index.isOdd
                                                ? const Color.fromARGB(
                                                    255, 48, 47, 47)
                                                : const Color.fromARGB(
                                                    255, 68, 68, 68),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    169, 20, 20, 20),
                                                spreadRadius: 0.5,
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: ListTile(
                                              leading: const CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage(
                                                    '../assets/vacina_2.jpg'
                                                ),
                                              ),
                                              title: const Text(
                                                'Total de Casos Recuperados:',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Text(
                                                  totalRecovered.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.greenAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (index == 4) {
                                      return Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.fromLTRB(
                                            15, 15, 15, 0),
                                        child: Container(
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: index.isOdd
                                                ? const Color.fromARGB(
                                                    255, 48, 47, 47)
                                                : const Color.fromARGB(
                                                    255, 68, 68, 68),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    169, 20, 20, 20),
                                                spreadRadius: 0.5,
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: ListTile(
                                              leading: const CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage(
                                                    '../assets/morte_1.jpg'
                                                ),
                                              ),
                                              title: const Text(
                                                'Novas Mortes da Covid Confirmadas:',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Text(
                                                  newDeaths.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (index == 5) {
                                      return Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.fromLTRB(
                                            15, 15, 15, 15),
                                        child: Container(
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: index.isOdd
                                                ? const Color.fromARGB(
                                                    255, 48, 47, 47)
                                                : const Color.fromARGB(255, 68, 68, 68),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    169, 20, 20, 20),
                                                spreadRadius: 0.5,
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: ListTile(
                                              leading: const CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage(
                                                    '../assets/morte_2.jpg'
                                                ),
                                              ),
                                              title: const Text(
                                                'Total de Mortes da Covid:',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Text(
                                                  totalDeaths.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  childCount: 6,
                                ),
                              )
                            ],
                          );
                        }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
