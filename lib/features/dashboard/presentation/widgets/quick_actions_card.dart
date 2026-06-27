import 'package:flutter/material.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionItem(
              context: context,
              icon: Icons.shopping_bag_outlined,
              iconColor: const Color(0xFF3B82F6), // Vibrant Blue
              bgColor: const Color(0xFFEFF6FF),   // Soft Light Blue
              label: 'شراء باقات',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('شراء باقات Clicked')),
                );
              },
            ),
            _buildActionItem(
              context: context,
              icon: Icons.card_giftcard_rounded,
              iconColor: const Color(0xFFF97316), // Vibrant Orange
              bgColor: const Color(0xFFFFF7ED),   // Soft Light Orange
              label: 'إرسال هدية',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('إرسال هدية Clicked')),
                );
              },
            ),
            _buildActionItem(
              context: context,
              icon: Icons.local_activity_outlined,
              iconColor: const Color(0xFF8B5CF6), // Vibrant Purple
              bgColor: const Color(0xFFF5F3FF),   // Soft Light Purple
              label: 'استرداد قسيمة',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('استرداد قسيمة Clicked')),
                );
              },
            ),
            _buildActionItem(
              context: context,
              icon: Icons.speed_rounded,
              iconColor: const Color(0xFF10B981), // Vibrant Green
              bgColor: const Color(0xFFECFDF5),   // Soft Light Green
              label: 'اختبار السرعة',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('اختبار السرعة Clicked')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem({
    required BuildContext context,
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
            // Circular Icon wrapper with custom soft colored theme
            Container(
              width: 50,
              height: 50,
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
                size: 22,
              ),
            ),
            const SizedBox(height: 8),
            // Text Label
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
