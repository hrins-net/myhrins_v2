import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/credit_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/quota_card.dart';
import '../widgets/promo_carousel.dart';
import '../widgets/quick_actions_card.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/exclusive_services.dart';

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
      backgroundColor: const Color(0xFFF3F4F6), // Light grey background
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Unified Stack containing the blue background and top cards so they scroll together naturally!
            Stack(
              children: [
                // Blue Curved Header Background
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 405 + MediaQuery.of(context).padding.top, // Dynamic height matching notch depth
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF1E325C), // Lighter Navy
                          AppColors.primary,  // Primary Navy Dark Blue (0xFF0F254E)
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Decorative circular wave shapes to emulate circular pattern in background
                        Positioned(
                          top: -100,
                          right: -100,
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withAlpha(7),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -50,
                          left: -50,
                          child: Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withAlpha(5),
                            ),
                          ),
                        ),
                        // Vector curved lines overlay (softened)
                        CustomPaint(
                          size: Size.infinite,
                          painter: HeaderCurvesPainter(),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Top Cards sitting on the blue background
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Dynamic notch/status bar spacing + clean margin
                    SizedBox(height: MediaQuery.of(context).padding.top + 6),
                    
                    // Profile Header Widget
                    const ProfileHeader(
                      phoneNumber: '+1 (646) 555-4099',
                      activeUntil: '30 مايو 2025', // Translated active until date to Arabic
                      points: '1,000',
                      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
                    ),
                    
                    const SizedBox(height: 12), // Spacing between header and CreditCard
                    
                    // Credit & Top-Up Card Widget
                    CreditCard(
                      amount: '250\$',
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
                    ),
                    
                    const SizedBox(height: 4), // Spacing between CreditCard and QuotaCard
                    
                    // Internet Quota Card Widget
                    QuotaCard(
                      usedGB: 22.6,
                      totalGB: 40.0,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'تم الضغط على تفاصيل سعة الإنترنت',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 16), // Bottom buffer spacing to clear the background
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 4), // Small spacing before QuickActionsCard
            
            // Quick Actions Menu Card
            const QuickActionsCard(),
            
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
