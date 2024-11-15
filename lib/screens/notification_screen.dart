import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, String>> notifications;

  const NotificationsScreen({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: notifications.isEmpty
          ? const Center(
        child: Text(
          'Nenhuma notificação disponível.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(notification['title']!),
            subtitle: Text(notification['body']!),
          );
        },
      ),
    );
  }
}
