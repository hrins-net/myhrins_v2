import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class UnifiedDashboardCard extends StatelessWidget {
  final double usedGB;
  final double totalGB;
  final VoidCallback onTopUpPressed;
  final VoidCallback onQuotaPressed;
  final Function(int) onActionPressed;

  const UnifiedDashboardCard({
    super.key,
    required this.usedGB,
    required this.totalGB,
    required this.onTopUpPressed,
    required this.onQuotaPressed,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (usedGB / totalGB).clamp(0.0, 1.0);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E325C), // Lighter Navy
            AppColors.primary,  // Primary Navy Dark Blue (0xFF0F254E)
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(24), // Premium rounded corners
        border: Border.all(
          color: Colors.white.withAlpha(20), // Soft white border for a card effect
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(64), // Elegant shadow matching the card color
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18), // Breathable padding
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ================= SECTION 1: SUBSCRIPTION QUOTA (RTL Corrected) =================
            InkWell(
              onTap: onQuotaPressed,
              borderRadius: BorderRadius.circular(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Quota Header
                  Row(
                    children: [
                      // 1. Globe Icon (Renders on the right in RTL as the starting icon)
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
                          Icons.language_rounded,
                          color: Colors.white, // White icon on dark background
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // 2. Quota details (Renders in the middle, RTL aligned)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '${usedGB.toStringAsFixed(1)} جيجابايت',
                                  style: const TextStyle(
                                    color: Colors.white, // White text on dark card
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                Text(
                                  ' / ${totalGB.toInt()} جيجابايت',
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(153),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'سعة الإنترنت',
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
                      
                      // 3. Arrow (Renders on the left in RTL as the trailing indicator)
                      Icon(
                        isRtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
                        color: Colors.white70,
                        size: 22,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
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
                            width: maxWidth * percentage,
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
                  
                  const SizedBox(height: 16),
                  
                  // Stats details (الرفع, التحميل, حالة الاشتراك)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Upload speed
                      _buildStatColumn(
                        label: 'الرفع',
                        value: '92Mb',
                        icon: const Icon(
                          Icons.arrow_upward_rounded,
                          color: Color(0xFFF97316),
                          size: 15,
                        ),
                      ),
                      // Download speed
                      _buildStatColumn(
                        label: 'التحميل',
                        value: '90Mb',
                        icon: const Icon(
                          Icons.arrow_downward_rounded,
                          color: Color(0xFFF97316),
                          size: 15,
                        ),
                      ),
                      // Subscription Status
                      _buildStatColumn(
                        label: 'حالة الاشتراك',
                        value: 'نشط',
                        indicator: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Color(0xFF22C55E),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            _buildSectionDivider(),
            
            // ================= SECTION 2: QUICK ACTION BUTTONS =================
            // Ordered from right to left in RTL: اشحن, شراء باقات, إرسال هدية, اختبار السرعة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 1. Top Up Action (اشحن) - First button on the right in RTL
                _buildActionButton(
                  icon: Icons.add_rounded,
                  iconColor: const Color(0xFFF97316), // Brand Orange
                  label: 'اشحن',
                  onTap: onTopUpPressed,
                ),
                // 2. Buy Packages (شراء باقات)
                _buildActionButton(
                  icon: Icons.shopping_bag_outlined,
                  iconColor: const Color(0xFF3B82F6), // Blue
                  label: 'شراء باقات',
                  onTap: () => onActionPressed(0),
                ),
                // 3. Send Gift (إرسال هدية)
                _buildActionButton(
                  icon: Icons.card_giftcard_rounded,
                  iconColor: const Color(0xFFEC4899), // Pink/Rose
                  label: 'إرسال هدية',
                  onTap: () => onActionPressed(1),
                ),
                // 4. Speed Test (اختبار السرعة) - Last button on the left in RTL
                _buildActionButton(
                  icon: Icons.speed_rounded,
                  iconColor: const Color(0xFF10B981), // Green
                  label: 'اختبار السرعة',
                  onTap: () => onActionPressed(2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Divider(
        height: 1,
        color: Colors.white.withAlpha(30),
      ),
    );
  }

  Widget _buildStatColumn({
    required String label,
    required String value,
    Widget? icon,
    Widget? indicator,
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
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (icon != null || indicator != null) ...[
              const SizedBox(width: 4),
              icon ?? indicator!,
            ],
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
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Solid white buttons floating on the navy card
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(38),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withAlpha(230),
                fontSize: 11,
                fontWeight: FontWeight.w700, // Slightly bolder for better readability on navy
              ),
            ),
          ],
        ),
      ),
    );
  }
}
