import 'package:flutter/material.dart';
import 'package:pharmacy_dro/core/appColors.dart';
import 'package:pharmacy_dro/pharmacy/app/bloc/pharm_bloc.dart';
import 'package:pharmacy_dro/pharmacy/data/repository/pharmacy_repo.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/local_source.dart';
import 'package:pharmacy_dro/pharmacy/data/sources/remote_source.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String)? onChanged;
  final Widget title;
  final Function()? onTapCart;

  final bool hasSearchBar;
  final bool hasFavourite;
  final bool hasCart;
  final bool hasTruck;
  final bool cartHasItem;
  const SearchAppBar({
    Key? key,
    this.onChanged,
    this.onTapCart,
    this.hasSearchBar = true,
    this.hasFavourite = true,
    this.hasTruck = false,
    this.cartHasItem = true,
    this.title = const Text(
      'Pharmacy',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    this.hasCart = true,
  }) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(hasSearchBar ? 130 : kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  PharmBloc pharmBloc = PharmBloc(
    DrugRepository(
      DrugRemoteDataSource(),
      DrugLocalDataSource(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade200,
      toolbarHeight: widget.hasSearchBar ? 130 : kToolbarHeight,
      elevation: 0,
      title: widget.title,
      actions: [
        if (widget.hasFavourite)
          IconButton(
              onPressed: () {},
              icon: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Icon(Icons.favorite_outline),
                  if (widget.cartHasItem)
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.amberAccent,
                    ),
                ],
              )),
        if (widget.hasCart)
          IconButton(
              onPressed: widget.onTapCart,
              icon: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  if (widget.cartHasItem)
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.amberAccent,
                    ),
                ],
              )),
        if (widget.hasTruck)
          InkWell(
            onTap: widget.onTapCart,
            borderRadius: BorderRadius.circular(20.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 20, top: 8.0),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Image.asset(
                    'assets/delivery.png',
                    width: 30.0,
                    color: Colors.white,
                  ),
                  if (widget.cartHasItem)
                    Positioned(
                      top: 3,
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.amberAccent,
                      ),
                    ),
                ],
              ),
            ),
          )
      ],
      flexibleSpace: Container(
        height: widget.hasSearchBar ? null : 100,
        decoration: BoxDecoration(
          gradient: AppColors.dROPurpleGradient,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
        ),
      ),
      bottom: widget.hasSearchBar
          ? PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Container(
                margin: EdgeInsets.all(20.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  gradient: AppColors.dROPurpleGradient,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  onChanged: (value) {
                    widget.onChanged!(value);
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        'assets/loupe.png',
                        color: Colors.white,
                        filterQuality: FilterQuality.high,
                        scale: 20,
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
            )
          : null,
    );
  }
}
