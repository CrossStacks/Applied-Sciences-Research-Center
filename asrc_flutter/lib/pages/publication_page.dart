import 'package:asrc_flutter/components/newsletter_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../components/grid_builder.dart';
import '../utils/colors.dart';

class PublicationPage extends StatefulWidget {
  const PublicationPage({super.key});

  @override
  State<PublicationPage> createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _searchFocusNode.removeListener(_focusListener);
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _focusListener() {
    if (!_searchFocusNode.hasFocus && _searchController.text.trim().isEmpty) {
      setState(() {
        _isSearchExpanded = false;
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _toggleSearchExpansion() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
    });
    if (_isSearchExpanded) {
      _searchFocusNode.requestFocus();
    } else {
      _searchController.clear();
    }
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: _toggleSearchExpansion,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _isSearchExpanded ? 250.0 : 60.0,
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: _isSearchExpanded ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.black),
            const SizedBox(width: 8),
            if (_isSearchExpanded)
              Expanded(
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                  ),
                  onChanged: (query) {
                    //TODO: Add search filtering logic here
                  },
                  onSubmitted: (query) {
                    if (query.trim().isNotEmpty) {
                      if (kDebugMode) {
                        print('Searching for: $query');
                      }
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscribeButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF06A6A), Color(0xFFFC895F)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: _scrollToBottom,
          child: const Text(
            'Subscribe',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 246, 243),
      body: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Publications',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                _buildSubscribeButton(),
                _buildSearchBar(),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(64.0),
              child: GridB(),
            ),
            Padding(
              padding: const EdgeInsets.all(120.0),
              child: const NewsletterWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
