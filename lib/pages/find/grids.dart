import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BasicGridView extends StatefulWidget {
  BasicGridView({Key? key}) : super(key: key);

  @override
  State<BasicGridView> createState() => _BasicGridViewState();
}

class _BasicGridViewState extends State<BasicGridView> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      /// mansonry grid view, there are many type of grid view check https://pub.dev/packages/flutter_staggered_grid_view
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 8,
        itemCount: 21,
        itemBuilder: (context, index) {
          return buildImageCard(index);
        },
      ),
    );
  }

  /// build each image card for grid view
  Widget buildImageCard(int index) => Column(
        children: [
          /**
           * - MARK: incomplete widget for title
           */
          // Text('title'),
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://source.unsplash.com/random?sig=$index",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      );
}
