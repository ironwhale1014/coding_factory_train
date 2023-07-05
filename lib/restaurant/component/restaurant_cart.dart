import 'package:coding_factory_train/common/const/colors.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard(
      {super.key,
      required this.image,
      required this.name,
      required this.tags,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.ratings});

  final Widget image;
  final String name;
  final List<String> tags;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final double ratings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          child: image,
          borderRadius: BorderRadius.circular(12),
        ),
        SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Text(
              tags.join(" · "),
              style: TextStyle(fontSize: 14, color: BODY_TEXT_COLOR),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                _IconText(label: ratings.toString(), icon: Icons.star),
                renderDot(),
                _IconText(label: ratingsCount.toString(), icon: Icons.receipt),
                renderDot(),
                _IconText(
                    label: "$deliveryTime min", icon: Icons.timelapse_outlined),
                renderDot(),
                _IconText(
                    label: deliveryFee == 0 ? '무료' : deliveryFee.toString(),
                    icon: Icons.monetization_on),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget renderDot(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text("·",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),),
    );
  }
}



class _IconText extends StatelessWidget {
  const _IconText({super.key, required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        )
      ],
    );
  }
}
