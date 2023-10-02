library navigation_dot_bar;

import 'package:flutter/material.dart';

import '../helper/helper_constant.dart';
import 'icon_navbar.dart';

class BottomNavigationDotBar extends StatefulWidget {
  final List<BottomNavigationDotBarItem> items;
  final Color activeColor;
  final Color color;

  const BottomNavigationDotBar(
      {required this.items,
      required this.activeColor,
      required this.color,
      required Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomNavigationDotBarState();
}

class _BottomNavigationDotBarState extends State<BottomNavigationDotBar> {
  final GlobalKey _keyBottomBar = GlobalKey();
  // ignore: unused_field
  late double _numPositionBase, _numDifferenceBase, _positionLeftIndicatorDot;
  int _indexPageSelected = 1;
  Color _color = Color.fromARGB(255, 29, 142, 159),
      _activeColor = gradientYellowColor;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    _color = widget.color;
    _activeColor = widget.activeColor;
    final sizeBottomBar =
        (_keyBottomBar.currentContext?.findRenderObject() as RenderBox).size;
    _numPositionBase = ((sizeBottomBar.width / widget.items.length));
    _numDifferenceBase = (_numPositionBase - (_numPositionBase / 2) + 2);
    setState(() {
      _positionLeftIndicatorDot =
          (_numPositionBase) * (_indexPageSelected + 1) - _numDifferenceBase;
    });
  }

  @override
  Widget build(BuildContext context) => Material(
      color: Colors.transparent,
      elevation: 3, // nav bar-iin too
      // borderRadius: BorderRadius.only(
      //     topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: baseColor, //bottomn
          // borderRadius: BorderRadius.only(
          //     topRight: Radius.circular(28.0), topLeft: Radius.circular(28.0)),
        ),
        child: Stack(
          key: _keyBottomBar,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 1),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                      _createNavigationIconButtonList(widget.items.asMap())),
            ),
            // AnimatedPositioned(
            //     child: CircleAvatar(radius: 2.5, backgroundColor: _activeColor),
            //     duration: Duration(milliseconds: 400),
            //     curve: Curves.fastOutSlowIn,
            //     left: _positionLeftIndicatorDot,
            //     bottom: 0),
          ],
        ),
      ));

  List<_NavigationIconButton> _createNavigationIconButtonList(
      Map<int, BottomNavigationDotBarItem> mapItem) {
    List<_NavigationIconButton> children = <_NavigationIconButton>[];
    mapItem.forEach(
      (index, item) => children.add(
        _NavigationIconButton(
          // item.image,
          item.icon,
          (index == _indexPageSelected) ? _activeColor : _color,
          item.onTap,
          () {
            _changeOptionBottomBar(index);
          },
          key: UniqueKey(),
        ),
      ),
    );
    return children;
  }

  void _changeOptionBottomBar(int indexPageSelected) {
    if (indexPageSelected != _indexPageSelected) {
      setState(() {
        _positionLeftIndicatorDot =
            (_numPositionBase * (indexPageSelected + 1)) - _numDifferenceBase;
      });
      _indexPageSelected = indexPageSelected;
    }
  }
}

class BottomNavigationDotBarItem {
  //final Image image;
  //Color? imageColor;
  // final IconData icon;
  final ImageIcon icon;
  final NavigationIconButtonTapCallback onTap;
  const BottomNavigationDotBarItem(
      {required this.icon,
      double? topPaddig,
      double? containerWidth,
      double? containerHeight,
      required this.onTap});
}

typedef NavigationIconButtonTapCallback = void Function();

class _NavigationIconButton extends StatefulWidget {
  final ImageIcon _icon;
  final Color _colorIcon;
  final NavigationIconButtonTapCallback _onTapInternalButton;
  final NavigationIconButtonTapCallback _onTapExternalButton;

  const _NavigationIconButton(this._icon, this._colorIcon,
      this._onTapInternalButton, this._onTapExternalButton,
      {required Key key})
      : super(key: key);

  @override
  _NavigationIconButtonState createState() => _NavigationIconButtonState();
}

class _NavigationIconButtonState extends State<_NavigationIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  //late Animation _scaleAnimation;
  double _opacityIcon = 1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    //print(widget._icon.image);
    //_scaleAnimation = Tween<double>(begin: 1, end: 0.93).animate(_controller);
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) {
          _controller.forward();
          setState(() {
            _opacityIcon = 0.7;
          });
        },
        onTapUp: (_) {
          _controller.reverse();
          setState(() {
            _opacityIcon = 1;
          });
        },
        onTapCancel: () {
          _controller.reverse();
          setState(() {
            _opacityIcon = 1;
          });
        },
        onTap: () {
          widget._onTapInternalButton();
          widget._onTapExternalButton();
        },
        child: ScaleTransition(
          scale: Tween<double>(begin: 1, end: 0.93).animate(_controller),
          child: AnimatedOpacity(
            opacity: _opacityIcon,
            duration: const Duration(milliseconds: 200),
            child: widget._icon.image.toString() ==
                    'AssetImage(bundle: null, name: "assets/plus_icon.png")'
                ? const Icon(
                    Icons.add_circle,
                    color: gradientYellowColor,
                    size: 40,
                  )
                : GradientIcon(
                    icon: widget._icon,
                    gradient: LinearGradient(
                      colors: widget._colorIcon == gradientYellowColor
                          ? [
                              gradientYellowColor,
                              gradientYellowColor,
                            ]
                          : [
                              const Color.fromRGBO(0, 25, 247, 1),
                              const Color.fromRGBO(0, 25, 247, 1),
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    size: 30,
                  ),

            // Icon(
            //   widget._icon,
            //   color: widget._colorIcon,
            //   size: 25.0,
            // ),
          ),
        ),
      );
}
