import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class CarouselShowcase extends StatefulWidget {
  const CarouselShowcase({super.key});

  @override
  State<CarouselShowcase> createState() => _CarouselShowcaseState();
}

class _CarouselShowcaseState extends State<CarouselShowcase> {
  CarouselController carouselController1 = CarouselController();
  CarouselController carouselController2 = CarouselController();
  CarouselController carouselController3 = CarouselController();
  CarouselController carouselController4 = CarouselController();

  Widget get divider => const Divider(height: 50, endIndent: 8, indent: 8, thickness: 0.25);

  Widget get sizedBox => const SizedBox(height: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      appBar: AppBar(
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            sizedBox,
            type1Carousel,
            divider,
            type2Carousel,
            divider,
            type3Carousel,
            divider,
            accountCarousel,
            sizedBox,
          ],
        ),
      ),
    );
  }

  Widget get accountCarousel => VCProductComponents.vcCarousel<int>(
      height: 245, enableInfiniteScroll: false, items: const [2, 3, 4, 5], itemBuilder: (item) => accountCarouselItem, carouselController: carouselController4);

  Widget get type1Carousel => VCProductComponents.vcCarousel<int>(
        carouselController: carouselController1,
        aspectRatio: 358 / 140,
        autoPlay: true,
        viewportFraction: 1,
        items: const [2, 3, 4, 5],
        itemBuilder: (item) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/carousel/$item.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      );

  Widget get type2Carousel => VCProductComponents.vcCarousel<int>(
        carouselController: carouselController2,
        aspectRatio: 358 / 125,
        autoPlay: true,
        viewportFraction: 0.8,
        items: const [2, 3, 4, 5],
        itemBuilder: (item) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/carousel/$item.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      );

  Widget get type3Carousel => VCProductComponents.vcCarousel<int>(
        carouselController: carouselController3,
        aspectRatio: 358 / 120,
        autoPlay: true,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        enlargeFactor: 0.5,
        items: const [2, 3, 4, 5],
        indicatorMargin: const EdgeInsets.all(15),
        itemBuilder: (item) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/carousel/$item.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      );

  Widget get accountCarouselItem => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(blurRadius: 7, spreadRadius: 1, color: VCProductColors.instance.black.withOpacity(0.05)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 2.0),
                child: Text(
                  "MY CURRENT ACCOUNT",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    height: 1,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                    decoration: BoxDecoration(color: const Color(0xffFFEEBA), borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Icon(Icons.wallet_rounded, color: VCProductColors.instance.black75, size: 24),
                        const SizedBox(width: 4),
                        const Text(
                          "Current",
                          style: TextStyle(height: 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "20125659",
                    style: TextStyle(height: 1),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Available Balance",
                  style: TextStyle(
                    color: VCProductColors.instance.black75,
                    fontSize: 13,
                    height: 1,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "\$6.525,00",
                  style: TextStyle(
                    fontSize: 25,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Divider(
                color: VCProductColors.instance.black25.withOpacity(0.075),
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: VCProductColors.instance.navyBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.recycling, size: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Transfer",
                        style: TextStyle(height: 1),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: VCProductColors.instance.navyBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.payments_outlined, size: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Pay Bill",
                        style: TextStyle(height: 1),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: VCProductColors.instance.navyBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.account_balance, size: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Detail",
                        style: TextStyle(height: 1),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
