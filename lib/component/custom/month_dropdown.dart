import 'package:flutter/material.dart';

class MonthDropdown extends StatefulWidget {
  final Map<String, String> monthMap;
  final Function(String) onChanged;

  const MonthDropdown({
    super.key,
    required this.monthMap,
    required this.onChanged,
  });

  @override
  State<MonthDropdown> createState() => _MonthDropdownState();
}

class _MonthDropdownState extends State<MonthDropdown> {
  late String selectedKey;

  @override
  void initState() {
    super.initState();
    selectedKey = widget.monthMap.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedKey,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 16),
      isDense: true,
      underline: const SizedBox(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() => selectedKey = newValue);
          widget.onChanged(widget.monthMap[newValue]!);
        }
      },
      items: widget.monthMap.keys.map<DropdownMenuItem<String>>((key) {
        return DropdownMenuItem<String>(
          value: key,
          child: Text(key, style: const TextStyle(fontSize: 12)),
        );
      }).toList(),
      selectedItemBuilder: (context) {
        return widget.monthMap.keys.map<Widget>((key) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_month,size: 12,),
              SizedBox(width: 4),
              const Text('Exibindo em: ', style: TextStyle(fontSize: 12)),
              Text(key, style: const TextStyle(fontSize: 12)),
            ],
          );
        }).toList();
      },
    );
  }
}
