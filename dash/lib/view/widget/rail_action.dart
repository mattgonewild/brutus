import 'package:dash/bloc/ui/ui_bloc.dart';
import 'package:dash/view/widget/painter_dice.dart';
import 'package:dash/view/widget/painter_gear.dart';
import 'package:dash/view/widget/painter_scroll.dart';
import 'package:dash/view/widget/painter_stop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionRail extends StatelessWidget {
  const ActionRail({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => Column(children: [
      ConstrainedBox(constraints: BoxConstraints(maxHeight: constraints.maxHeight / 4), child: const AspectRatio(aspectRatio: 1.0, child: ARBStart())),
      ConstrainedBox(constraints: BoxConstraints(maxHeight: constraints.maxHeight / 4), child: const AspectRatio(aspectRatio: 1.0, child: ARBStop())),
      ConstrainedBox(constraints: BoxConstraints(maxHeight: constraints.maxHeight / 4), child: const AspectRatio(aspectRatio: 1.0, child: ARBLog())),
      const Spacer(),
      ConstrainedBox(constraints: BoxConstraints(maxHeight: constraints.maxHeight / 4), child: const AspectRatio(aspectRatio: 1.0, child: ARBSettings())),
    ]));
  }
}

class ActionRailButton extends StatelessWidget {
  const ActionRailButton({super.key, required icon, required label, required onPressed, required buttonStyle, required textStyle}) : _icon = icon, _label = label, _onPressed = onPressed, _buttonStyle = buttonStyle, _textStyle = textStyle;

  final Widget _icon;
  final String _label;
  final VoidCallback _onPressed;
  final ButtonStyle _buttonStyle;
  final TextStyle _textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: IconButton(icon: _icon, onPressed: _onPressed, style: _buttonStyle)),
      Expanded(child: Text(_label, style: _textStyle)),
    ]);
  }
}

class ARBStart extends StatelessWidget {
  const ARBStart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIBloc, UIState>(buildWhen: (previous, current) => previous.ARBStart != current.ARBStart,
      builder: (context, state) => ActionRailButton(icon: const DicePaint(color: Colors.black, opacity: 1.0), label: 'start', onPressed: () => context.read<UIBloc>().add(const ARBStartPressed()), buttonStyle: state.ARBStartButtonStyle, textStyle: state.ARBStartTextStyle),
    );
  }
}

class ARBStop extends StatelessWidget {
  const ARBStop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIBloc, UIState>(buildWhen: (previous, current) => previous.ARBStop != current.ARBStop,
      builder: (context, state) => ActionRailButton(icon: const StopPaint(color: Colors.black, opacity: 1.0), label: 'stop', onPressed: () => context.read<UIBloc>().add(const ARBStopPressed()), buttonStyle: state.ARBStopButtonStyle, textStyle: state.ARBStopTextStyle),
    );
  }
}

class ARBLog extends StatelessWidget {
  const ARBLog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIBloc, UIState>(buildWhen: (previous, current) => previous.ARBLog != current.ARBLog,
      builder: (context, state) => ActionRailButton(icon: const ScrollPaint(color: Colors.black, opacity: 1.0), label: 'log', onPressed: () => context.read<UIBloc>().add(const ARBLogPressed()), buttonStyle: state.ARBLogButtonStyle, textStyle: state.ARBLogTextStyle),
    );
  }
}

class ARBSettings extends StatelessWidget {
  const ARBSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIBloc, UIState>(buildWhen: (previous, current) => previous.ARBSettings != current.ARBSettings,
      builder: (context, state) => ActionRailButton(icon: const GearPaint(color: Colors.black, opacity: 1.0), label: 'settings', onPressed: () => context.read<UIBloc>().add(const ARBSettingsPressed()), buttonStyle: state.ARBSettingsButtonStyle, textStyle: state.ARBSettingsTextStyle),
    );
  }
}
