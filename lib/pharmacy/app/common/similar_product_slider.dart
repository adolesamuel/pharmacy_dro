import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_dro/pharmacy/app/bloc/pharm_bloc.dart';
import 'package:pharmacy_dro/pharmacy/app/common/drug_list_item.dart';
import 'package:pharmacy_dro/pharmacy/app/pages/single_drug_page.dart';
import 'package:pharmacy_dro/pharmacy/data/repository/pharmacy_repo.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/local_source.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/remote_source.dart';

class SimilarProductSlider extends StatefulWidget {
  const SimilarProductSlider({Key? key}) : super(key: key);

  @override
  State<SimilarProductSlider> createState() => _SimilarProductSliderState();
}

class _SimilarProductSliderState extends State<SimilarProductSlider> {
  @override
  Widget build(BuildContext context) {
    PharmBloc pharmBloc = PharmBloc(
      DrugRepository(
        DrugRemoteDataSource(),
        DrugLocalDataSource(),
      ),
    );
    return BlocProvider<PharmBloc>(
      create: (context) => pharmBloc..add(GetDrugsEvent()),
      child: BlocConsumer<PharmBloc, PharmState>(
        listener: (context, state) {},
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
                    height: 200.0,
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
                                          drug: state.drugs[index])));
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
