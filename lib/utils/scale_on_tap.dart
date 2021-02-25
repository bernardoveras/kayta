import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

class ScaleOnTap extends StatefulWidget {
  final Function() onTap;
  final Function() onLongPress;
  final Function() onDoubleTap;
  final Widget child;
  final Duration duration;
  final double scaleMinValue;
  final Curve scaleCurve;
  final Curve opacityCurve;
  final double opacityMinValue;

  ScaleOnTap({
    @required this.onTap,
    this.onLongPress,
    @required this.child,
    this.onDoubleTap,
    this.duration = const Duration(milliseconds: 250),
    this.scaleMinValue = 0.96,
    this.opacityMinValue = 0.9,
    this.scaleCurve,
    this.opacityCurve,
  });

  @override
  _ScaleTapState createState() => _ScaleTapState();
}

class _ScaleTapState extends State<ScaleOnTap>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scale;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    _scale = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(_animationController);
    _opacity = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Curve get _computedScaleCurve {
    return widget.scaleCurve ?? CurveSpring();
  }

  Curve get _computedOpacityCurve {
    return widget.opacityCurve ?? Curves.ease;
  }

  Duration get _computedDuration {
    return widget.duration ?? Duration(milliseconds: 300);
  }

  Future<void> anim({double scale, double opacity, Duration duration}) {
    _animationController?.stop();
    _animationController.duration = duration ?? Duration.zero;

    _scale = Tween<double>(
      begin: _scale.value,
      end: scale,
    ).animate(CurvedAnimation(
      curve: _computedScaleCurve,
      parent: _animationController,
    ));
    _opacity = Tween<double>(
      begin: _opacity.value,
      end: opacity,
    ).animate(CurvedAnimation(
      curve: _computedOpacityCurve,
      parent: _animationController,
    ));
    _animationController?.reset();
    return _animationController?.forward();
  }

  Future<void> _onTapDown(_) {
    return anim(
      scale: widget.scaleMinValue,
      opacity: widget.opacityMinValue,
      duration: _computedDuration,
    );
  }

  Future<void> _onTapUp(_) {
    return anim(
      scale: 1.0,
      opacity: 1.0,
      duration: _computedDuration,
    );
  }

  Future<void> _onTapCancel(_) {
    return _onTapUp(_);
  }

  Widget _container({Widget child}) {
    if (widget.onTap != null || widget.onLongPress != null) {
      return Listener(
        onPointerDown: _onTapDown,
        onPointerCancel: _onTapCancel,
        onPointerUp: _onTapUp,
        child: GestureDetector(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          onDoubleTap: widget.onDoubleTap,
          child: child,
        ),
      );
    }

    return child;
  }

  @override
  Widget build(BuildContext context) {
    return _container(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, Widget child) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.scale(
              alignment: Alignment.center,
              scale: _scale.value,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class CurveSpring extends Curve {
  final SpringSimulation sim;

  CurveSpring() : this.sim = _sim(70, 20);

  @override
  double transform(double t) => sim.x(t) + t * (1 - sim.x(1.0));
}

_sim(double stiffness, double damping) => SpringSimulation(
      SpringDescription.withDampingRatio(
        mass: 1,
        stiffness: stiffness,
        ratio: 0.7,
      ),
      0.0,
      1.0,
      0.0,
    );
