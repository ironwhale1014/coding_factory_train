import 'package:coding_factory_train/common/const/colors.dart';
import 'package:coding_factory_train/rating/model/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class RatingCard extends StatelessWidget {
  RatingCard(
      {super.key,
      required this.avatarImage,
      required this.images,
      required this.rating,
      required this.email,
      required this.content});

  final ImageProvider avatarImage;
  final List<Image> images;
  final int rating;
  final String email;
  final String content;

  factory RatingCard.fromModel({required RatingModel ratingModel}) {
    return RatingCard(
      avatarImage: NetworkImage(ratingModel.user.imageUrl),
      images: ratingModel.imgUrls.map((e) => Image.network(e)).toList(),
      rating: ratingModel.rating,
      email: ratingModel.user.username,
      content: ratingModel.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          rating: rating,
          email: email,
        ),
        const SizedBox(height: 8),
        _Body(content: content),
        if (images.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(height: 100, child: _Images(images: images)),
          )
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final int rating;
  final String email;

  const _Header(
      {super.key,
      required this.avatarImage,
      required this.rating,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: avatarImage,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 14),
          ),
        ),
        ...List.generate(
            5,
            (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border_outlined,
                  color: PRIMARY_COLOR,
                )),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(content,
              style: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14)),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  const _Images({super.key, required this.images});

  final List<Image> images;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images
          .mapIndexed((index, e) => Padding(
                padding:
                    EdgeInsets.only(right: index == images.length - 1 ? 0 : 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: e,
                ),
              ))
          .toList(),
    );
  }
}
