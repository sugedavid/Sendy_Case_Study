import 'package:flutter/material.dart';
import 'package:sendy_case_study/domain/value_objects/app_strings.dart';
import 'package:sendy_case_study/presentation/LogInPage.dart';
import 'package:sendy_case_study/shared/Colors.dart';

import '../domain/value_objects/items.dart';
import '../shared/components/Welcome/SlidingImages.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<Widget> slides = items
      .map((item) => SlidingImages(
            item: item,
          ))
      .toList();

  List<Widget> indicator() => List<Widget>.generate(
      slides.length,
      (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
                color: currentPage.round() == index
                    ? AppColors.primaryColor
                    : Color(0XFF256075).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));

  double currentPage = 0.0;
  final _pageViewController = new PageController();

  @override
  void initState() {
    super.initState();
    _pageViewController.addListener(() {
      setState(() {
        currentPage = _pageViewController.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: width >= 500 ? null : Colors.white,
      body: SafeArea(
        child: width >= 500
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                    child: SizedBox(
                        width: 400,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(38.0),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: PageView.builder(
                                    controller: _pageViewController,
                                    itemCount: slides.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return slides[index];
                                    },
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: indicator(),
                                        ),
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // Sign up
                                          Text(
                                            signUpText,
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 18,
                                            ),
                                          ),

                                          VerticalDivider(
                                            thickness: 1,
                                            color: Colors.black38,
                                          ),

                                          // Log In
                                          GestureDetector(
                                            onTap: (() => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginPage()),
                                                )),
                                            child: Text(
                                              loginText,
                                              style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))),
              )
            : Stack(
                children: <Widget>[
                  PageView.builder(
                    controller: _pageViewController,
                    itemCount: slides.length,
                    itemBuilder: (BuildContext context, int index) {
                      return slides[index];
                    },
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          margin: EdgeInsets.only(top: 70.0),
                          padding: EdgeInsets.symmetric(vertical: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: indicator(),
                          ),
                        ),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Sign up
                            Text(
                              signUpText,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 18,
                              ),
                            ),

                            VerticalDivider(
                              thickness: 1,
                              color: Colors.black38,
                            ),

                            // Log In
                            GestureDetector(
                              onTap: (() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                  )),
                              child: Text(
                                loginText,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
