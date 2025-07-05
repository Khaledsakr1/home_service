import 'package:flutter/material.dart';

class BeautifulRatingWidget extends StatefulWidget {
  final int initialRating;
  final ValueChanged<int> onRatingChanged;
  final double size;
  final bool enabled;

  const BeautifulRatingWidget({
    Key? key,
    this.initialRating = 5,
    required this.onRatingChanged,
    this.size = 40.0,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<BeautifulRatingWidget> createState() => _BeautifulRatingWidgetState();
}

class _BeautifulRatingWidgetState extends State<BeautifulRatingWidget>
    with TickerProviderStateMixin {
  late int _currentRating;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  int _hoveredStar = -1;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.shade50,
            Colors.orange.shade50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Rate Your Experience',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              final isSelected = index < _currentRating;
              final isHovered = index <= _hoveredStar;
              final shouldHighlight = isSelected || isHovered;
              
              return GestureDetector(
                onTap: widget.enabled
                    ? () {
                        setState(() {
                          _currentRating = index + 1;
                        });
                        widget.onRatingChanged(index + 1);
                        _animationController.forward().then((_) {
                          _animationController.reverse();
                        });
                      }
                    : null,
                child: MouseRegion(
                  onEnter: widget.enabled
                      ? (_) {
                          setState(() {
                            _hoveredStar = index;
                          });
                        }
                      : null,
                  onExit: widget.enabled
                      ? (_) {
                          setState(() {
                            _hoveredStar = -1;
                          });
                        }
                      : null,
                  child: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: shouldHighlight ? _scaleAnimation.value : 1.0,
                        child: Container(
                          width: widget.size,
                          height: widget.size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: shouldHighlight
                                ? LinearGradient(
                                    colors: [
                                      Colors.amber.shade400,
                                      Colors.orange.shade400,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: shouldHighlight ? null : Colors.grey.shade300,
                            boxShadow: shouldHighlight
                                ? [
                                    BoxShadow(
                                      color: Colors.amber.withOpacity(0.6),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Icon(
                            shouldHighlight ? Icons.star : Icons.star_border,
                            size: widget.size * 0.7,
                            color: shouldHighlight ? Colors.white : Colors.grey.shade600,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          Text(
            _getRatingText(_currentRating),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent';
      default:
        return 'Rate this service';
    }
  }
}