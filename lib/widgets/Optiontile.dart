import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final VoidCallback? onTap;
  final String? errorText;

  const OptionTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.onTap,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: errorText != null ? Colors.red : Colors.grey.shade300,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: leadingIcon != null 
                ? Icon(leadingIcon, color: Colors.grey.shade700) 
                : null,
            title: Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            subtitle: subtitle != null ? Text(subtitle!) : null,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: onTap,
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text(
              errorText!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
