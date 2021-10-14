import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile(
      {Key? key,
      required this.name,
      required this.username,
      required this.image,
      required this.isFollowedByMe,
      required this.onPressed})
      : super(key: key);

  final String name;
  final String username;
  final String image;
  final bool isFollowedByMe;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(image),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 8),
              Text(username, style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: onPressed,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 110,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isFollowedByMe ? Colors.transparent : Colors.grey.shade500,
                ),
                color: isFollowedByMe ? Colors.blue : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  isFollowedByMe ? 'Followed' : 'Follow',
                  style: TextStyle(
                    color: isFollowedByMe ? Colors.white : Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
