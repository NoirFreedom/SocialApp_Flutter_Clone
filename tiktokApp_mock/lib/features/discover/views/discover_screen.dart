import 'package:TikTok/constants/breakpoints.dart';
import 'package:TikTok/features/discover/widgets/top_search_bar.dart';
import 'package:TikTok/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "List",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          title: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: Breakpoints.sm),
              child: const TopSearchBar()),
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            isScrollable: true,
            indicatorColor:
                isDarkMode(context) ? Colors.grey.shade300 : Colors.black,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: Sizes.size14),
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 3,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: TabBarView(
              children: [
                GridView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                      childAspectRatio: 9 / 20),
                  itemBuilder: (context, index) => LayoutBuilder(
                    builder: (context, constraints) => Column(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: AspectRatio(
                            aspectRatio: 9 / 16,
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: "assets/images/placeholder.jpg",
                              image:
                                  "https://images.unsplash.com/photo-1542887800-faca0261c9e1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2856&q=80",
                            ),
                          ),
                        ),
                        Gaps.v10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              const Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                style: TextStyle(
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Gaps.v5,
                              if (constraints.maxWidth < 200 ||
                                  constraints.maxWidth > 250)
                                DefaultTextStyle(
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://images.unsplash.com/photo-1482424917728-d82d29662023?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3105&q=80"),
                                        radius: 12,
                                        backgroundColor: Colors.black,
                                      ),
                                      Gaps.h3,
                                      Expanded(
                                        child: Text(
                                          "UserNameCouldBeLongerThanYouThought",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: Sizes.size14,
                                            fontWeight: FontWeight.w600,
                                            color: isDarkMode(context)
                                                ? Colors.grey.shade200
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.heart,
                                        size: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                      Gaps.h3,
                                      Text(
                                        "4.3M",
                                        style: TextStyle(
                                          fontSize: Sizes.size14,
                                          fontWeight: FontWeight.w600,
                                          color: isDarkMode(context)
                                              ? Colors.grey.shade200
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                for (var tab in tabs.skip(1))
                  Center(
                    child: Text(
                      tab,
                      style: const TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
