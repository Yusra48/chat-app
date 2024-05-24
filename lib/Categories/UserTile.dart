import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const UserTile({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 120,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xF4F1A1AE),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2024/04/18/03/17/ai-generated-8703394_960_720.png'),
              radius: 24,
            ),
            const SizedBox(width: 20),
            Text(text),
          ],
        ),
      ),
    );
  }
}
