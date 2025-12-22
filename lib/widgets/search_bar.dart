// Dosya Konumu: lib/widgets/search_bar.dart

import 'package:flutter/material.dart';
import 'package:linkcim/l10n/app_localizations.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final String? hintText;
  final String? initialValue;

  const CustomSearchBar({
    Key? key,
    required this.onSearch,
    this.hintText,
    this.initialValue,
  }) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _controller;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _performSearch() {
    setState(() => _isSearching = true);
    widget.onSearch(_controller.text);

    // Kullanici deneyimi icin kisa bir gecikme
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    });
  }

  void _clearSearch() {
    _controller.clear();
    widget.onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final hintText = widget.hintText ?? l10n.searchPlaceholderShort;
    
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          // Kullanici yazmaya devam ediyorsa bekle
          Future.delayed(Duration(milliseconds: 500), () {
            if (_controller.text == value) {
              _performSearch();
            }
          });
        },
        onSubmitted: (_) => _performSearch(),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: _isSearching
              ? Padding(
            padding: EdgeInsets.all(12),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.primary,
              ),
            ),
          )
              : Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear, color: theme.colorScheme.onSurfaceVariant),
            onPressed: _clearSearch,
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
        ),
      ),
    );
  }
}