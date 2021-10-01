import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String)? onChanged;
  final Function()? onTapCart;
  final bool hasSearchBar;
  const SearchAppBar(
      {Key? key, this.onChanged, this.onTapCart, this.hasSearchBar = true})
      : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(130);
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade200,
      toolbarHeight: widget.hasSearchBar ? 130 : kToolbarHeight,
      elevation: 0,
      title: Text('Pharmacy'),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
        IconButton(
            onPressed: widget.onTapCart,
            icon: Icon(Icons.shopping_cart_outlined)),
      ],
      flexibleSpace: Container(
        height: widget.hasSearchBar ? null : 100,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
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
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  onChanged: (value) {
                    widget.onChanged!(value);
                  },
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
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(10), child: SizedBox.shrink()),
    );
  }
}
