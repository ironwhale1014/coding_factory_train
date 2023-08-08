import 'package:coding_factory_train/rating/model/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

/*
       {
            "id": "9eca580a-d614-44fd-a8a9-1f1e8176c3d8",
            "imgUrls": [],
            "user": {
                "id": "f55b32d2-4d68-4c1e-a3ca-da9d7d0d92e5",
                "username": "test@codefactory.ai",
                "imageUrl": "/img//logo/codefactory_logo.png"
            },
            "content": "양도 많고 맛있어요~ 배달기사님도 이때까지 뵀던 분중에 가장 친절하셨습니다 ㅎㅎ",
            "rating": 5
        },
        {
            "id": "c7094601-e840-4412-b35a-c7754adeafb4",
            "imgUrls": [
                "/img/떡볶이/즉석떡볶이.jpg",
                "/img/떡볶이/라면떡볶이.jpg",
                "/img/떡볶이/짜장떡볶이.jpg",
                "/img/떡볶이/닭갈비떡볶이.jpg",
                "/img/떡볶이/야채떡볶이.jpg"
            ],
            "user": {
                "id": "4d5ad253-55b1-4a4a-8972-cfb3b746305d",
                "username": "Santos_Heller@hotmail.com",
                "imageUrl": "/img//logo/codefactory_logo.png"
            },
            "content": "감사합니다 배달 엄청 빨랐어요! 양도 많고 굿!",
            "rating": 5
        },
 */

class RatingCard extends StatelessWidget {
  const RatingCard(
      {super.key,
      required this.username,
      required this.avatarImage,
      required this.rating,
      required this.content,
      required this.images});

  final String username;
  final ImageProvider avatarImage;
  final int rating;
  final String content;
  final List<Image> images;

  factory RatingCard.fromModel(RatingModel ratingModel) {
    return RatingCard(
      username: ratingModel.user.username,
      avatarImage: NetworkImage(ratingModel.user.imageUrl),
      rating: ratingModel.rating,
      content: ratingModel.content,
      images: ratingModel.imgUrls.map((e) => Image.network(e)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(username: username, avatarImage: avatarImage, rating: rating),
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
  const _Header(
      {super.key,
      required this.avatarImage,
      required this.username,
      required this.rating});

  final ImageProvider avatarImage;
  final String username;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 12, backgroundImage: avatarImage),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            username,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 14),
          ),
        ),
        ...List.generate(
            5,
            (index) => Icon(
                (index < rating) ? Icons.star : Icons.star_border_outlined))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: Text(content)),
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
      children: images.mapIndexed((index, element) {
        return Padding(
          padding:
              EdgeInsets.only(right: (index - 1 == images.length) ? 0 : 16),
          child:
              ClipRRect(borderRadius: BorderRadius.circular(8), child: element),
        );
      }).toList(),
    );
  }
}
