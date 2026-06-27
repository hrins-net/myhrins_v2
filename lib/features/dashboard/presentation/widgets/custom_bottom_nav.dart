import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  // Custom Solid Pie Chart JSON to render a pixel-perfect solid pie chart matching the mockup
  static const List<List<dynamic>> customSolidPieChart = [
    [
      'path',
      {
        'key': '0',
        'd': 'M11.5 12.5 L11.5 3.5 A9 9 0 1 0 20.5 12.5 Z',
        'fill': 'currentColor',
      }
    ],
    [
      'path',
      {
        'key': '1',
        'd': 'M13 11 L13 2 A9 9 0 0 1 22 11 Z',
        'fill': 'currentColor',
      }
    ]
  ];

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    
    // Proportional height matching standard iOS navigation bars: 58px + bottom safety padding
    final double barHeight = 58.0 + bottomPadding;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: barHeight,
        decoration: const BoxDecoration(
          color: Colors.white, // Pure white background (#FFFFFF)
          border: null,        // Clean layout with no borders or shadows
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding, left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                index: 0,
                icon: HugeIcons.strokeRoundedHome01,
                activeIcon: HugeIcons.strokeRoundedHome01,
                label: 'Home',
              ),
              _buildNavItem(
                index: 1,
                icon: HugeIcons.strokeRoundedSearch01,
                activeIcon: HugeIcons.strokeRoundedSearch01,
                label: 'Search',
              ),
              _buildNavItem(
                index: 2,
                icon: HugeIcons.strokeRoundedPieChart,
                activeIcon: customSolidPieChart, // Solid pie chart when active
                label: 'Analytics',
              ),
              _buildNavItem(
                index: 3,
                icon: HugeIcons.strokeRoundedClock01,
                activeIcon: HugeIcons.strokeRoundedClock01,
                label: 'History',
              ),
              _buildNavItem(
                index: 4,
                icon: HugeIcons.strokeRoundedUser,
                activeIcon: HugeIcons.strokeRoundedUser,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required dynamic icon,
    dynamic activeIcon,
    required String label,
  }) {
    final bool isActive = selectedIndex == index;
    
    // Proportional colors matching the mockup design
    final Color activeColor = const Color(0xFF0F254E); // Navy Dark Blue
    final Color inactiveColor = const Color(0xFF7C7E83); // Elegant Muted Grey

    final dynamic iconData = isActive ? (activeIcon ?? icon) : icon;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Proportional Icon section (Elegant size: 24px, stroke 1.6)
            HugeIcon(
              icon: iconData as List<List<dynamic>>,
              color: isActive ? activeColor : inactiveColor,
              size: 24.0,
              strokeWidth: 1.6,
            ),
            const SizedBox(height: 4), // Balanced 4px spacing
            
            // Proportional Label section (Sleek 11px, weight 500/600)
            Text(
              label,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: isActive ? activeColor : inactiveColor,
                fontSize: 11.0,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
