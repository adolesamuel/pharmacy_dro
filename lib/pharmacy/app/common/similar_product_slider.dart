import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_dro/pharmacy/app/bloc/pharm_bloc.dart';
import 'package:pharmacy_dro/pharmacy/app/common/drug_list_item.dart';
import 'package:pharmacy_dro/pharmacy/app/pages/single_drug_page.dart';
import 'package:pharmacy_dro/pharmacy/data/models/drug_model.dart';

class SimilarProductSlider extends StatefulWidget {
  const SimilarProductSlider({Key? key}) : super(key: key);

  @override
  State<SimilarProductSlider> createState() => _SimilarProductSliderState();
}

class _SimilarProductSliderState extends State<SimilarProductSlider> {
  List<Drug> similarDrugList = [];
  @override
  Widget build(BuildContext context) {
    PharmBloc pharmBloc = BlocProvider.of<PharmBloc>(context);
    return BlocProvider<PharmBloc>(
      create: (context) => pharmBloc..add(GetDrugsEvent()),
      child: BlocConsumer<PharmBloc, PharmState>(
        listener: (context, state) {
          if (state is GotDrugsState) {
            similarDrugList = state.drugs;
          }
        },
        builder: (context, state) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Similar Products',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                if (state is GotDrugsState)
                  Container(
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.drugs.length,
                      itemBuilder: (context, index) {
                        return DrugListItem(
                            drug: state.drugs[index],
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingleDrugPage(
                                          drug: state.drugs[index]))).then(
                                  (value) =>
                                      pharmBloc.add(GetDrugsFromCartEvent()));
                            });
                      },
                    ),
                  ),
                if (state is GotDrugsFromCartState)
                  Container(
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: similarDrugList.length,
                      itemBuilder: (context, index) {
                        return DrugListItem(
                            drug: similarDrugList[index],
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingleDrugPage(
                                          drug: similarDrugList[index]))).then(
                                  (value) =>
                                      pharmBloc.add(GetDrugsFromCartEvent()));
                            });
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
