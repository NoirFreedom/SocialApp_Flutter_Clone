import 'package:flutter/material.dart';

class TopSearchBar extends StatefulWidget {
  const TopSearchBar({super.key});

  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  final TextEditingController _textEditingController = TextEditingController();

  void _onSearchChanged(String value) {
    print(value);
  }

  void _onSearchSubmitted(String value) {
    print("Submitted the $value");
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onChanged: _onSearchChanged,
      onSubmitted: _onSearchSubmitted,
      style: TextStyle(
        color: Colors.grey.shade200,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () {
            _textEditingController.clear();
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ),
        filled: true,
        fillColor: Colors.grey.shade900,
      ),
    );
  }
}
