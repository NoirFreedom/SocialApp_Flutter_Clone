import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:flutter/material.dart';

class UserProfileInfo extends StatelessWidget {
  final String? infoName;
  final VoidCallback? onTap;

  const UserProfileInfo({
    Key? key,
    this.infoName,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
        child: Row(
          children: [
            Text(
              infoName!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Gaps.h16,
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 258,
                  padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  child: Text(
                    infoName!,
                    style: const TextStyle(color: Colors.grey),
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
