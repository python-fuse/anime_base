import 'package:anime_base/pages/anime_detail.dart';
import 'package:anime_base/widgets/related_detail.dart';
import 'package:flutter/material.dart';

class RelatedCard extends StatelessWidget {
  final dynamic anime;
  const RelatedCard({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RelatedDetail(anime: anime);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                spreadRadius: 1,
              )
            ]),
        margin: const EdgeInsets.only(top: 5, right: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            anime.imageUrl,
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
