import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CreditCard extends StatelessWidget {
  final String amount;
  final VoidCallback onTopUpPressed;

  const CreditCard({
    super.key,
    required this.amount,
    required this.onTopUpPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      height: 92,
      child: Stack(
        children: [
          // ── Background (White card + Orange button painted together for pixel-perfection) ──
          Positioned.fill(
            child: CustomPaint(
              painter: _CreditCardBackgroundPainter(isRtl: isRtl),
            ),
          ),

          // ── Left/Right Side Content (Coins + Text) ───────────────────────────
          Positioned.directional(
            textDirection: Directionality.of(context),
            start: 16,
            top: 0,
            bottom: 14, // aligned above the bottom white shelf (height 14)
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Coins circle wrapper
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF9FAFB),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CustomPaint(
                        painter: _CoinsVectorPainter(isRtl: isRtl),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      amount,
                      style: const TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'الرصيد',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Right/Left Side Interactive Top Up Button Text/Gesture ──────────
          Positioned.directional(
            textDirection: Directionality.of(context),
            end: 4,
            top: 4,
            bottom: 18, // above the bottom shelf (leaves 4px gap)
            width: 160, // fits perfectly inside the painted orange area
            child: GestureDetector(
              onTap: onTopUpPressed,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.only(
                  left: isRtl ? 0 : 16,
                  right: isRtl ? 16 : 0,
                ), // offset for the slant
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'شحن',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Unified Painter for White Card and Orange Button with Dynamic RTL Support ──
class _CreditCardBackgroundPainter extends CustomPainter {
  final bool isRtl;

  _CreditCardBackgroundPainter({required this.isRtl});

  @override
  void paint(Canvas canvas, Size size) {
    final W = size.width;
    final H = size.height;
    const double r = 16.0;      // Outer corner radius
    const double shelfH = 14.0; // Height of the bottom white shelf
    final double shelfY = H - shelfH;

    // Slant coordinates (52% on top edge, 62% on shelf line)
    final double xTop = W * 0.52;
    final double xBot = W * 0.62;

    // Helper functions for precise linear interpolation along the slant line (perfect parallel gaps)
    double getXWhite(double y) {
      return xTop + (y / shelfY) * (xBot - xTop);
    }

    double getXBlue(double y) {
      return getXWhite(y) + 8.0; // Reduced horizontal gap to match UI/UX closer proportions
    }

    // Mirroring helpers
    double mapX(double x) => isRtl ? W - x : x;
    bool mapClockwise(bool clockwise) => isRtl ? !clockwise : clockwise;

    // ── 1. Draw White Card with Smooth Slant Transitions & Semi-Circular End ──
    final whitePath = Path()
      // Top-left (or top-right in RTL)
      ..moveTo(mapX(r), 0)
      // Top edge to top slant corner start
      ..lineTo(mapX(xTop - 8), 0)
      // Smooth curve to slant
      ..quadraticBezierTo(mapX(xTop), 0, mapX(getXWhite(8)), 8)
      // Slant down to bottom slant corner start
      ..lineTo(mapX(getXWhite(shelfY - 8)), shelfY - 8)
      // Smooth curve to bottom shelf
      ..quadraticBezierTo(mapX(xBot), shelfY, mapX(xBot + 8), shelfY)
      // Extend to the right edge minus the semi-circular end radius (7)
      ..lineTo(mapX(W - 7), shelfY)
      // Draw top-right semi-circle curve of the shelf
      ..arcToPoint(Offset(mapX(W), shelfY + 7), radius: const Radius.circular(7), clockwise: mapClockwise(true))
      // Draw bottom-right semi-circle curve of the shelf
      ..arcToPoint(Offset(mapX(W - 7), H), radius: const Radius.circular(7), clockwise: mapClockwise(true))
      // Bottom edge back to left
      ..lineTo(mapX(r), H)
      ..arcToPoint(Offset(mapX(0), H - r), radius: const Radius.circular(r), clockwise: mapClockwise(true))
      // Left edge back to top
      ..lineTo(mapX(0), r)
      ..arcToPoint(Offset(mapX(r), 0), radius: const Radius.circular(r), clockwise: mapClockwise(true))
      ..close();

    // Card shadow
    canvas.drawShadow(whitePath, const Color(0x0C000000), 8, true);
    canvas.drawPath(whitePath, Paint()..color = Colors.white);

    // ── 2. Draw Orange Trapezoid Button Floating inside Cutout ────────────────
    const double gap = 4.0;      // Gap around the button
    const double rBtn = 10.0;    // Proportional corner radius
    final double btnTop = gap;
    final double btnBot = shelfY - gap;
    final double btnRight = W - gap;

    final orangePath = Path()
      // Start at bottom-left curve end (on slant), heading up the slant
      ..moveTo(mapX(getXBlue(btnBot - 8)), btnBot - 8)
      ..lineTo(mapX(getXBlue(btnTop + 8)), btnTop + 8)
      // Top-left rounded corner
      ..quadraticBezierTo(mapX(getXBlue(btnTop)), btnTop, mapX(getXBlue(btnTop) + 10), btnTop)
      // Top edge to top-right corner
      ..lineTo(mapX(btnRight - rBtn), btnTop)
      ..arcToPoint(Offset(mapX(btnRight), btnTop + rBtn), radius: const Radius.circular(rBtn), clockwise: mapClockwise(true))
      // Right edge to bottom-right corner
      ..lineTo(mapX(btnRight), btnBot - rBtn)
      ..arcToPoint(Offset(mapX(btnRight - rBtn), btnBot), radius: const Radius.circular(rBtn), clockwise: mapClockwise(true))
      // Bottom edge back left
      ..lineTo(mapX(getXBlue(btnBot) + 10), btnBot)
      // Bottom-left rounded corner back to slant
      ..quadraticBezierTo(mapX(getXBlue(btnBot)), btnBot, mapX(getXBlue(btnBot - 8)), btnBot - 8)
      ..close();

    // Fill orange color (AppColors.secondary)
    canvas.drawPath(orangePath, Paint()..color = AppColors.secondary);

    // Draw white outline border
    canvas.drawPath(
      orangePath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant _CreditCardBackgroundPainter old) => old.isRtl != isRtl;
}

// ── Custom Painter for Vector Coins Icon ───────────────────────────────────────
class _CoinsVectorPainter extends CustomPainter {
  final bool isRtl;

  _CoinsVectorPainter({required this.isRtl});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final outlinePaint = Paint()
      ..color = const Color(0xFF1F2937)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    double mapX(double x) => isRtl ? w - x : x;

    // Draw back coin
    final backCenter = Offset(mapX(w * 0.62), h * 0.42);
    _drawSingleCoin(canvas, backCenter, outlinePaint, fillPaint);

    // Draw front coin overlapping the back one
    final frontCenter = Offset(mapX(w * 0.38), h * 0.58);
    _drawSingleCoin(canvas, frontCenter, outlinePaint, fillPaint);
  }

  void _drawSingleCoin(Canvas canvas, Offset center, Paint stroke, Paint fill) {
    const double rx = 7.0;
    const double ry = 3.5;
    const double thickness = 3.0;

    final topRect = Rect.fromCenter(center: center, width: rx * 2, height: ry * 2);
    final bottomCenter = center + const Offset(0, thickness);
    final bottomRect = Rect.fromCenter(center: bottomCenter, width: rx * 2, height: ry * 2);

    // 3D Cylinder side path
    final sidePath = Path()
      ..moveTo(center.dx - rx, center.dy)
      ..lineTo(bottomCenter.dx - rx, bottomCenter.dy)
      ..arcTo(bottomRect, 0, 3.14159, false)
      ..lineTo(center.dx + rx, center.dy)
      ..arcTo(topRect, 0, -3.14159, false)
      ..close();

    canvas.drawPath(sidePath, fill);
    canvas.drawPath(sidePath, stroke);

    // Top face
    canvas.drawOval(topRect, fill);
    canvas.drawOval(topRect, stroke);
  }

  @override
  bool shouldRepaint(covariant _CoinsVectorPainter old) => old.isRtl != isRtl;
}
