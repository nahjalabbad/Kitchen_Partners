// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants/themes.dart';
import '../../utils/text_style.dart';
import '../../widgets/custom_appbar.dart';
import '../home/components/morerecipe2.dart';

class SearchResult extends StatefulWidget {
  String? title;
  String? time;
  String? category;
  String? ingridients;
  SearchResult(
      {Key? key,
      required this.title,
      required this.time,
      required this.category,
      required this.ingridients})
      : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Stream<QuerySnapshot>? _quotesStream;
  @override
  void initState() {
    print(widget.title);
    _quotesStream = FirebaseFirestore.instance
        .collection('Recipe')
        .where('category', isEqualTo: widget.category)
        .where('time_estimate', isEqualTo: widget.time)
        .where('title', isGreaterThanOrEqualTo: widget.title.toString())
        .where('ingridients', isLessThanOrEqualTo: widget.ingridients)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarView(
            leftWidget: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 28,
                color: AppTheme.primaryTextColor,
              ),
            ),
            centerWidget: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Text(
                    "البحث    ",
                    style: TextStyles(context).getTitle2Style().copyWith(
                        color: AppTheme.primaryTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).padding.bottom + 8),
              children: [
                StreamBuilder(
                    stream: _quotesStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final chatdocs = snapshot.data!.docs;
                      print(snapshot.data!.docs);

                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                  chatdocs.length
                                      .toString(), //the number is the result (count of recipes in database)
                                  style: TextStyles(context)
                                      .getDescriptionStyle()
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.primaryColor)),
                              Text(
                                " النتائج",
                                style: TextStyles(context)
                                    .getDescriptionStyle()
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          ListView.builder(
                              itemCount: chatdocs.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return MoreRecipes2(
                                  data: chatdocs[index],
                                  isselected: false,
                                  imagepath: chatdocs[index]['image_url'],
                                  receipeName: chatdocs[index]['title'],
                                  serve: '0',
                                  time: chatdocs[index]['time_estimate'],
                                  category: chatdocs[index]['category'],
                                );
                              }),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
