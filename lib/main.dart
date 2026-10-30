
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoApp());
}

class AppColors {
  static const navy = Color(0xFF142B49);
  static const blue = Color(0xFF315D96);
  static const background = Color(0xFFF4F7FB);
  static const gold = Color(0xFFD2A65C);
  static const muted = Color(0xFF75849A);
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.navy,
        ),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() =>
      _StudentProfileScreenState();
}

class _StudentProfileScreenState
    extends State<StudentProfileScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedRole = 'Student';

  final List<String> _roles = const [
    'Student',
    'Developer',
    'Designer',
  ];

  String get _formattedDate {
    final d = _selectedDate;
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year}';
  }

  Future<void> _selectMaterialDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _showCupertinoDatePicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) {
        return Container(
          height: 310,
          color: CupertinoColors.systemBackground
              .resolveFrom(popupContext),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    onPressed: () =>
                        Navigator.pop(popupContext),
                    child: const Text('Done'),
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: _selectedDate,
                    minimumDate: DateTime(1950),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (date) {
                      setState(() => _selectedDate = date);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCupertinoRolePicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) {
        return Container(
          height: 270,
          color: CupertinoColors.systemBackground
              .resolveFrom(popupContext),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    onPressed: () =>
                        Navigator.pop(popupContext),
                    child: const Text('Done'),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 42,
                    scrollController:
                    FixedExtentScrollController(
                      initialItem:
                      _roles.indexOf(_selectedRole),
                    ),
                    onSelectedItemChanged: (index) {
                      setState(
                            () => _selectedRole = _roles[index],
                      );
                    },
                    children: _roles
                        .map(
                          (role) => Center(
                        child: Text(role),
                      ),
                    )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _card({required Widget child}) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 1,
      shadowColor: AppColors.navy.withValues(alpha: 0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: child,
    );
  }

  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 54,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
              AssetImage('assets/profile.jpg'),
            ),
          ),
          SizedBox(height: 18),
          Text(
            'Nathaniel Liew Tchin Hui',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'BCS24020052  |  Computer Science',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFCBD7E8),
              fontSize: 12,
            ),
          ),
          Divider(
            height: 36,
            color: Color(0xFF49617D),
          ),
          Text(
            'PERSONAL LIFE GOAL',
            style: TextStyle(
              color: Color(0xFFB7C7DC),
              fontSize: 11,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '"MONEY"',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHometownCard() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: AppColors.blue,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'MY HOMETOWN',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: AppColors.muted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            const TitleSection(
              name: 'Kuching',
              location: 'Sarawak, Malaysia',
              starCount: 41,
            ),

            const SizedBox(height: 12),

            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                'assets/kuching.jpg',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              'The City of Cats',
              style: TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'My hometown is Kuching, Sarawak. '
                  'It is known for the Sarawak River, '
                  'Darul Hana Bridge and its rich culture.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.muted,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(
      IconData icon,
      String label,
      String value,
      ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.blue, size: 20),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickersCard() {
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.tune_rounded,
                  color: AppColors.blue,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Interactive Pickers',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'LAB 02  /  MATERIAL & CUPERTINO',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                _buildInfoTile(
                  Icons.calendar_today_rounded,
                  'Selected Date',
                  _formattedDate,
                ),
                const SizedBox(width: 10),
                _buildInfoTile(
                  Icons.person_outline_rounded,
                  'Selected Role',
                  _selectedRole,
                ),
              ],
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.navy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(14),
                ),
                onPressed: _selectMaterialDate,
                icon: const Icon(Icons.event),
                label: const Text('Material Date Picker'),
              ),
            ),
            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showCupertinoDatePicker,
                icon: const Icon(Icons.date_range),
                label: const Text('Cupertino Date Picker'),
              ),
            ),

            const SizedBox(height: 18),
            const Divider(),
            const SizedBox(height: 12),

            const Text(
              'Material Dropdown',
              style: TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.bold,
              ),
            ),

            DropdownButtonFormField<String>(
              key: ValueKey(_selectedRole),
              initialValue: _selectedRole,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: _roles.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (role) {
                if (role != null) {
                  setState(() => _selectedRole = role);
                }
              },
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showCupertinoRolePicker,
                icon: const Icon(Icons.view_list_rounded),
                label: const Text('Cupertino Wheel Picker'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildProfileCard(),
        const SizedBox(height: 16),
        _buildHometownCard(),
        const SizedBox(height: 16),
        _buildPickersCard(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLandscapeView() {
    return Row(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              _buildProfileCard(),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              _buildHometownCard(),
              const SizedBox(height: 12),
              _buildPickersCard(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CSS3344  |  STUDENT PROFILE',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.navy,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }
}

// Exercise 2.1: Reusable TitleSection
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: AppColors.navy,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                location,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF5E4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: AppColors.gold,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                '$starCount',
                style: const TextStyle(
                  color: AppColors.navy,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
