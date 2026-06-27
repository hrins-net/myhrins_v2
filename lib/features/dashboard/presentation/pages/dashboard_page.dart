import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/promo_carousel.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/exclusive_services.dart';
import '../widgets/unified_dashboard_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 2; // Default to Analytics (Active) to match the mockup exactly

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // Display a clean feedback SnackBar when switching tabs in this static single-page mock
    String tabName = '';
    switch (index) {
      case 0:
        tabName = 'Home';
        break;
      case 1:
        tabName = 'Search';
        break;
      case 2:
        tabName = 'Analytics';
        break;
      case 3:
        tabName = 'History';
        break;
      case 4:
        tabName = 'Profile';
        break;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Switched to tab: $tabName',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Pure White Page Background (Option C)
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dynamic notch/status bar spacing + clean margin
            SizedBox(height: MediaQuery.of(context).padding.top + 6),
            
            // Profile Header Widget (Now rendered on the clean white page background)
            const ProfileHeader(
              phoneNumber: '+1 (646) 555-4099',
              activeUntil: '30 مايو 2025', // Translated active until date to Arabic
              points: '1,000',
              avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
              isDarkBackground: false, // Switch to dark text/icons for light background compatibility
            ),
            
            const SizedBox(height: 12), // Spacing between header and card
            
            // Unified Dashboard Card containing Quota and Quick Actions (Now an elegant indigo credit-card floating on white)
            UnifiedDashboardCard(
              usedGB: 22.6,
              totalGB: 40.0,
              onTopUpPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'تم الضغط على شحن الرصيد',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
              onQuotaPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'تم الضغط على تفاصيل سعة الإنترنت',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
              onActionPressed: (index) {
                String actionName = '';
                switch (index) {
                  case 0:
                    actionName = 'شراء باقات';
                    break;
                  case 1:
                    actionName = 'إرسال هدية';
                    break;
                  case 2:
                    actionName = 'اختبار السرعة';
                    break;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'تم الضغط على: $actionName',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16), // Bottom buffer spacing
            
            const SizedBox(height: 4), // Small spacing between QuickActions and PromoCarousel
            
            // Image Slider / Carousel with 3 rotating images
            const PromoCarousel(),
            
            const SizedBox(height: 8), // Spacing between PromoCarousel and ExclusiveServices
            
            // Exclusive Services ("حصري لك") Section
            const ExclusiveServices(),
            
            const SizedBox(height: 75),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

// Custom Painter to draw wave line effects matching circular vector lines (softened for a premium look)
class HeaderCurvesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha(5) // Extremely soft line opacity
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // Circular vector waves centered at top-left
    const center1 = Offset(-40, -40);
    for (double r = 60; r < 400; r += 16) {
      canvas.drawCircle(center1, r, paint);
    }

    // Circular vector waves centered at top-right
    final center2 = Offset(size.width + 40, -40);
    for (double r = 80; r < 500; r += 20) {
      canvas.drawCircle(center2, r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant HeaderCurvesPainter oldDelegate) => false;
}
