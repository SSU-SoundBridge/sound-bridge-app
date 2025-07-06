import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

enum BottomBarButtonType {
  phone,
  map,
  follow,
  booking,
  contact,
  website,
  custom,
}

class BottomBarButton {
  const BottomBarButton({
    required this.type,
    required this.onPressed,
    this.text,
    this.icon,
    this.isActive = false,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.url,
  });

  final BottomBarButtonType type;
  final VoidCallback? onPressed;
  final String? text;
  final IconData? icon;
  final bool isActive;
  final String? phoneNumber;
  final double? latitude;
  final double? longitude;
  final String? url;
}

class CommonBottomBar extends StatelessWidget {
  const CommonBottomBar({
    super.key,
    required this.primaryButton,
    this.secondaryButtons = const [],
    this.showPriceInfo = false,
    this.priceLabel,
    this.priceValue,
  });

  final BottomBarButton primaryButton;
  final List<BottomBarButton> secondaryButtons;
  final bool showPriceInfo;
  final String? priceLabel;
  final String? priceValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.grey200)),
      ),
      child: Row(
        children: [
          // 가격 정보 (선택적)
          if (showPriceInfo && priceValue != null) ...[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  priceLabel ?? '가격',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  priceValue!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
          ],

          // 보조 버튼들 (아이콘 버튼)
          ...secondaryButtons.map(
            (button) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _buildIconButton(button),
            ),
          ),

          // 주요 버튼 (확장)
          Expanded(child: _buildPrimaryButton(primaryButton)),
        ],
      ),
    );
  }

  Widget _buildIconButton(BottomBarButton button) {
    IconData iconData;
    VoidCallback? onPressed;

    switch (button.type) {
      case BottomBarButtonType.phone:
        iconData = Icons.phone;
        onPressed =
            button.phoneNumber != null
                ? () => _launchPhone(button.phoneNumber!)
                : button.onPressed;
        break;
      case BottomBarButtonType.map:
        iconData = Icons.map;
        onPressed =
            (button.latitude != null && button.longitude != null)
                ? () => _launchMaps(button.latitude!, button.longitude!)
                : button.onPressed;
        break;
      case BottomBarButtonType.website:
        iconData = Icons.language;
        onPressed =
            button.url != null
                ? () => _launchUrl(button.url!)
                : button.onPressed;
        break;
      case BottomBarButtonType.custom:
        iconData = button.icon ?? Icons.more_horiz;
        onPressed = button.onPressed;
        break;
      default:
        iconData = button.icon ?? Icons.more_horiz;
        onPressed = button.onPressed;
    }

    return IconButton(
      onPressed: onPressed,
      icon: Icon(iconData, color: AppColors.primary),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildPrimaryButton(BottomBarButton button) {
    String buttonText;
    ButtonType buttonType = ButtonType.primary;
    VoidCallback? onPressed = button.onPressed;

    switch (button.type) {
      case BottomBarButtonType.follow:
        buttonText =
            button.isActive ? (button.text ?? '팔로잉') : (button.text ?? '팔로우');
        buttonType = button.isActive ? ButtonType.outline : ButtonType.primary;
        break;
      case BottomBarButtonType.booking:
        buttonText = button.text ?? '예약하기';
        buttonType = ButtonType.primary;
        break;
      case BottomBarButtonType.contact:
        buttonText = button.text ?? '연락하기';
        buttonType = ButtonType.outline;
        break;
      case BottomBarButtonType.custom:
        buttonText = button.text ?? '버튼';
        break;
      default:
        buttonText = button.text ?? '확인';
    }

    return CommonButtonWidget(
      text: buttonText,
      onPressed: onPressed,
      type: buttonType,
      isDisabled: onPressed == null,
    );
  }

  void _launchPhone(String phoneNumber) async {
    var uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchMaps(double latitude, double longitude) async {
    var uri = Uri.parse('https://maps.google.com/?q=$latitude,$longitude');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchUrl(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
