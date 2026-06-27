import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class QuotaCard extends StatelessWidget {
  final double usedGB;
  final double totalGB;
  final VoidCallback onTap;

  const QuotaCard({
    super.key,
    required this.usedGB,
    required this.totalGB,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (usedGB / totalGB).clamp(0.0, 1.0);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top section: Icon, Quota values, Arrow
                Row(
                  children: [
                    // Globe Icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withAlpha(15),
                        border: Border.all(
                          color: Colors.grey.withAlpha(31),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.language_rounded,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 15),
                    
                    // Quota usage and labels
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
                                  color: Color(0xFF1F2937),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Text(
                                ' / ${totalGB.toInt()} جيجابايت',
                                style: const TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'سعة الإنترنت',
                            style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Arrow Icon (Mirrored for RTL)
                    Icon(
                      isRtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
                      color: const Color(0xFF9CA3AF),
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                
                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: LinearProgressIndicator(
                    value: percentage,
                    minHeight: 7,
                    backgroundColor: const Color(0xFFE5E7EB), // Light grey background
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary, // Navy brand blue
                    ),
                  ),
                ),
                
                // Thin Divider line to separate Quota usage from Subscription details
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(
                    height: 1,
                    color: const Color(0xFFE5E7EB).withAlpha(150),
                  ),
                ),
                
                // Subscription Info Row (حالة الاشتراك, التحميل, الرفع)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Column 1 (حالة الاشتراك - Right in RTL)
                    _buildInfoColumn(
                      label: 'حالة الاشتراك',
                      value: 'نشط',
                      indicator: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF22C55E), // Vibrant green dot
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    
                    // Column 2 (التحميل - Middle)
                    _buildInfoColumn(
                      label: 'التحميل',
                      value: '90Mb',
                      icon: const Icon(
                        Icons.arrow_downward_rounded,
                        color: AppColors.secondary,
                        size: 16,
                      ),
                    ),
                    
                    // Column 3 (الرفع - Left in RTL)
                    _buildInfoColumn(
                      label: 'الرفع',
                      value: '92Mb',
                      icon: const Icon(
                        Icons.arrow_upward_rounded,
                        color: AppColors.secondary,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn({
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
            color: Color(0xFF6B7280), // Muted grey label
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF0F254E), // Navy dark blue
                fontSize: 16,
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
}
