import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../design/app_colors.dart';
import '../../design/app_dimensions.dart';

class AddCourtPage extends StatefulWidget {
  const AddCourtPage({super.key});

  @override
  State<AddCourtPage> createState() => _AddCourtPageState();
}

class _AddCourtPageState extends State<AddCourtPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedSport = 'Football';
  final List<String> _sports = [
    'Football',
    'Cricket',
    'Tennis',
    'Badminton',
    'Basketball',
  ];

  Map<String, bool> _amenities = {
    'Parking': true,
    'Changing Room': true,
    'Floodlights': true,
    'Drinking Water': true,
    'Locker Room': false,
    'First Aid': true,
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Add New Court',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.close, color: isDark ? Colors.white : Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageUpload(isDark),
              const SizedBox(height: AppDimensions.paddingLG),
              _buildSectionTitle('Basic Information', isDark),
              _buildTextField(
                'Court Name',
                'e.g. Downtown Futsal Arena',
                isDark,
              ),
              _buildSportSelector(isDark),
              _buildTextField(
                'Location',
                'e.g. Block 5, Gulshan-e-Iqbal',
                isDark,
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: AppDimensions.paddingLG),
              _buildSectionTitle('Pricing & Availability', isDark),
              _buildTextField(
                'Price per Hour (PKR)',
                'e.g. 2500',
                isDark,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                'Operating Hours',
                'e.g. 08:00 AM - 12:00 AM',
                isDark,
                icon: Icons.schedule_outlined,
              ),
              const SizedBox(height: AppDimensions.paddingLG),
              _buildSectionTitle('Amenities', isDark),
              _buildAmenitiesGrid(isDark),
              const SizedBox(height: 100), // Space for button
            ],
          ),
        ),
      ),
      bottomSheet: _buildStickyFooter(isDark),
    );
  }

  Widget _buildImageUpload(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Photos',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildAddImageButton(isDark),
              const SizedBox(width: 12),
              _buildMockImage(
                isDark,
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAY01BT97KxZ2rszgJrRACrqlqOGfSPOkA_cK0I86j-Nq26E_5zubbCs6OVkZWLxuEZLYaXENPI8DtylEbL_NtZjePfDqpUjHu0hC3N5Ec7As0qmB5g4cex5G7blYMGKWfOEyYInNwMjKC_4Z_8XnXScLQcuesUrtaJr93W0VpECB-vZubPt4zi9T96tU2Yl55jvr4Kq5tuGmQyoQJebzD-S6R5palEpgEH8WOGDzHptiXzU7W95e-yra0POObIQ2VOrPu6qMZrTnU',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddImageButton(bool isDark) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: AppColors.primary, style: BorderStyle.solid),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add_a_photo_outlined, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add Photo',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockImage(bool isDark, String url) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isDark
              ? AppColors.textPrimaryDark
              : AppColors.textPrimaryLight,
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    bool isDark, {
    IconData? icon,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            keyboardType: keyboardType,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              prefixIcon: icon != null
                  ? Icon(icon, color: AppColors.primary, size: 20)
                  : null,
              filled: true,
              fillColor: isDark ? AppColors.surfaceDark : AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                borderSide: BorderSide(
                  color: isDark ? AppColors.borderDark : Colors.grey.shade100,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                borderSide: BorderSide(
                  color: isDark ? AppColors.borderDark : Colors.grey.shade100,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportSelector(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sport Type',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
              border: Border.all(
                color: isDark ? AppColors.borderDark : Colors.grey.shade100,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSport,
                isExpanded: true,
                dropdownColor: isDark ? AppColors.surfaceDark : AppColors.white,
                items: _sports.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedSport = val);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesGrid(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLG),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(
          color: isDark ? AppColors.borderDark : Colors.grey.shade100,
        ),
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: _amenities.keys.map((name) {
          return Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: _amenities[name],
                  onChanged: (val) =>
                      setState(() => _amenities[name] = val ?? false),
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStickyFooter(bool isDark) {
    return Container(
      padding: EdgeInsets.only(
        left: AppDimensions.paddingLG,
        right: AppDimensions.paddingLG,
        top: AppDimensions.paddingMD,
        bottom: MediaQuery.of(context).padding.bottom + AppDimensions.paddingMD,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
          ),
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.4),
        ),
        child: const Text(
          'Save Court',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
