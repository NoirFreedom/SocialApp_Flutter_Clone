import 'package:TikTok/constants/breakpoints.dart';
import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/features/settings/settings_screen.dart';
import 'package:TikTok/features/users/view_models/users_view_model.dart';
import 'package:TikTok/features/users/views/user_profile_edit.dart';
import 'package:TikTok/features/users/views/widgets/avatar.dart';
import 'package:TikTok/features/users/views/widgets/persistent_tab_bar.dart';
import 'package:TikTok/features/users/views/widgets/user_profile_stats.dart';
import 'package:TikTok/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPress() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  void _onPenToSquarePress() {
    context.pushNamed(UserProfileEditScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      if (screenSize.width < Breakpoints.md)
                        SliverAppBar(
                          centerTitle: true,
                          title: Text(data.name),
                          actions: [
                            IconButton(
                              onPressed: _onPenToSquarePress,
                              icon: const FaIcon(FontAwesomeIcons.penToSquare,
                                  size: Sizes.size20),
                            ),
                            IconButton(
                              onPressed: _onGearPress,
                              icon: const FaIcon(FontAwesomeIcons.gear,
                                  size: Sizes.size20),
                            ),
                          ],
                        ),
                      SliverToBoxAdapter(
                        child: screenSize.width > Breakpoints.md
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 50.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Gaps.v20,
                                    const CircleAvatar(
                                      radius: 100,
                                      foregroundImage: NetworkImage(
                                          'https://images.unsplash.com/photo-1523572989266-8239d24ebb68?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YmxhY2slMjBhbmQlMjB3aGl0ZXxlbnwwfDB8MHx8fDA%3D'),
                                    ),
                                    Gaps.h60,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Channel Name",
                                              style: TextStyle(
                                                  fontSize: Sizes.size28,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Gaps.h28,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: Sizes.size7,
                                                      horizontal: Sizes.size32),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Sizes.size4),
                                                  ),
                                                  child: const TextButton(
                                                    onPressed: null,
                                                    child: Text(
                                                      "Follow",
                                                      style: TextStyle(
                                                        fontSize: Sizes.size16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                Gaps.h10,
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: Sizes.size6,
                                                      horizontal: Sizes.size12),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: Sizes.size1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Sizes.size4),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: null,
                                                    child: Text(
                                                      "Message",
                                                      style: TextStyle(
                                                          fontSize: Sizes
                                                              .size16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: isDarkMode(
                                                                  context)
                                                              ? Colors
                                                                  .grey.shade200
                                                              : Colors.grey
                                                                  .shade800),
                                                    ),
                                                  ),
                                                ),
                                                Gaps.h10,
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: Sizes.size1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Sizes.size4),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: null,
                                                    icon: FaIcon(
                                                      FontAwesomeIcons
                                                          .caretDown,
                                                      size: Sizes.size12,
                                                      color: isDarkMode(context)
                                                          ? Colors.grey.shade200
                                                          : Colors
                                                              .grey.shade800,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Gaps.v10,
                                        SizedBox(
                                          height: Sizes.size52,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              UserProfileStats(
                                                  screenSize: screenSize,
                                                  count: "99",
                                                  title: "Posts"),
                                              VerticalDivider(
                                                width: Sizes.size32,
                                                thickness: Sizes.size1,
                                                color: Colors.grey.shade400,
                                                indent: Sizes.size18,
                                                endIndent: Sizes.size18,
                                              ),
                                              UserProfileStats(
                                                  screenSize: screenSize,
                                                  count: "99M",
                                                  title: "Followers"),
                                              VerticalDivider(
                                                width: Sizes.size32,
                                                thickness: 1,
                                                color: Colors.grey.shade400,
                                                indent: Sizes.size18,
                                                endIndent: Sizes.size18,
                                              ),
                                              UserProfileStats(
                                                  screenSize: screenSize,
                                                  count: "99",
                                                  title: "Following"),
                                            ],
                                          ),
                                        ),
                                        Gaps.v10,
                                        Row(
                                          children: [
                                            Text(
                                              data.name,
                                              style: const TextStyle(
                                                  fontSize: Sizes.size16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Gaps.h5,
                                            FaIcon(
                                              FontAwesomeIcons.solidCircleCheck,
                                              size: Sizes.size16,
                                              color: Colors.blue.shade400,
                                            ),
                                          ],
                                        ),
                                        Gaps.v14,
                                        const Text(
                                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                          textAlign: TextAlign.center,
                                        ),
                                        Gaps.v20,
                                        const Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.link,
                                              size: Sizes.size12,
                                            ),
                                            Gaps.h4,
                                            Text(
                                              "www.gloomdev.com",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Gaps.v10,
                                  Avatar(
                                    name: data.name,
                                    hasAvatar: data.hasAvatar,
                                    uid: data.uid,
                                  ),
                                  Gaps.v10,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "@${data.name}",
                                        style: const TextStyle(
                                            fontSize: Sizes.size16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Gaps.h5,
                                      FaIcon(
                                        FontAwesomeIcons.solidCircleCheck,
                                        size: Sizes.size16,
                                        color: Colors.blue.shade400,
                                      )
                                    ],
                                  ),
                                  Gaps.v20,
                                  SizedBox(
                                    height: Sizes.size52,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        UserProfileStats(
                                            screenSize: screenSize,
                                            count: "99",
                                            title: "Posts"),
                                        VerticalDivider(
                                          width: Sizes.size32,
                                          thickness: Sizes.size1,
                                          color: Colors.grey.shade400,
                                          indent: Sizes.size10,
                                          endIndent: Sizes.size18,
                                        ),
                                        UserProfileStats(
                                            screenSize: screenSize,
                                            count: "99M",
                                            title: "Followers"),
                                        VerticalDivider(
                                          width: Sizes.size32,
                                          thickness: 1,
                                          color: Colors.grey.shade400,
                                          indent: Sizes.size10,
                                          endIndent: Sizes.size18,
                                        ),
                                        UserProfileStats(
                                            screenSize: screenSize,
                                            count: "99",
                                            title: "Following"),
                                      ],
                                    ),
                                  ),
                                  Gaps.v14,
                                  FractionallySizedBox(
                                    widthFactor: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: Sizes.size6,
                                              horizontal: Sizes.size32),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                Sizes.size4),
                                          ),
                                          child: const Text(
                                            "Follow",
                                            style: TextStyle(
                                              fontSize: Sizes.size16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Gaps.h8,
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: Sizes.size6,
                                              horizontal: Sizes.size10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: Sizes.size1),
                                            borderRadius: BorderRadius.circular(
                                                Sizes.size4),
                                          ),
                                          child: Text(
                                            "Message",
                                            style: TextStyle(
                                                fontSize: Sizes.size14,
                                                fontWeight: FontWeight.w600,
                                                color: isDarkMode(context)
                                                    ? Colors.grey.shade200
                                                    : Colors.grey.shade800),
                                          ),
                                        ),
                                        Gaps.h8,
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: Sizes.size8,
                                              horizontal: Sizes.size10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: Sizes.size1),
                                            borderRadius: BorderRadius.circular(
                                                Sizes.size4),
                                          ),
                                          child: FaIcon(
                                            FontAwesomeIcons.caretDown,
                                            size: Sizes.size12,
                                            color: isDarkMode(context)
                                                ? Colors.grey.shade200
                                                : Colors.grey.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gaps.v32,
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Sizes.size32),
                                    child: Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Gaps.v14,
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.link,
                                        size: Sizes.size12,
                                      ),
                                      Gaps.h4,
                                      Text(
                                        "www.gloomdev.com",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Gaps.v20,
                                ],
                              ),
                      ),
                      SliverPersistentHeader(
                          delegate: PersistentTabBar(screenSize: screenSize),
                          pinned: true)
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 20,
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                screenSize.width < Breakpoints.lg ? 3 : 5,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 9 / 13),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 12.3,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholder:
                                        "assets/images/placeholder.jpg",
                                    image:
                                        "https://images.unsplash.com/photo-1542887800-faca0261c9e1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2856&q=80",
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  bottom: 10,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                        size: Sizes.size16,
                                      ),
                                      Gaps.h4,
                                      Text(
                                        "99K",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenSize.width <
                                                    Breakpoints.md
                                                ? Sizes.size12
                                                : Sizes.size16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v10,
                          ],
                        ),
                      ),
                      const Center(
                        child: Text("Page 2"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
