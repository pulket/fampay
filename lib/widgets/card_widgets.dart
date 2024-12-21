import 'package:fampay/models/card_group.dart';
import 'package:fampay/models/card_item.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class CardGroupWidget extends StatelessWidget {
  final CardGroup cardGroup;

  const CardGroupWidget({Key? key, required this.cardGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (cardGroup.designType) {
      case 'HC3':
        return BigDisplayCard(cardGroup: cardGroup);
      case 'HC6':
        return SmallCardWithArrow(cardGroup: cardGroup);
      case 'HC5':
        return ImageCard(cardGroup: cardGroup);
      case 'HC9':
        return GradientCardGroup(cardGroup: cardGroup);
      case 'HC1':
        return SmallDisplayCardGroup(cardGroup: cardGroup);
      default:
        return const SizedBox.shrink();
    }
  }
}



class BigDisplayCard extends StatefulWidget {
  final CardGroup cardGroup;

  const BigDisplayCard({Key? key, required this.cardGroup}) : super(key: key);

  @override
  State<BigDisplayCard> createState() => _BigDisplayCardState();
}

class _BigDisplayCardState extends State<BigDisplayCard> with SingleTickerProviderStateMixin {
  bool _isLongPressed = false;
  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 80.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _slideAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleLongPress() {
    setState(() {
      _isLongPressed = true;
      _controller.forward();
    });
  }

  void _handleDismissNow() {
    setState(() {
      _isLongPressed = false;
      _controller.reverse();
    });
  }

  void _handleRemindLater() {
    setState(() {
      _isLongPressed = false;
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.cardGroup.cards.first;
    final formattedTitle = card.formattedTitle;
    final entities = formattedTitle?.entities;
    final bgImage = card.bgImage;
    final cta = card.cta?.firstOrNull;
    
    return Container(
      width: widget.cardGroup.isFullWidth ? MediaQuery.of(context).size.width : null,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          if (_isLongPressed)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 80,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ActionButton(
                      icon: Icons.notifications_outlined,
                      label: 'remind later',
                      onTap: _handleRemindLater,
                    ),
                    _ActionButton(
                      icon: Icons.close,
                      label: 'dismiss now',
                      onTap: _handleDismissNow,
                    ),
                  ],
                ),
              ),
            ),
          Transform.translate(
            offset: Offset(_slideAnimation.value, 0),
            child: GestureDetector(
              onLongPress: _handleLongPress,
              child: AspectRatio(
                aspectRatio: bgImage?.aspectRatio ?? 1,
                child: Container(
                  height: widget.cardGroup.height.toDouble(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: bgImage?.imageUrl != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(bgImage!.imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.26),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: formattedTitle?.align == 'left' 
                          ? CrossAxisAlignment.start 
                          : CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        if (entities != null && entities.isNotEmpty) ...[
                          Text(
                            entities[0].text,
                            style: TextStyle(
                              color: entities[0].color != null 
                                  ? Color(int.parse(entities[0].color!.replaceAll('#', '0xFF')))
                                  : Colors.white,
                              fontSize: entities[0].fontSize?.toDouble(),
                              fontFamily: entities[0].fontFamily,
                              decoration: entities[0].fontStyle == 'underline' 
                                  ? TextDecoration.underline 
                                  : TextDecoration.none,
                            ),
                          ),
                          if (card.title != null) ...[
                            Text(
                              card.title!.split('\n')[1],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: entities[0].fontSize?.toDouble(),
                                fontFamily: entities[0].fontFamily,
                              ),
                            ),
                            SizedBox(height: entities[1].fontSize?.toDouble() ?? 8),
                          ],
                          if (entities.length > 1)
                            Text(
                              entities[1].text,
                              style: TextStyle(
                                color: entities[1].color != null 
                                    ? Color(int.parse(entities[1].color!.replaceAll('#', '0xFF')))
                                    : Colors.white,
                                fontSize: entities[1].fontSize?.toDouble(),
                                fontFamily: entities[1].fontFamily,
                                decoration: entities[1].fontStyle == 'underline' 
                                    ? TextDecoration.underline 
                                    : TextDecoration.none,
                              ),
                            ),
                        ],
                        if (cta != null) ...[
                          const SizedBox(height: 16),
                          SizedBox(
                            width: cta.isCircular ? 120 : null,
                            child: ElevatedButton(
                              onPressed: card.isDisabled ? null : () {
                                if (card.url != null) {
                                  // Launch URL logic
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cta.bgColor != null 
                                    ? Color(int.parse(cta.bgColor!.replaceAll('#', '0xFF')))
                                    : Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(cta.isCircular ? 20 : 8),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: cta.isCircular ? 24 : 16,
                                  vertical: cta.isCircular ? 12 : 8,
                                ),
                              ),
                              child: Text(
                                cta.text,
                                style: TextStyle(
                                  color: cta.isSecondary ? Colors.black : Colors.white,
                                  fontSize: cta.isCircular ? 16 : 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 64, // Fixed width for consistency
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon, 
              color: const Color(0xFFFBAF03), 
              size: 20, // Smaller icon size
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10, // Smaller font size
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmallCardWithArrow extends StatelessWidget {
  final CardGroup cardGroup;

  const SmallCardWithArrow({Key? key, required this.cardGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = cardGroup.cards.first;
    final formattedTitle = card.formattedTitle;
    final entity = formattedTitle?.entities.first;
    final iconData = card.icon as Map<String, dynamic>?;

    return Container(
      height: cardGroup.height.toDouble(),
      // Using isFullWidth from API
      width: cardGroup.isFullWidth ? double.infinity : null,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          if (card.url != null) {
            // Launch URL logic here
          }
        },
        child: Container(
          height: cardGroup.height.toDouble(),
          decoration: BoxDecoration(
            color: Color(int.parse(card.bgColor?.replaceAll('#', '0xFF') ?? '0xFFFBAF03')),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (iconData != null) Container(
                  width: card.iconSize?.toDouble() ?? 24,
                  height: card.iconSize?.toDouble() ?? 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: iconData['image_url'] ?? '',
                      width: card.iconSize?.toDouble(),
                      height: card.iconSize?.toDouble(),
                      // Using aspect ratio from API
                      fit: (iconData['aspect_ratio'] as num?)?.toDouble() == 1.0 
                          ? BoxFit.contain 
                          : BoxFit.cover,
                      placeholder: (context, url) => const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    entity?.text ?? '',
                    textAlign: formattedTitle?.align == 'center' 
                        ? TextAlign.center 
                        : TextAlign.left,
                    style: TextStyle(
                      color: entity?.color != null 
                          ? Color(int.parse(entity!.color!.replaceAll('#', '0xFF')))
                          : Colors.black,
                      fontSize: entity?.fontSize?.toDouble() ?? 12,
                      fontFamily: entity?.fontFamily ?? 'met_semi_bold',
                      decoration: entity?.fontStyle == 'underline'
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (!card.isDisabled) const SizedBox(width: 4),
                if (!card.isDisabled) const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final CardGroup cardGroup;

  const ImageCard({Key? key, required this.cardGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = cardGroup.cards.first;
    final aspectRatio = card.bgImage?.aspectRatio ?? 2.5;
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: GestureDetector(
          onTap: () {
            if (card.url != null) {
              // Launch URL logic here
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: card.bgImage?.imageUrl ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.error_outline),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientCardGroup extends StatelessWidget {
  final CardGroup cardGroup;

  const GradientCardGroup({Key? key, required this.cardGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardGroup.height.toDouble(),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: cardGroup.cards.length,
        itemBuilder: (context, index) {
          final card = cardGroup.cards[index];
          return Container(
            margin: const EdgeInsets.only(right: 16),
            width: cardGroup.height * (card.bgImage?.aspectRatio ?? 1.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: card.bgGradient?.getColorsList() ?? [Colors.transparent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: card.bgImage?.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: card.bgImage!.imageUrl!,
                    fit: BoxFit.cover,
                  )
                : null,
          );
        },
      ),
    );
  }
}
class SmallDisplayCardGroup extends StatelessWidget {
  final CardGroup cardGroup;

  const SmallDisplayCardGroup({Key? key, required this.cardGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardGroup.height.toDouble(),
      width: cardGroup.isFullWidth ? MediaQuery.of(context).size.width : null,
      child: cardGroup.isScrollable 
        ? _buildScrollableList()
        : _buildSingleCard(cardGroup.cards.first),
    );
  }

  Widget _buildScrollableList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: cardGroup.cards.length,
      itemBuilder: (context, index) => _buildCard(cardGroup.cards[index]),
    );
  }

  Widget _buildCard(CardItem card) {
    final formattedTitle = card.formattedTitle;
    final entity = formattedTitle?.entities.firstOrNull;
    final icon = card.icon as Map<String, dynamic>?;
    final description = card.formattedDescription;
    final descriptionEntity = description?.entities.firstOrNull;

    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: card.bgColor != null 
            ? Color(int.parse(card.bgColor!.replaceAll('#', '0xFF')))
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Container(
              width: card.iconSize?.toDouble() ?? 32,
              height: card.iconSize?.toDouble() ?? 32,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: icon['image_url'] ?? '',
                  width: card.iconSize?.toDouble(),
                  height: card.iconSize?.toDouble(),
                  fit: (icon['aspect_ratio'] as num?)?.toDouble() == 1.0 
                      ? BoxFit.contain 
                      : BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.person,
                    size: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: formattedTitle?.align == 'left' 
                ? CrossAxisAlignment.start 
                : CrossAxisAlignment.center,
            children: [
              if (entity != null)
                Text(
                  entity.text,
                  style: TextStyle(
                    color: entity.color != null 
                        ? Color(int.parse(entity.color!.replaceAll('#', '0xFF')))
                        : Colors.black,
                    fontSize: entity.fontSize?.toDouble(),
                    fontFamily: entity.fontFamily,
                    decoration: entity.fontStyle == 'underline'
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
              if (descriptionEntity != null)
                Text(
                  descriptionEntity.text,
                  style: TextStyle(
                    color: descriptionEntity.color != null 
                        ? Color(int.parse(descriptionEntity.color!.replaceAll('#', '0xFF')))
                        : Colors.black54,
                    fontSize: descriptionEntity.fontSize?.toDouble(),
                    fontFamily: descriptionEntity.fontFamily,
                    decoration: descriptionEntity.fontStyle == 'underline'
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
            ],
          ),
          if (!card.isDisabled && card.url != null) ...[
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black54,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSingleCard(CardItem card) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _buildCard(card),
    );
  }
}