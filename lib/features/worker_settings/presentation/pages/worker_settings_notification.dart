import 'package:flutter/material.dart';

class WorkerSettingsnotification extends StatelessWidget {
  const WorkerSettingsnotification({super.key});

  @override
  Widget build(BuildContext context) {
    bool conversationTones = false;
    bool reminders = true;

    return StatefulBuilder(
      builder: (context, setState) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              color: Colors.green,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Notification',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Conversation Tones
                ListTile(
                  title: const Text('Conversation tones'),
                  trailing: Switch(
                    value: conversationTones,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        conversationTones = value;
                      });
                    },
                  ),
                ),
                const Divider(),
                // Reminders
                ListTile(
                  title: const Text('Reminders'),
                  trailing: Switch(
                    value: reminders,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        reminders = value;
                      });
                    },
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        );
      },
    );
  }
}
