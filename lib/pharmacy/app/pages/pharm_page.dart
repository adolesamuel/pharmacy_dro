import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_dro/core/appColors.dart';
import 'package:pharmacy_dro/core/list.dart';
import 'package:pharmacy_dro/pharmacy/app/bloc/pharm_bloc.dart';
import 'package:pharmacy_dro/pharmacy/app/common/appbar_with_search.dart';
import 'package:pharmacy_dro/pharmacy/app/common/category_widget.dart';
import 'package:pharmacy_dro/pharmacy/app/common/drug_list_item.dart';
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
      appBar: SearchAppBar(
        //todo:
        onChanged: (value) {},
        hasSearchBar: true,
        onTapCart: () {},
      ),
      body: BlocProvider<PharmBloc>(
        create: (context) => pharmBloc..add(GetDrugsEvent()),
        child: BlocConsumer<PharmBloc, PharmState>(
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
            builder: (context, state) {
              return Container(
                color: Colors.grey.shade200,
                child: ListView(
                  shrinkWrap: true,
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
                              Text(
                                'CATEGORIES',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              TextButton(
                                  onPressed: () {}, child: Text('VIEW ALL'))
                            ],
                          ),
                          //ListView for Categories

                          Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: AppList.assetLists.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CategoryWidget(
                                  assetString: AppList.assetLists[index],
                                  categoriesString:
                                      AppList.categoriesList[index],
                                  selectCategory: (category) {},
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'SUGGESTIONS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          if (state is GotDrugsState)
                            GridView.builder(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: state.drugs.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0,
                                ),
                                itemBuilder: (context, index) {
                                  return DrugListItem(
                                    drug: state.drugs[index],
                                    onPressed: () {},
                                  );
                                }),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
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
      floatingActionButton: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
        elevation: 8.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              gradient: AppColors.DRORedGradient,
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(20.0)),
          width: 150.0,
          height: 40.0,
          child: RawMaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.yellow,
                  child: Text('2'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
