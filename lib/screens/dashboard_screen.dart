// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('СМС Роутер', style: AppTextStyles.headline1),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ],
        elevation: 0,
        backgroundColor: AppColors.surface,
      ),
      body: Column(
        children: [
          // Статистика
          _buildStatsCard(),
          const SizedBox(height: 16),
          // Активные правила
          _buildActiveRulesSection(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToRuleBuilder(context),
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(value: '12', label: 'Активных\nправил', icon: Icons.rule),
          _StatItem(value: '47', label: 'Обработано\nсегодня', icon: Icons.mark_email_read),
          _StatItem(value: '3', label: 'Сработало\nсейчас', icon: Icons.flash_on),
        ],
      ),
    );
  }

  Widget _buildActiveRulesSection() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text('Активные правила', style: AppTextStyles.headline2),
                  const Spacer(),
                  Chip(
                    label: const Text('5', style: TextStyle(color: Colors.white)),
                    backgroundColor: AppColors.primary,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => _RuleListItem(
                  icon: Icons.security,
                  title: 'Банковские коды',
                  subtitle: 'Пересылает коды в Telegram',
                  isActive: index % 2 == 0,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRuleBuilder(BuildContext context) {
    // Навигация к конструктору правил
    Navigator.pushNamed(context, '/rule-builder');
  }
}

// Компонент для элемента статистики
class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((255 * 0.2).round()),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        )),
        Text(label, style: TextStyle(
          color: Colors.white.withAlpha((255 * 0.8).round()),
          fontSize: 10,
        ), textAlign: TextAlign.center),
      ],
    );
  }
}

// Компонент для элемента правила
class _RuleListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isActive;
  final VoidCallback onTap;

  const _RuleListItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha((255 * 0.1).round()),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: AppTextStyles.caption),
        trailing: Switch(
          value: isActive,
          onChanged: (value) => onTap(),
          activeColor: AppColors.primary,
        ),
        onTap: onTap,
      ),
    );
  }
}