import 'package:cryptocurrency/core/init/theme/dark_color_scheme/dark_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String?) onChanged;
  const SearchBar(
      {Key? key, required this.searchController, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: TextField(
        autofocus: true,
        controller: searchController,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: context.normalBorderRadius,
          ),
          filled: true,
          fillColor: DarkColorScheme.instance!.darkBlue,
          hintText: 'Search Coin...',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
