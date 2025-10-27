import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const AppSearchBar({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _controller.addListener(() {
      widget.onChanged(_controller.text);
      setState(() {}); // aggiornamento per mostrare/nascondere il clear button
    });
  }

  @override
  void didUpdateWidget(covariant AppSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) => widget.onChanged(value),
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  widget.onChanged('');
                },
              )
            : null,
        filled: true,
        // Colore richiesto: #C8B897 con opacità 80% -> alpha 0xCC
        fillColor: const Color(0xCCC8B897),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          // Lati molto più arrotondati
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
