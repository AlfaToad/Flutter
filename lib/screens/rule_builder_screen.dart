// lib/screens/rule_builder_screen.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RuleBuilderScreen extends StatefulWidget {
  const RuleBuilderScreen({super.key});

  @override
  State<RuleBuilderScreen> createState() => _RuleBuilderScreenState();
}

class _RuleBuilderScreenState extends State<RuleBuilderScreen> {
  int _currentStep = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новое правило'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveRule),
        ],
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _nextStep,
        onStepCancel: _previousStep,
        steps: [
          Step(
            title: const Text('Условие'),
            content: _buildConditionStep(),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Действие'),
            content: _buildActionStep(),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Название'),
            content: _buildFinalStep(),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildConditionStep() {
    return Column(
      children: [
        _ConditionTile(
          icon: Icons.person,
          title: 'Отправитель',
          subtitle: 'По номеру или контакту',
          onTap: () => _showSenderDialog(),
        ),
        _ConditionTile(
          icon: Icons.message,
          title: 'Текст сообщения',
          subtitle: 'Ключевые слова и фразы',
          onTap: () => _showKeywordsDialog(),
        ),
        _ConditionTile(
          icon: Icons.access_time,
          title: 'Время и дата',
          subtitle: 'Расписание работы',
          onTap: () => _showScheduleDialog(),
        ),
      ],
    );
  }

  Widget _buildActionStep() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _ActionChip(icon: Icons.notifications, label: 'Уведомление'),
        _ActionChip(icon: Icons.send, label: 'Telegram'),
        _ActionChip(icon: Icons.email, label: 'Email'),
        _ActionChip(icon: Icons.reply, label: 'Автоответ'),
        _ActionChip(icon: Icons.archive, label: 'Архив'),
        _ActionChip(icon: Icons.delete, label: 'Удалить'),
      ],
    );
  }

  Widget _buildFinalStep() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Название правила',
        hintText: 'Например: "Банковские коды"',
        border: OutlineInputBorder(),
      ),
    );
  }

  void _nextStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  void _saveRule() {
    // Сохранение правила
  }

  void _showSenderDialog() {}
  void _showKeywordsDialog() {}
  void _showScheduleDialog() {}
}

class _ConditionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ConditionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: () {},
      backgroundColor: AppColors.primary.withOpacity(0.1),
      labelStyle: TextStyle(color: AppColors.primary),
    );
  }
}