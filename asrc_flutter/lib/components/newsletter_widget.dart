import 'package:flutter/material.dart';
import '../utils/dimensions.dart';

class NewsletterWidget extends StatelessWidget {
  const NewsletterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Dimensions.isMobile(context);
    final double containerWidth = isMobile ? double.infinity : 1240;
    final double? containerHeight = isMobile ? null : 336;
    final EdgeInsets containerPadding = isMobile
        ? const EdgeInsets.all(16)
        : const EdgeInsets.symmetric(horizontal: 60);

    return Center(
      child: Container(
        width: containerWidth,
        height: containerHeight,
        padding: containerPadding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: isMobile
            ? _buildMobileContent(context)
            : _buildDesktopContent(context),
      ),
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Join our newsletter and be the first to hear it!',
          style: const TextStyle(
            fontSize: 21,
            color: Color.fromARGB(255, 50, 53, 62),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Subscribe to get the latest news and benefit from inspiring stories delivered straight to your inbox every month.',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 72, 76, 81),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Your email...',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              filled: true,
              fillColor: const Color.fromARGB(255, 245, 245, 245),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(color: Color(0xFFFDE1D9), width: 4),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              suffixIcon: Container(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // TODO: handle subscribe action
                  },
                  child: const Text(
                    'Subscribe',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              suffixIconConstraints:
                  const BoxConstraints(maxHeight: 50, maxWidth: 140),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Join our newsletter and be the first to hear it!',
            style: const TextStyle(
              fontSize: 27,
              color: Color.fromARGB(255, 50, 53, 62),
            ),
          ),
        ),
        const SizedBox(width: 150),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Subscribe to get the latest news and benefit from inspiring stories delivered straight to your inbox every month.',
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 72, 76, 81),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Your email...',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 245, 245, 245),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFFFDE1D9), width: 4),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    suffixIcon: Container(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // TODO: handle subscribe action
                        },
                        child: const Text(
                          'Subscribe',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 50,
                      maxWidth: 140,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
