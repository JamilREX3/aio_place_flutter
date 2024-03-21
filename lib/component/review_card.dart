import 'package:aio_place/component/star_rating.dart';
import 'package:aio_place/models/review_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReviewCard extends StatelessWidget {
  final ReviewModel reviewModel;

  const ReviewCard({Key? key, required this.reviewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    reviewModel.user?.profileImg ??
                        'https://www.w3schools.com/howto/img_avatar.png'),
                radius: 16,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reviewModel.user!.name!,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text(
                    timeago.format(
                        DateTime.parse(reviewModel.updatedAt.toString()),
                        locale: 'en_short'),
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              StarRating(
                rating: reviewModel.ratings!.toDouble(),
                size: 16,
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(reviewModel.title ?? ''),
        ],
      ),
    );
  }
}
