import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:listview_bloc/feature/destination/widget/app_text.dart';
import 'package:listview_bloc/feature/destination/widget/shimmer_effect.dart';
import 'app_colors.dart';
import 'app_icon_text.dart';
import 'constant.dart';
class GridItem extends StatelessWidget {
  final String name;
  final String region;
  final String photo;

  const GridItem({
    required this.name,
    required this.region,
    required this.photo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          color: AppColors.grey,
          width: 0.1,
        ),
        color: AppColors.whiteColor,
      ),
      child: Column(
        children: [
          _buildImage(),
          const SizedBox(
            height: 8,
          ),
          _buildText(),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        height: 300,
        imageUrl: photo,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(
          child: ShimmerEffect.rectangular(
            height: 300,
            isCircle: false,
          ),
        ),
        errorWidget: (context, url, error) {
          return _buildError(120, 120);
        },
      ),
    );
  }

  Widget _buildText() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(
            text: name,
            size: 15,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
            spacing: 2,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: AppIconText(
            text: region,
            spacing: 3,
            size: 13,
            color: AppColors.primaryColorOfApp,
            icon: const Icon(
              Icons.location_on_outlined,
              size: 13,
              color: AppColors.primaryColorOfApp,
            ),
            isIconFirst: true,
          ),
        ),
      ],
    );
  }

  Widget _buildError(double? width, double? height) {
    return Center(
      child: SvgPicture.asset(
        placeholderImage,
        width: width,
        height: height,
      ),
    );
  }
}