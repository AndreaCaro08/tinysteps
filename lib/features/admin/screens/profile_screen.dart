import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tinysteps/core/constants/app_theme.dart';
import 'package:tinysteps/core/widgets/logout_dialog.dart';

/// Admin Profile Screen — shows current admin's info and account options.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    final name = user?.userMetadata?['full_name'] as String? ?? 'Admin';
    final email = user?.email ?? 'No Email';
    final phone = user?.userMetadata?['phone'] as String? ?? '';

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles.heading2),
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),

            // 🔵 PROFILE AVATAR
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: const Icon(Icons.person, size: 50, color: AppColors.primary),
            ),

            const SizedBox(height: AppSpacing.md),

            // 👤 NAME
            Text(
              name,
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 4),

            // 📧 EMAIL
            Text(
              email,
              style: AppTextStyles.bodyMuted,
            ),

            if (phone.isNotEmpty) ...[
              const SizedBox(height: 4),
              // 📱 PHONE
              Text(
                phone,
                style: AppTextStyles.bodyMuted,
              ),
            ],

            const SizedBox(height: AppSpacing.xl),

            // 🔹 OPTIONS LIST
            _buildOptionTile(
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: () {},
            ),

            _buildOptionTile(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {},
            ),

            _buildOptionTile(
              icon: Icons.lock,
              title: 'Change Password',
              onTap: () {},
            ),

            _buildOptionTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {},
            ),

            const SizedBox(height: AppSpacing.lg),

            // 🔴 LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final confirmed = await showLogoutDialog(context);
                  if (confirmed) {
                    await Supabase.instance.client.auth.signOut();
                  }
                },
                icon: const Icon(Icons.logout, color: AppColors.danger),
                label: Text(
                  'Sign Out',
                  style: AppTextStyles.buttonLabel.copyWith(color: AppColors.danger),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.danger, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.buttonRadius),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  // 🔹 COMMON TILE WIDGET
  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      color: AppColors.bgSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: AppTextStyles.labelBold),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: AppColors.textMuted),
        onTap: onTap,
      ),
    );
  }
}
