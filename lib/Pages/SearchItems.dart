import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchItems extends StatefulWidget {
  const SearchItems({Key? key}) : super(key: key);

  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  String? userSelected;

  get StateService => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(right: 18.0, top: 8),
            child: SizedBox(
                height: 40,
                width: double.infinity,
                child: TypeAheadField(
                  debounceDuration: const Duration(milliseconds: 400),
                  suggestionsCallback: (value) {
                    return StateService.getSuggestions(value);
                  },
                  itemBuilder: (context, String suggestion) {
                    return Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.refresh,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              suggestion,
                              maxLines: 1,
                              // style: TextStyle(color: Colors.red),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  onSelected: (String value) {},
                )),
          ),
        ),
        body: Center(
          child: Text(
            userSelected ?? 'Search',
            style: const TextStyle(fontSize: 20),
          ),
        ));
  }
}
