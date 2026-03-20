import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class BottomNavBarItem {
  final IconData icon;
  final String label;

  const BottomNavBarItem({
    required this.icon,
    required this.label,
  });
}

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavBarItem> items;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    // Get bottom padding to safely extend behind the system navigation bar (e.g., iOS home indicator)
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: bottomPadding > 0 ? bottomPadding + AppSpacing.xs : AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E2C), // True Dark Navy background mimicking the mock
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Space evenly across the full width
        children: List.generate(items.length, (index) {
          final isSelected = index == currentIndex;
          final item = items[index];

          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              padding: isSelected
                  ? const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.sm)
                  : const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4A1A1A) : Colors.transparent, // Dark red background when selected
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    color: isSelected ? AppColors.primary : const Color(0xFF6A5A6A),
                    size: 24,
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      item.label,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
