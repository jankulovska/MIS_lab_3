import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: category.strCategoryThumb,
            width: 64,
            height: 64,
            placeholder: (ctx, url) => CircularProgressIndicator(),
            errorWidget: (ctx, url, err) => Icon(Icons.image_not_supported),
          ),
          title: Text(category.strCategory),
          subtitle: Text(
            category.strCategoryDescription.length > 80 ? category.strCategoryDescription.substring(0, 80) + '...' : category.strCategoryDescription,
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
    );
  }
}