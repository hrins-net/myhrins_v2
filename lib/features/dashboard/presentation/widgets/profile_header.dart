import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileHeader extends StatelessWidget {
  final String phoneNumber;
  final String activeUntil;
  final String points;
  final String avatarUrl;
  final bool isDarkBackground; // Support dark/light background states

  const ProfileHeader({
    super.key,
    required this.phoneNumber,
    required this.activeUntil,
    required this.points,
    required this.avatarUrl,
    this.isDarkBackground = true, // Defaults to dark theme to preserve backward compatibility
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: phoneNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'تم نسخ رقم الهاتف إلى الحافظة',
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with clean border and subtle shadow
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkBackground ? Colors.white.withAlpha(217) : const Color(0xFFE5E7EB), 
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(isDarkBackground ? 51 : 25),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(avatarUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          
          // User Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Ensure the phone number reads correctly LTR (+1 (646) 555-4099) even in RTL layouts
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        phoneNumber,
                        style: TextStyle(
                          color: isDarkBackground ? Colors.white : const Color(0xFF0F254E),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _copyToClipboard(context),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isDarkBackground ? Colors.white.withAlpha(25) : const Color(0xFFF3F4F6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.copy_rounded,
                          color: isDarkBackground ? Colors.white70 : const Color(0xFF6B7280),
                          size: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                
                // Subscription active status & Premium loyalty points pill
                Row(
                  children: [
                    Text(
                      'نشط حتى $activeUntil',
                      style: TextStyle(
                        color: isDarkBackground ? Colors.white.withAlpha(204) : const Color(0xFF6B7280),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDarkBackground ? Colors.white.withAlpha(102) : const Color(0xFFD1D5DB),
                      ),
                    ),
                    const SizedBox(width: 8),
                    
                    // Golden Loyalty Points Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isDarkBackground 
                            ? Colors.amber.withAlpha(46) 
                            : const Color(0xFFFEF3C7), // Golden soft amber background for light theme
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: isDarkBackground 
                              ? Colors.amberAccent.withAlpha(76)
                              : const Color(0xFFFCD34D),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.stars_rounded,
                            color: isDarkBackground ? Colors.amberAccent : const Color(0xFFD97706),
                            size: 10,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '$points نقطة',
                            style: TextStyle(
                              color: isDarkBackground ? Colors.amberAccent : const Color(0xFFD97706),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Notification Bell
          Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDarkBackground ? Colors.white.withAlpha(25) : const Color(0xFFF3F4F6), 
                    border: Border.all(
                      color: isDarkBackground ? Colors.white.withAlpha(50) : const Color(0xFFE5E7EB),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: isDarkBackground ? Colors.white : const Color(0xFF0F254E),
                      size: 22,
                    ),
                  ),
                ),
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                top: 1,
                end: 1,
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444), // Crimson Red
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDarkBackground ? const Color(0xFF1E325C) : Colors.white, // Border blends correctly
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
