import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class UnifiedDashboardCard extends StatelessWidget {
  final double usedGB;
  final double totalGB;
  final String amount;
  final VoidCallback onTopUpPressed;
  final VoidCallback onQuotaPressed;
  final Function(int) onActionPressed;

  const UnifiedDashboardCard({
    super.key,
    required this.usedGB,
    required this.totalGB,
    required this.amount,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ================= SECTION 1: BALANCE & WALLET =================
            Row(
              children: [
                // Top-Up button (Left side in RTL)
                GestureDetector(
                  onTap: onTopUpPressed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.secondary, // Brand Orange (0xFFF48231)
                          Color(0xFFFF9800),    // Vibrant Amber/Orange
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withAlpha(51),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'شحن',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // Balance Text and label (Middle in RTL)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amount,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Text(
                      'الرصيد',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                
                // Wallet Icon container (Right side in RTL)
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF9FAFB),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1.2,
                    ),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ],
            ),
            
            _buildSectionDivider(),
            
            // ================= SECTION 2: SUBSCRIPTION QUOTA =================
            InkWell(
              onTap: onQuotaPressed,
              borderRadius: BorderRadius.circular(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Quota Header
                  Row(
                    children: [
                      // Arrow (Left side in RTL)
                      Icon(
                        isRtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
                        color: const Color(0xFF9CA3AF),
                        size: 22,
                      ),
                      
                      const Spacer(),
                      
                      // Quota details (Middle in RTL)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '/ ${totalGB.toInt()} جيجابايت',
                                style: const TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                ' ${usedGB.toStringAsFixed(1)} جيجابايت',
                                style: const TextStyle(
                                  color: Color(0xFF1F2937),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'سعة الإنترنت',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      
                      // Globe Icon (Right side in RTL)
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFF9FAFB),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                            width: 1.2,
                          ),
                        ),
                        child: const Icon(
                          Icons.language_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: LinearProgressIndicator(
                      value: percentage,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFE5E7EB),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
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
                          color: AppColors.secondary,
                          size: 15,
                        ),
                      ),
                      // Download speed
                      _buildStatColumn(
                        label: 'التحميل',
                        value: '90Mb',
                        icon: const Icon(
                          Icons.arrow_downward_rounded,
                          color: AppColors.secondary,
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
            
            // ================= SECTION 3: QUICK ACTION BUTTONS =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.shopping_bag_outlined,
                  iconColor: const Color(0xFF3B82F6),
                  bgColor: const Color(0xFFEFF6FF),
                  label: 'شراء باقات',
                  onTap: () => onActionPressed(0),
                ),
                _buildActionButton(
                  icon: Icons.card_giftcard_rounded,
                  iconColor: const Color(0xFFF97316),
                  bgColor: const Color(0xFFFFF7ED),
                  label: 'إرسال هدية',
                  onTap: () => onActionPressed(1),
                ),
                _buildActionButton(
                  icon: Icons.local_activity_outlined,
                  iconColor: const Color(0xFF8B5CF6),
                  bgColor: const Color(0xFFF5F3FF),
                  label: 'استرداد قسيمة',
                  onTap: () => onActionPressed(2),
                ),
                _buildActionButton(
                  icon: Icons.speed_rounded,
                  iconColor: const Color(0xFF10B981),
                  bgColor: const Color(0xFFECFDF5),
                  label: 'اختبار السرعة',
                  onTap: () => onActionPressed(3),
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(
        height: 1,
        color: const Color(0xFFE5E7EB).withAlpha(150),
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
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
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
                color: AppColors.primary,
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
    required Color bgColor,
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
                color: bgColor,
                border: Border.all(
                  color: iconColor.withAlpha(38),
                  width: 1.5,
                ),
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
              style: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
