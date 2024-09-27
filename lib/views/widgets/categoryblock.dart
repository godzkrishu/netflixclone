import 'package:flutter/material.dart';
import 'package:netflixclone/models/moviemodel.dart';
import 'package:go_router/go_router.dart';

class Categoryblock extends StatelessWidget {
  final Moviemodel movie;
  String? catName;
  Categoryblock({
    super.key,
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/detail', extra: movie);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            ClipRRect(
                //clip the image
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                    height: 400,
                    width: 400,
                    fit: BoxFit.fill,
                   movie.image ??
                        "https://static.tvmaze.com/uploads/images/medium_portrait/425/1064746.jpg")),
            Container(
              //for dark screen above the image
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black26,
              ),
            ),
            Positioned(
              // this is  box that can be anywhere in screen by left , right .. property
              left: 140,
              bottom: 20,
              child: Text(
                catName ?? "All American",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
