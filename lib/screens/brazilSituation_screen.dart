// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

const request = "https://api.covid19api.com/summary";


class BrazilSituation extends StatefulWidget {
  const BrazilSituation({Key? key}) : super(key: key);

  @override
  State<BrazilSituation> createState() => _BrazilSituationState();
}

Future<Map?> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

class _BrazilSituationState extends State<BrazilSituation> {
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
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 255, 255, 255)),
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
                                  color: Colors.redAccent, fontSize: 20.0),
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
                                  background: Image.asset(
                                      '../assets/header.jpg',
                                      fit: BoxFit.cover),
                                  title: const Text(
                                    'Histórico da Covid no Brasil',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color.fromARGB(206, 255, 255, 255),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    if (index == 0) {
                                      return CardConstructor(
                                        index: index,
                                        imageAsset: '../assets/covid_2.jpg',
                                        cardText: 'Total de Casos da Covid:',
                                        cardInfo: totalConfirmed,
                                        cardInfoColor: Colors.redAccent,
                                      );
                                    } else if (index == 1) {
                                      return CardConstructor(
                                        index: index,
                                        imageAsset: '../assets/covid_2.jpg',
                                        cardText: 'Total de Casos da Covid:',
                                        cardInfo: totalConfirmed,
                                        cardInfoColor: Colors.redAccent,
                                      );
                                    } else if (index == 2) {
                                      return CardConstructor(
                                        index: index,
                                        imageAsset: '../assets/vacina_1.jpg',
                                        cardText: 'Novos Casos Recuperados:',
                                        cardInfo: newRecovered,
                                        cardInfoColor: Colors.greenAccent,
                                      );
                                    } else if (index == 3) {
                                      return CardConstructor(
                                        index: index,
                                        imageAsset: '../assets/vacina_2.jpg',
                                        cardText: 'Total de Casos Recuperados:',
                                        cardInfo: totalRecovered,
                                        cardInfoColor: Colors.greenAccent,
                                      );
                                    } else if (index == 4) {
                                      return CardConstructor(
                                        index: index,
                                        imageAsset: '../assets/morte_1.jpg',
                                        cardText: 'Novas Mortes da Covid Confirmadas:',
                                        cardInfo: newDeaths,
                                        cardInfoColor: Colors.redAccent,
                                      );
                                    } else if (index == 5) {
                                      return CardConstructor(
                                        index: index,
                                        imageAsset: '../assets/morte_2.jpg',
                                        cardText: 'Total de Mortes da Covid:',
                                        cardInfo: totalDeaths,
                                        cardInfoColor: Colors.redAccent,
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

class CardConstructor extends StatelessWidget {
  final int? index;
  final String? imageAsset;
  final String? cardText;
  final double? cardInfo;
  final Color? cardInfoColor;

  const CardConstructor({
    this.index,
    this.imageAsset,
    this.cardText,
    this.cardInfo,
    this.cardInfoColor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          color: index!.isOdd
              ? const Color.fromARGB(255, 48, 47, 47)
              : const Color.fromARGB(255, 68, 68, 68),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(169, 20, 20, 20),
              spreadRadius: 0.5,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imageAsset!),
            ),
            title: Text(
              cardText!,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                cardInfo!.toString(),
                style: TextStyle(
                  fontSize: 18,
                  color: cardInfoColor!,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}