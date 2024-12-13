// lib/widgets/card_types/big_display_card.dart
import 'package:flutter/material.dart';
import '../../models/card_models.dart';
import '../../utils/color_utils.dart';

class BigDisplayCard extends StatefulWidget {
  final ContextualCard card;
  final VoidCallback onDismiss;
  final VoidCallback onRemindLater;

  const BigDisplayCard({
    Key? key,
    required this.card,
    required this.onDismiss,
    required this.onRemindLater,
  }) : super(key: key);

  @override
  State<BigDisplayCard> createState() => _BigDisplayCardState();
}

class _BigDisplayCardState extends State<BigDisplayCard> {
  bool _isSlided = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => setState(() => _isSlided = true),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.translationValues(
              _isSlided ? -80.0 : 0.0,
              0.0,
              0.0,
            ),
            child: _buildMainCard(),
          ),
          if (_isSlided) _buildActions(),
        ],
      ),
    );
  }

  Widget _buildMainCard() {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      decoration: _buildCardDecoration(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.card.title != null)
            Text(
              widget.card.title!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          if (widget.card.description != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                widget.card.description!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          if (widget.card.cta != null && widget.card.cta!.isNotEmpty)
            _buildCTAButtons(),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    if (widget.card.bgGradient != null) {
      return BoxDecoration(
        gradient: LinearGradient(
          colors: ColorUtils.gradientColors(widget.card.bgGradient!.colors),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      );
    }
    
    return BoxDecoration(
      color: ColorUtils.hexToColor(widget.card.bgColor),
      borderRadius: BorderRadius.circular(12),
    );
  }

  Widget _buildCTAButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: widget.card.cta!.map((cta) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: () {
                // Implement URL launching
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorUtils.hexToColor(cta.bgColor),
                foregroundColor: ColorUtils.hexToColor(cta.textColor),
              ),
              child: Text(cta.text),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActions() {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ActionButton(
            icon: Icons.access_time,
            onTap: widget.onRemindLater,
          ),
          _ActionButton(
            icon: Icons.close,
            onTap: widget.onDismiss,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }
}