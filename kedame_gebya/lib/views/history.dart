// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedame_gebya/bloc/kedame_gebya_state.dart';
import 'package:kedame_gebya/routes.dart';

import '../bloc/kedame_gebya_bloc.dart';
import 'components/my_drawer.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text(
            "Kedame Gebya",
            style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.history);
              },
              icon: const Icon(
                Icons.shopping_bag,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.profile);
              },
              icon: const Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.home);
              },
              icon: const Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: BlocBuilder<KedameGebyaBloc, KedameGebyaState>(
          builder: (context, state) {
            if (state is KedameGebyaInitialState) {
              return const Center(
                  child: Text(
                "NO HISTORY TO SHOW!\n TOTAL: 0\$",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ));
            }
            if (state is KedameGebyaLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is KedameGebyaSuccessState) {
              if (state.history.isEmpty) {
                return const Center(
                    child: Text(
                  "NO HISTORY TO SHOW!\n TOTAL: 0\$",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ));
              } else {
                num TotalPrice = 0;
                void _incrementCounter() {
                  for (var element in state.history) {
                    TotalPrice += element.foodPrice;
                  }
                }

                _incrementCounter();
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "TOTAL: ${TotalPrice.toStringAsFixed(2)}\$",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: MediaQuery.of(context).size.height * .75,
                      child: ListView.builder(
                        itemCount: state.history.length,
                        itemBuilder: (BuildContext context, int index) {
                          final asbezaVal = state.history[index];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: NetworkImage(
                                                    asbezaVal.image))),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 11, vertical: 5),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  asbezaVal.category,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${asbezaVal.foodPrice}\$",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }
            return Container();
          },
        ));
  }
}
