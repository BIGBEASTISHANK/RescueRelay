import 'package:flutter/material.dart';

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}

class AppColors {
  static const Color primary = Color(0XFF0088CC);
  static const Color accent = Colors.lightBlueAccent;
  static const Color cardBackground = Color(0XFF0A0C0E);
  static const Color background = Color(0XFF1A1E23);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
}

// Enhanced Sidebar with better organization and functionality
class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final bool _isAuthenticated = false; // This would come from your auth provider
  final String _userName = "Guest User"; // This would come from user data
  final String _userEmail = "guest@rescuerelay.com";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
    _loadUserData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    // TODO: Load user data from your auth provider
    // final user = await AuthService.getCurrentUser();
    // setState(() {
    //   _isAuthenticated = user != null;
    //   _userName = user?.name ?? "Guest User";
    //   _userEmail = user?.email ?? "guest@rescuerelay.com";
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cardBackground,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            _buildDrawerHeader(),
            _buildDivider(),
            Expanded(
              child: _buildMenuItems(),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            Color(0xFF0066AA),
          ],
        ),
        image: DecorationImage(
          image: AssetImage("assets/img/blurDisaster.jpg"),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              _buildAppTitle(),
              const SizedBox(height: AppSpacing.sm),
              _buildUserInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppTitle() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          child: const Icon(
            Icons.emergency,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        const Text(
          "Rescue Relay",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 3,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Icon(
              _isAuthenticated ? Icons.person : Icons.person_outline,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (_isAuthenticated) ...[
                  const SizedBox(height: 2),
                  Text(
                    _userEmail,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.primary.withOpacity(0.5),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      children: [
        if (_isAuthenticated) ..._buildAuthenticatedMenuItems(),
        if (!_isAuthenticated) ..._buildGuestMenuItems(),
        const SizedBox(height: AppSpacing.md),
        _buildMenuSection("General", _buildGeneralMenuItems()),
        const SizedBox(height: AppSpacing.md),
        _buildMenuSection("Support", _buildSupportMenuItems()),
      ],
    );
  }

  List<Widget> _buildAuthenticatedMenuItems() {
    return [
      _buildMenuSection("Account", [
        SideBarMenuItem(
          icon: Icons.person_outline,
          title: "Profile",
          subtitle: "Manage your account",
          onTap: () => _navigateToScreen('/profile'),
        ),
        SideBarMenuItem(
          icon: Icons.dashboard_outlined,
          title: "Dashboard",
          subtitle: "View your activity",
          onTap: () => _navigateToScreen('/dashboard'),
        ),
        SideBarMenuItem(
          icon: Icons.history,
          title: "History",
          subtitle: "Past rescue activities",
          onTap: () => _navigateToScreen('/history'),
        ),
      ]),
    ];
  }

  List<Widget> _buildGuestMenuItems() {
    return [
      _buildMenuSection("Get Started", [
        SideBarMenuItem(
          icon: Icons.login,
          title: "Sign In",
          subtitle: "Access your account",
          onTap: () => _navigateToScreen('/login'),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.primary,
          ),
        ),
        SideBarMenuItem(
          icon: Icons.person_add_outlined,
          title: "Sign Up",
          subtitle: "Create new account",
          onTap: () => _navigateToScreen('/register'),
        ),
      ]),
    ];
  }

  List<Widget> _buildGeneralMenuItems() {
    return [
      SideBarMenuItem(
        icon: Icons.settings_outlined,
        title: "Settings",
        subtitle: "App preferences",
        onTap: () => _navigateToScreen('/settings'),
      ),
      SideBarMenuItem(
        icon: Icons.notifications_outlined,
        title: "Notifications",
        subtitle: "Manage alerts",
        onTap: () => _navigateToScreen('/notifications'),
        trailing: _buildNotificationBadge(),
      ),
      SideBarMenuItem(
        icon: Icons.language_outlined,
        title: "Language",
        subtitle: "English",
        onTap: () => _showLanguageDialog(),
      ),
    ];
  }

  List<Widget> _buildSupportMenuItems() {
    return [
      SideBarMenuItem(
        icon: Icons.help_outline,
        title: "Help & Support",
        subtitle: "Get assistance",
        onTap: () => _navigateToScreen('/help'),
      ),
      SideBarMenuItem(
        icon: Icons.feedback_outlined,
        title: "Feedback",
        subtitle: "Share your thoughts",
        onTap: () => _navigateToScreen('/feedback'),
      ),
      SideBarMenuItem(
        icon: Icons.info_outline,
        title: "About",
        subtitle: "App information",
        onTap: () => _showAboutDialog(),
      ),
      if (_isAuthenticated)
        SideBarMenuItem(
          icon: Icons.logout,
          title: "Sign Out",
          subtitle: "Logout from account",
          onTap: () => _handleSignOut(),
          textColor: Colors.red,
        ),
    ];
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildNotificationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        '3',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emergency,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: AppSpacing.xs),
              const Text(
                "Emergency: 100",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            "Version 1.0.0",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToScreen(String route) {
    Navigator.of(context).pop(); // Close drawer
    // TODO: Implement proper navigation
    debugPrint('Navigating to: $route');
    // Navigator.pushNamed(context, route);
  }

  void _showLanguageDialog() {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Select Language',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                'English',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Text('🇺🇸'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text(
                'Hindi',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Text('🇮🇳'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    Navigator.of(context).pop();
    showAboutDialog(
      context: context,
      applicationName: 'Rescue Relay',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.emergency,
        color: AppColors.primary,
        size: 32,
      ),
      children: [
        const Text(
          'A disaster relief coordination platform connecting volunteers with those in need.',
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  void _handleSignOut() {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Sign Out',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement sign out logic
              debugPrint('User signed out');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Menu Item Component
class SideBarMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? textColor;

  const SideBarMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.trailing,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: (textColor ?? AppColors.primary).withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSpacing.xs),
          ),
          child: Icon(
            icon,
            color: textColor ?? AppColors.textPrimary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? AppColors.textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: TextStyle(
                  color: (textColor ?? AppColors.textSecondary).withOpacity(0.7),
                  fontSize: 12,
                ),
              )
            : null,
        trailing: trailing ??
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 16,
            ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        hoverColor: AppColors.primary.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),
    );
  }
}
