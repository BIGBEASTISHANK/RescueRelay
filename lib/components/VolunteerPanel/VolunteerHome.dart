import 'package:flutter/material.dart';
import 'package:rescuerelay/data/data.dart';

// App Constants for consistent styling
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

class AppTextStyles {
  static const TextStyle sectionTitle = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  
  static const TextStyle cardTitle = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  
  static const TextStyle cardDescription = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
    height: 1.4,
  );
  
  static const TextStyle buttonText = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );
}

// Enhanced Home Page with better state management
class VolunteerHome extends StatefulWidget {
  const VolunteerHome({super.key});

  @override
  State<VolunteerHome> createState() => _VolunteerHomeState();
}

class _VolunteerHomeState extends State<VolunteerHome> {
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDisasterData();
  }

  Future<void> _loadDisasterData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // In real app, you would fetch data from API here
      // await DisasterRepository.fetchDisasters();
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to load disaster data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }

    if (_error != null) {
      return _buildErrorWidget();
    }

    return RefreshIndicator(
      onRefresh: _loadDisasterData,
      color: AppColors.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: _buildDisasterSections(),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 64,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Something went wrong',
              style: AppTextStyles.sectionTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: AppTextStyles.cardDescription,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: _loadDisasterData,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDisasterSections() {
    return disasterDistance.values.map((distance) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: VolunteerHomeLayout(
          currentDisasterDistance: distance,
          key: ValueKey(distance),
        ),
      );
    }).toList();
  }
}

// Enhanced Layout with better organization
class VolunteerHomeLayout extends StatelessWidget {
  final disasterDistance currentDisasterDistance;

  const VolunteerHomeLayout({
    super.key,
    required this.currentDisasterDistance,
  });

  // Enhanced method with better error handling
  Map<String, Map<String, String>> _getDataForDistance() {
    try {
      switch (currentDisasterDistance) {
        case disasterDistance.zeroToFive:
          return DisasterData.zeroToFiveData;
        case disasterDistance.fiveToTen:
          return DisasterData.fiveToTenData;
        case disasterDistance.tenToFifteen:
          return DisasterData.tenToFifteenData;
        case disasterDistance.beyondFifteen:
          return DisasterData.beyondFifteenData;
      }
    } catch (e) {
      debugPrint('Error getting disaster data: $e');
      return {};
    }
  }

  String _getDistanceTitle() {
    switch (currentDisasterDistance) {
      case disasterDistance.zeroToFive:
        return "Near You (0-5Km)";
      case disasterDistance.fiveToTen:
        return "Between 5-10 Km";
      case disasterDistance.tenToFifteen:
        return "Between 10-15 Km";
      case disasterDistance.beyondFifteen:
        return "Beyond 15 Km";
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _getDataForDistance();
    
    if (data.isEmpty) {
      return _buildEmptySection();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(),
        const SizedBox(height: AppSpacing.sm),
        _buildDisasterCards(data),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Icon(
            _getDistanceIcon(),
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            _getDistanceTitle(),
            style: AppTextStyles.sectionTitle,
          ),
        ],
      ),
    );
  }

  IconData _getDistanceIcon() {
    switch (currentDisasterDistance) {
      case disasterDistance.zeroToFive:
        return Icons.location_on;
      case disasterDistance.fiveToTen:
        return Icons.near_me;
      case disasterDistance.tenToFifteen:
        return Icons.explore;
      case disasterDistance.beyondFifteen:
        return Icons.public;
    }
  }

  Widget _buildDisasterCards(Map<String, Map<String, String>> data) {
    return SizedBox(
      height: 210, // Fixed height for horizontal scroll
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final entry = data.entries.elementAt(index);
          return VHLCard(
            disasterTitle: entry.value['title'] ?? 'Unknown Disaster',
            disasterDescription: entry.value['description'] ?? 'No description available',
            disasterId: entry.key,
            onChatPressed: () => _handleChatPress(entry.key),
            onMapsPressed: () => _handleMapsPress(entry.key),
          );
        },
      ),
    );
  }

  Widget _buildEmptySection() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          _buildSectionTitle(),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppSpacing.md),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.textSecondary,
                  size: 32,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'No disasters reported in this area',
                  style: AppTextStyles.cardDescription,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleChatPress(String disasterId) {
    debugPrint('Chat pressed for disaster: $disasterId');
    // TODO: Navigate to chat screen
    // Navigator.pushNamed(context, '/chat', arguments: disasterId);
  }

  void _handleMapsPress(String disasterId) {
    debugPrint('Maps pressed for disaster: $disasterId');
    // TODO: Navigate to maps screen
    // Navigator.pushNamed(context, '/maps', arguments: disasterId);
  }
}

// Enhanced Card with comprehensive improvements
class VHLCard extends StatelessWidget {
  final String disasterTitle;
  final String disasterDescription;
  final String? disasterId;
  final bool isLoading;
  final String? error;
  final VoidCallback? onChatPressed;
  final VoidCallback? onMapsPressed;

  const VHLCard({
    super.key,
    required this.disasterTitle,
    required this.disasterDescription,
    this.disasterId,
    this.isLoading = false,
    this.error,
    this.onChatPressed,
    this.onMapsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth > 600 ? 350.0 : screenWidth * 0.85;

    if (isLoading) {
      return _buildLoadingCard(cardWidth);
    }

    if (error != null) {
      return _buildErrorCard(cardWidth);
    }

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          side: const BorderSide(color: AppColors.primary, width: 2),
        ),
        color: AppColors.cardBackground,
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          onTap: () => _handleCardTap(context),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardHeader(),
                const SizedBox(height: AppSpacing.sm),
                _buildCardContent(),
                const Spacer(),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          child: Icon(
            _getDisasterIcon(),
            color: AppColors.primary,
            size: 16,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            disasterTitle,
            style: AppTextStyles.cardTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCardContent() {
    return Expanded(
      child: Text(
        disasterDescription,
        style: AppTextStyles.cardDescription,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            text: "Chat",
            onPressed: onChatPressed ?? () => _handleChatPress(),
            icon: Icons.chat_bubble_outline,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: ActionButton(
            text: "Maps",
            onPressed: onMapsPressed ?? () => _handleMapsPress(),
            icon: Icons.map_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingCard(double cardWidth) {
    return Container(
      width: cardWidth,
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          side: const BorderSide(color: AppColors.primary, width: 2),
        ),
        color: AppColors.cardBackground,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard(double cardWidth) {
    return Container(
      width: cardWidth,
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          side: const BorderSide(color: Colors.red, width: 2),
        ),
        color: AppColors.cardBackground,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 32,
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Error loading disaster info',
                style: AppTextStyles.cardTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                error!,
                style: AppTextStyles.cardDescription,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getDisasterIcon() {
    final title = disasterTitle.toLowerCase();
    if (title.contains('flood')) return Icons.water;
    if (title.contains('fire')) return Icons.local_fire_department;
    if (title.contains('earthquake')) return Icons.landscape;
    if (title.contains('storm')) return Icons.thunderstorm;
    if (title.contains('landslide')) return Icons.terrain;
    return Icons.warning;
  }

  void _handleCardTap(BuildContext context) {
    // TODO: Navigate to disaster details screen
    debugPrint('Card tapped for disaster: $disasterId');
  }

  void _handleChatPress() {
    debugPrint('Chat pressed for disaster: $disasterId');
  }

  void _handleMapsPress() {
    debugPrint('Maps pressed for disaster: $disasterId');
  }
}

// Reusable Action Button Component
class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.accent,
        foregroundColor: textColor ?? Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        elevation: 2,
      ),
      icon: icon != null
          ? Icon(icon, size: 16)
          : const SizedBox.shrink(),
      label: Text(
        text,
        style: AppTextStyles.buttonText,
      ),
    );
  }
}
