import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../providers/premium_provider.dart';
import '../models/or_option.dart';
import '../utils/constants.dart';
import 'premium_screen.dart';
import '../models/or_option.dart';
import '../utils/constants.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedIcon = '💪';
  String _selectedColor = '#8B5CF6';
  bool _hasOrOptions = false;

  // OR Options
  final _option1NameController = TextEditingController();
  final _option2NameController = TextEditingController();
  String _option1Icon = '🏋️';
  String _option2Icon = '🏸';
  String _option1Color = '#8B5CF6';
  String _option2Color = '#EF4444';

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _option1NameController.dispose();
    _option2NameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Habit'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.spacingLG),
          children: [
            // Icon Selector
            Center(
              child: GestureDetector(
                onTap: _showIconPicker,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.fromHex(_selectedColor).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _selectedIcon,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppConstants.spacingXL),

            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'e.g., Exercise, Read, Meditate',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),

            const SizedBox(height: AppConstants.spacingMD),

            // Description Field
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Add a description...',
              ),
              maxLines: 2,
            ),

            const SizedBox(height: AppConstants.spacingLG),

            // Color Picker
            Text(
              'Color',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppConstants.spacingSM),
            Wrap(
              spacing: AppConstants.spacingSM,
              runSpacing: AppConstants.spacingSM,
              children: AppColors.habitColors.map((color) {
                final colorHex = AppColors.toHex(color);
                final isSelected = colorHex == _selectedColor;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = colorHex;
                    });
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 3)
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: AppConstants.spacingXL),

            // OR Options Toggle
            SwitchListTile(
              title: const Text('Enable OR Options'),
              subtitle: const Text('Track multiple ways to complete this habit'),
              value: _hasOrOptions,
              onChanged: (value) {
                setState(() {
                  _hasOrOptions = value;
                });
              },
            ),

            // OR Options Fields
            if (_hasOrOptions) ...[
              const SizedBox(height: AppConstants.spacingLG),
              _buildOrOptionField(
                'Option 1',
                _option1NameController,
                _option1Icon,
                _option1Color,
                (icon) => setState(() => _option1Icon = icon),
                (color) => setState(() => _option1Color = color),
              ),
              const SizedBox(height: AppConstants.spacingMD),
              _buildOrOptionField(
                'Option 2',
                _option2NameController,
                _option2Icon,
                _option2Color,
                (icon) => setState(() => _option2Icon = icon),
                (color) => setState(() => _option2Color = color),
              ),
            ],

            const SizedBox(height: AppConstants.spacingXL),

            // Save Button
            ElevatedButton(
              onPressed: _saveHabit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrOptionField(
    String label,
    TextEditingController controller,
    String icon,
    String color,
    Function(String) onIconChanged,
    Function(String) onColorChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppConstants.spacingSM),
        Row(
          children: [
            // Icon
            GestureDetector(
              onTap: () => _showIconPicker(onIconSelected: onIconChanged),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.fromHex(color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 24)),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.spacingMD),

            // Name
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                validator: (value) {
                  if (_hasOrOptions && (value == null || value.isEmpty)) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(width: AppConstants.spacingMD),

            // Color
            GestureDetector(
              onTap: () => _showColorPicker(onColorSelected: onColorChanged),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.fromHex(color),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showIconPicker({Function(String)? onIconSelected}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Icon'),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.count(
            crossAxisCount: 5,
            shrinkWrap: true,
            children: HabitIcons.icons.map((icon) {
              return GestureDetector(
                onTap: () {
                  if (onIconSelected != null) {
                    onIconSelected(icon);
                  } else {
                    setState(() {
                      _selectedIcon = icon;
                    });
                  }
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 32)),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showColorPicker({Function(String)? onColorSelected}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Color'),
        content: Wrap(
          spacing: AppConstants.spacingSM,
          runSpacing: AppConstants.spacingSM,
          children: AppColors.habitColors.map((color) {
            return GestureDetector(
              onTap: () {
                final colorHex = AppColors.toHex(color);
                if (onColorSelected != null) {
                  onColorSelected(colorHex);
                } else {
                  setState(() {
                    _selectedColor = colorHex;
                  });
                }
                Navigator.pop(context);
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _saveHabit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final habitProvider = context.read<HabitProvider>();
    final premiumProvider = context.read<PremiumProvider>();

    // Check if user can create more habits
    if (!premiumProvider.canCreateMoreHabits(habitProvider.habits.length)) {
      if (mounted) {
        // Show premium screen
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PremiumScreen(),
          ),
        );

        // If user didn't unlock premium, return
        if (!premiumProvider.isPremium) {
          return;
        }
      }
    }

    OrOptions? orOptions;
    if (_hasOrOptions) {
      orOptions = OrOptions(
        option1: OrOption(
          name: _option1NameController.text,
          color: _option1Color,
          icon: _option1Icon,
        ),
        option2: OrOption(
          name: _option2NameController.text,
          color: _option2Color,
          icon: _option2Icon,
        ),
      );
    }

    await habitProvider.createHabit(
      name: _nameController.text,
      description: _descriptionController.text,
      icon: _selectedIcon,
      color: _selectedColor,
      hasOrOptions: _hasOrOptions,
      orOptions: orOptions,
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
