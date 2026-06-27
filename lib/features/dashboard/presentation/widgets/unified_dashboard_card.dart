import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class UnifiedDashboardCard extends StatelessWidget {
  final String subscriptionName;
  final String subscriptionSpeed;
  final String expiryDate;
  final bool isActive;
  final String downloadSpeed;
  final String uploadSpeed;
  final String remainingTime;
  final double progressValue; // e.g. 0.3 means 30% of the subscription time remaining
  final VoidCallback onTopUpPressed;
  final VoidCallback onQuotaPressed;
  final Function(int) onActionPressed;

  const UnifiedDashboardCard({
    super.key,
    this.subscriptionName = 'فايبر بلس',
    this.subscriptionSpeed = '100 Mbps',
    this.expiryDate = '30 مايو 2025',
    this.isActive = true,
    this.downloadSpeed = '90 Mbps',
    this.uploadSpeed = '92 Mbps',
    this.remainingTime = '8 يوم و 22 ساعة متبقية',
    this.progressValue = 0.3,
    required this.onTopUpPressed,
    required this.onQuotaPressed,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white, // Outer container base is white (for bottom actions half)
        borderRadius: BorderRadius.circular(24), // Premium rounded corners
        border: Border.all(
          color: const Color(0xFFE5E7EB).withAlpha(120), // Subtle light border for definition
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(6), // Soft, elegant drop shadow
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ================= TOP HALF: INDIGO SUBSCRIPTION QUOTA =================
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1E325C), // Lighter Navy
                  AppColors.primary,  // Primary Navy Dark Blue (0xFF0F254E)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22), // Fits inside the outer container radius
                topRight: Radius.circular(22),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onQuotaPressed,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Quota Header
                      Row(
                        children: [
                          // 1. Wifi/Speed Icon (Renders on the right in RTL as the starting icon)
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withAlpha(30), // Translucent white container
                              border: Border.all(
                                color: Colors.white.withAlpha(38),
                                width: 1.2,
                              ),
                            ),
                            child: const Icon(
                              Icons.wifi_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          
                          // 2. Subscription Details (Renders in the middle, RTL aligned)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subscriptionName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'السرعة: $subscriptionSpeed',
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(178),
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          
                          // 3. Active Status Badge (Renders on the left in RTL)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isActive 
                                  ? const Color(0xFF22C55E).withAlpha(38) // Translucent green
                                  : Colors.red.withAlpha(38),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: isActive ? const Color(0xFF4ADE80) : Colors.redAccent,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isActive ? const Color(0xFF22C55E) : Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  isActive ? 'نشط' : 'ملغي',
                                  style: TextStyle(
                                    color: isActive ? const Color(0xFF4ADE80) : Colors.redAccent,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 18),
                      
                      // Premium Custom Gradient Progress Bar (Orange/Gold on Navy)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final double maxWidth = constraints.maxWidth;
                          return Stack(
                            children: [
                              // Background track
                              Container(
                                height: 8,
                                width: maxWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(38),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              // Gradient Progress bar
                              Container(
                                height: 8,
                                width: maxWidth * progressValue,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFF97316), // Brand Orange
                                      Color(0xFFF59E0B), // Gold / Amber
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFF97316).withAlpha(102),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Remaining Time Label (e.g. 8 يوم و 22 ساعه متبقيه)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            remainingTime,
                            style: const TextStyle(
                              color: Color(0xFFFBBF24), // Vibrant Amber gold text for contrast
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${(progressValue * 100).toInt()}% متبقي',
                            style: TextStyle(
                              color: Colors.white.withAlpha(178),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Stats details (الرفع, التحميل, تاريخ الانتهاء)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Expiry Date (تاريخ الانتهاء)
                          _buildStatColumn(
                            label: 'تاريخ الانتهاء',
                            value: expiryDate,
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white70,
                              size: 14,
                            ),
                          ),
                          // Download speed (التحميل)
                          _buildStatColumn(
                            label: 'التحميل',
                            value: downloadSpeed,
                            icon: const Icon(
                              Icons.arrow_downward_rounded,
                              color: Color(0xFFF97316),
                              size: 14,
                            ),
                          ),
                          // Upload speed (الرفع)
                          _buildStatColumn(
                            label: 'الرفع',
                            value: uploadSpeed,
                            icon: const Icon(
                              Icons.arrow_upward_rounded,
                              color: Color(0xFFF97316),
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // ================= BOTTOM HALF: WHITE ACTIONS (NO CIRCLES + VERTICAL DIVIDERS) =================
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 1. Top Up Action (اشحن)
                _buildActionButton(
                  icon: Icons.add_rounded,
                  iconColor: const Color(0xFFF97316), // Brand Orange
                  label: 'اشحن',
                  onTap: onTopUpPressed,
                ),
                _buildVerticalDivider(),
                
                // 2. Buy Packages (شراء باقات)
                _buildActionButton(
                  icon: Icons.shopping_bag_outlined,
                  iconColor: const Color(0xFF3B82F6), // Blue
                  label: 'شراء باقات',
                  onTap: () => onActionPressed(0),
                ),
                _buildVerticalDivider(),
                
                // 3. Send Gift (إرسال هدية)
                _buildActionButton(
                  icon: Icons.card_giftcard_rounded,
                  iconColor: const Color(0xFFEC4899), // Pink/Rose
                  label: 'إرسال هدية',
                  onTap: () => onActionPressed(1),
                ),
                _buildVerticalDivider(),
                
                // 4. Speed Test (اختبار السرعة)
                _buildActionButton(
                  icon: Icons.speed_rounded,
                  iconColor: const Color(0xFF10B981), // Green
                  label: 'اختبار السرعة',
                  onTap: () => onActionPressed(2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 32,
      color: const Color(0xFFE5E7EB), // Clean vertical separator lines
    );
  }

  Widget _buildStatColumn({
    required String label,
    required String value,
    Widget? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withAlpha(153),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: 4),
            ],
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24, // Clean naked icon (no circle)
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF4B5563), // Dark grey text for readability on white
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
