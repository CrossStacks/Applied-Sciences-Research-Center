import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(8.0),
      width: screenWidth,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(5, 0, 0, 0),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: NavBarItem(
              title: "Journal of Zoology and Marine Biology",
              isSelected: true,
            ),
          ),
          Expanded(
            child: NavBarItem(
              title: "Journal of Psychology and Behavioral Science",
              isSelected: false,
            ),
          ),
          Expanded(
            child: NavBarItem(
              title: "Journal of Computer Science and Information Technology",
              isSelected: false,
            ),
          ),
          Expanded(
            child: NavBarItem(
              title: "Journal of Environmental Science and Public Health",
              isSelected: false,
            ),
          ),
          Expanded(
            child: NavBarItem(
              title: "Journal of Business and Management",
              isSelected: false,
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final String title;
  bool isSelected;
  NavBarItem({super.key, required this.title, required this.isSelected});

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    final Color selectedBackground = const Color.fromARGB(255, 245, 245, 245);
    final Color unselectedTextColor = const Color.fromARGB(255, 72, 76, 81);

    return InkWell(
      onTap: () {
        setState(() {
          widget.isSelected = true;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: widget.isSelected ? selectedBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 2,
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color:
                        widget.isSelected ? Colors.black : unselectedTextColor,
                  ),
                ),
              ),
            ),
            Container(
              height: 2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? const Color.fromARGB(255, 158, 157, 164)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
