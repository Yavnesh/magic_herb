import 'package:flutter/material.dart';

class ProjectDescriptionScreen extends StatefulWidget {
  const ProjectDescriptionScreen({Key? key}) : super(key: key);

  @override
  _ProjectDescriptionScreenState createState() => _ProjectDescriptionScreenState();
}

class _ProjectDescriptionScreenState extends State<ProjectDescriptionScreen> {
  final List<String> images = [
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
    "https://image.freepik.com/free-vector/cosmetic-product-background_52683-205.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SliverToBoxAdapter(
            child: Container(
                padding: EdgeInsets.all(20.0),
                color: Colors.redAccent,
                child: Text("Recommended for you".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return _buildListItem(index);
              },
              childCount: images.length,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(color: Colors.grey)
    );
  }
  Widget _buildListItem(int index) {
    return Container(
        height: 100,
        child: Card(
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(images[index % images.length]),
              ),
              title: Text(
                'Top Quality fashion item',
                softWrap: true,
              ),
              subtitle: Text(
                'Rs.1,254',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ),
        ));
  }
}
