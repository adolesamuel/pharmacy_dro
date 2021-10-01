import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_dro/pharmacy/app/bloc/pharm_bloc.dart';
import 'package:pharmacy_dro/pharmacy/data/repository/pharmacy_repo.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/local_source.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/remote_source.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({Key? key}) : super(key: key);

  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  PharmBloc pharmBloc = PharmBloc(
    DrugRepository(
      DrugRemoteDataSource(),
      DrugLocalDataSource(),
    ),
  );

  @override
  void initState() {
    super.initState();
    pharmBloc..add(GetDrugsEvent());
  }

  int selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        toolbarHeight: 130,
        elevation: 0,
        title: Text('Pharmacy'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Container(
            margin: EdgeInsets.all(20.0),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              onChanged: (value) {},
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  hintText: 'Search',
                  hintMaxLines: 1,
                  filled: true,
                  alignLabelWithHint: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  hintStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
      body: BlocProvider<PharmBloc>(
        create: (context) => pharmBloc..add(GetDrugsEvent()),
        child: BlocListener<PharmBloc, PharmState>(
          bloc: pharmBloc,
          listener: (context, state) {
            print(state);
            if (state is GotDrugsState) {
              print(state.drugs);
            }
            if (state is FailedState) {
              print(state.failure.message);
            }
          },
          child: Container(
            color: Colors.grey.shade200,
            child: ListView(
              children: [
                //Location stuff
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.gps_fixed_outlined),
                      SizedBox(width: 5.0),
                      Text('Delivery in'),
                      SizedBox(width: 5.0),
                      Text(
                        'Lagos, NG',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('CATEGORIES'),
                          TextButton(onPressed: () {}, child: Text('VIEW ALL'))
                        ],
                      ),
                      //ListView for Categories
                      Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Center(
                              child: Container(
                                height: 100.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        backgroundColor: Colors.grey.shade100,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.dock), label: 'Doctors'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Pharmacy'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Profile'),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = 2;
          setState(() {});
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: [
            Text('Checkout'),
            Icon(Icons.shopping_cart_outlined),
            CircleAvatar(
                radius: 10, backgroundColor: Colors.yellow, child: Text('2'))
          ],
        ),
      ),
    );
  }
}
