import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../models/habit.dart';
import '../models/or_option.dart';
import '../utils/constants.dart';

class EditHabitScreen extends StatefulWidget {
  final Habit habit;

  const EditHabitScreen({super.key, required this.habit});

  @override
  State<EditHabitScreen> createState() => _EditHabitScreenState();
}

class _EditHabitScreenState extends State<EditHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  late String _selectedIcon;
  late String _selectedColor;
  late bool _hasOrOptions;

  // OR Options
  late TextEditingController _option1NameController;
  late TextEditingController _option2NameController;
  late String _option1Icon;
  late String _option2Icon;
  late String _option1Color;
  late String _option2Color;

  @override
  void initState() {
    super.initState();

    // Initialize with existing habit data
    _nameController = TextEditingController(text: widget.habit.name);
    _descriptionController = TextEditingController(text: widget.habit.description);
    _selectedIcon = widget.habit.icon;
    _selectedColor = AppColors.toHex(Color(widget.habit.color));
    _hasOrOptions = widget.habit.hasOrOptions;

    // Initialize OR Options
    if (widget.habit.orOptions != null) {
      _option1NameController = TextEditingController(text: widget.habit.orOptions!.option1.name);
      _option2NameController = TextEditingController(text: widget.habit.orOptions!.option2.name);
      _option1Icon = widget.habit.orOptions!.option1.icon;
      _option2Icon = widget.habit.orOptions!.option2.icon;
      _option1Color = widget.habit.orOptions!.option1.color;
      _option2Color = widget.habit.orOptions!.option2.color;
    } else {
      _option1NameController = TextEditingController();
      _option2NameController = TextEditingController();
      _option1Icon = '🏋️';
      _option2Icon = '🏸';
      _option1Color = '#8B5CF6';
      _option2Color = '#EF4444';
    }
  }

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
        title: const Text('Edit Habit'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _deleteHabit,
          ),
        ],
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
              child: const Text('Save Changes'),
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

    await habitProvider.updateHabit(
      widget.habit.id,
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

  Future<void> _deleteHabit() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: const Text('Are you sure you want to delete this habit? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await context.read<HabitProvider>().deleteHabit(widget.habit.id);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
