import 'package:ecomerce/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes.dart';
import '../widgets/categories_services_widget.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarWidget(isHome: false),
            SizedBox(height: 100.h),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  CategoryBox(
                    title: 'Login',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.login,
                      );
                    },
                  ),
                  CategoryBox(
                    title: 'Add Product',
                    onPressed: () {},
                  ),
                  CategoryBox(
                    title: 'Category 3',
                    onPressed: () {},
                  ),
                  CategoryBox(
                    title: 'Category 4',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
