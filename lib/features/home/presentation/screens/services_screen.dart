import 'package:ecomerce/core/utils/cache_helper.dart';
import 'package:ecomerce/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:ecomerce/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            Expanded(flex: 1, child: SizedBox()),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Expanded(
                  flex: 2,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      CacheHelper.getData(key: "jwt") == null
                          ? CategoryBox(
                              title: 'Login',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.login,
                                );
                              },
                            )
                          : CategoryBox(
                              title: 'Account information',
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.accountInformation,
                                    arguments: 3);
                              },
                            ),
                      CategoryBox(
                        title: 'My Products',
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.myProducts,
                          );
                        },
                      ),
                      // CategoryBox(
                      //   title: 'Category 3',
                      //   onPressed: () {},
                      // ),
                      // CategoryBox(
                      //   title: 'Category 4',
                      //   onPressed: () {},
                      // ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
