import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/constants/app_colors.dart';

class ExclusiveServices extends StatelessWidget {
  const ExclusiveServices({super.key});

  @override
  Widget build(BuildContext context) {
    // Aligned to RTL direction natively
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          // Header Section: "حصري لك" on the right, "عرض المزيد" on the left
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Section Title "حصري لك" with vertical accent bar (Renders on the right in RTL)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 4,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.secondary, // Brand Orange Accent
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'حصري لك',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              // Show More text button (Renders on the left in RTL, styled as a premium iOS-style pill)
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'جاري الانتقال إلى جميع الخدمات الحصرية...',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF), // Soft blue background
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    'عرض المزيد',
                    style: TextStyle(
                      color: Color(0xFF3B82F6), // Vibrant blue text
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          
          // White Container Card containing the 5 items
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Pure white background to pop on the white page
              borderRadius: BorderRadius.circular(24), // Premium rounded corners matching UnifiedDashboardCard
              border: Border.all(
                color: const Color(0xFFE5E7EB).withAlpha(100), // Subtle light border for definition
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(5), // Softer, more premium shadow
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _buildServiceItem(
                    context,
                    title: 'ترقية سرعة الفايبر',
                    subtitle: 'ضاعف سرعة اتصالك بخصم 30% لفترة محدودة',
                    icon: HugeIcons.strokeRoundedFlash,
                    iconColor: const Color(0xFFF59E0B), // Vibrant Gold
                    bgColor: const Color(0xFFFFFBEB),   // Light Gold
                    onTap: () => _showServiceAlert(context, 'ترقية سرعة الفايبر'),
                  ),
                  _buildDivider(),
                  _buildServiceItem(
                    context,
                    title: 'الرقابة الأبوية الذكية',
                    subtitle: 'حماية أطفالك وإدارة أوقات استخدام الإنترنت بسهولة',
                    icon: HugeIcons.strokeRoundedShield01,
                    iconColor: const Color(0xFF10B981), // Vibrant Green
                    bgColor: const Color(0xFFECFDF5),   // Light Green
                    onTap: () => _showServiceAlert(context, 'الرقابة الأبوية الذكية'),
                  ),
                  _buildDivider(),
                  _buildServiceItem(
                    context,
                    title: 'الدعم الفني VIP',
                    subtitle: 'مساعدة ذات أولوية فورية من الخبراء على مدار الساعة',
                    icon: HugeIcons.strokeRoundedCustomerService,
                    iconColor: const Color(0xFF3B82F6), // Vibrant Blue
                    bgColor: const Color(0xFFEFF6FF),   // Light Blue
                    onTap: () => _showServiceAlert(context, 'الدعم الفني VIP'),
                  ),
                  _buildDivider(),
                  _buildServiceItem(
                    context,
                    title: 'تفعيل قنوات Shahid VIP',
                    subtitle: 'احصل على اشتراك ترفيهي مجاني مع باقتك الحالية',
                    icon: HugeIcons.strokeRoundedTvSmart,
                    iconColor: const Color(0xFF8B5CF6), // Vibrant Purple
                    bgColor: const Color(0xFFF5F3FF),   // Light Purple
                    onTap: () => _showServiceAlert(context, 'تفعيل قنوات Shahid VIP'),
                  ),
                  _buildDivider(),
                  _buildServiceItem(
                    context,
                    title: 'شريحة eSIM إضافية',
                    subtitle: 'تفعيل شريحة بيانات ثانية للأجهزة اللوحية والمحمولة',
                    icon: HugeIcons.strokeRoundedSimcard01,
                    iconColor: const Color(0xFFEC4899), // Vibrant Pink/Rose
                    bgColor: const Color(0xFFFCE7F3),   // Light Pink/Rose
                    onTap: () => _showServiceAlert(context, 'شريحة eSIM إضافية'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<List<dynamic>> icon,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12), // Upgraded to match card layout
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6), // Slightly more spacious
        child: Row(
          children: [
            // Circular Icon Wrapper with custom theme (Renders on the right in RTL)
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor,
                border: Border.all(
                  color: iconColor.withAlpha(38),
                  width: 1.2,
                ),
              ),
              child: Center(
                child: HugeIcon(
                  icon: icon,
                  color: iconColor,
                  size: 18,
                  strokeWidth: 1.6,
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Title & Description (Expanded in the middle, aligned to start for RTL compatibility)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align to start (Right in RTL, Left in LTR)
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            
            // Chevron arrow (Renders on the left in RTL, pointing left)
            Icon(
              isRtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
              color: const Color(0xFF9CA3AF),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 6,
      thickness: 1,
      color: Color(0xFFF3F4F6),
      indent: 4,
      endIndent: 4,
    );
  }

  void _showServiceAlert(BuildContext context, String serviceName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم تفعيل طلب: $serviceName بنجاح',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
