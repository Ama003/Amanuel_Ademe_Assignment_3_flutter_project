import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedame_gebya/bloc/kedame_gebya_bloc.dart';
import 'package:kedame_gebya/bloc/kedame_gebya_event.dart';
import 'package:kedame_gebya/bloc/kedame_gebya_state.dart';

import '../routes.dart';
import 'components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Kedame Gebya App",
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
            return Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    alignment: Alignment.center,
                    elevation: 0),
                onPressed: () {
                  BlocProvider.of<KedameGebyaBloc>(context)
                      .add(const KedameGebyaEvent());
                },
                icon: const Icon(Icons.shopping_basket_rounded),
                label: const Text("Kedame Gebya App"),
              ),
            );
          }
          if (state is KedameGebyaLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is KedameGebyaSuccessState) {
            return Container(
              margin: const EdgeInsets.only(top: 5),
              height: MediaQuery.of(context).size.height * .88,
              child: GridView.builder(
                itemCount: state.kedameGebya.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisExtent: 380,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final asbezaVal = state.kedameGebya[index];
                  return Column(children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 280,
                            width: MediaQuery.of(context).size.width,
                            child: Image(
                              image: NetworkImage(asbezaVal.image),
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            asbezaVal.category,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${asbezaVal.foodPrice}\$",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 20),
                              ),
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<KedameGebyaBloc>(context).add(
                                      HistoryEvent(kedameGebya: asbezaVal));
                                },
                                icon: const Icon(Icons.shopping_cart),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]);
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
