part of 'rail_action_amal.dart';

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
  const ActionRailButton({super.key, required Widget icon, required String label, required VoidCallback onPressed, required ButtonStyle buttonStyle, required TextStyle textStyle}) : _icon = icon, _label = label, _onPressed = onPressed, _buttonStyle = buttonStyle, _textStyle = textStyle;

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
    return BlocBuilder<UIBloc, UIState>(buildWhen: (previous, current) => previous.actionRailButtonStates[ActionRailButtons.start] != current.actionRailButtonStates[ActionRailButtons.start],
      builder: (context, state) => ActionRailButton(icon: const DicePaint(color: Colors.black, opacity: 1.0), label: 'start', onPressed: () => context.read<UIBloc>().add(const ARBStartPressed()), buttonStyle: const ButtonStyle(), textStyle: state.actionRailButtonStates[ActionRailButtons.start]!.textStyle),
    );
  }
}

class ARBStop extends StatelessWidget {
  const ARBStop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIBloc, UIState>(buildWhen: (previous, current) => previous.actionRailButtonStates[ActionRailButtons.stop] != current.actionRailButtonStates[ActionRailButtons.stop],
      builder: (context, state) => ActionRailButton(icon: const StopPaint(color: Colors.black, opacity: 1.0), label: 'stop', onPressed: () => context.read<UIBloc>().add(const ARBStopPressed()), buttonStyle: const ButtonStyle(), textStyle: state.actionRailButtonStates[ActionRailButtons.stop]!.textStyle),
    );
  }
}

class ARBLog extends StatelessWidget {
  const ARBLog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIBloc, UIState>(buildWhen: (previous, current) => previous.actionRailButtonStates[ActionRailButtons.log] != current.actionRailButtonStates[ActionRailButtons.log],
      builder: (context, state) => ActionRailButton(icon: const ScrollPaint(color: Colors.black, opacity: 1.0), label: 'log', onPressed: () => context.read<UIBloc>().add(const ARBLogPressed()), buttonStyle: const ButtonStyle(), textStyle: state.actionRailButtonStates[ActionRailButtons.log]!.textStyle),
    );
  }
}

class ARBSettings extends StatelessWidget {
  const ARBSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIBloc, UIState>(buildWhen: (previous, current) => previous.actionRailButtonStates[ActionRailButtons.settings] != current.actionRailButtonStates[ActionRailButtons.settings],
      builder: (context, state) => ActionRailButton(icon: const GearPaint(color: Colors.black, opacity: 1.0), label: 'settings', onPressed: () => context.read<UIBloc>().add(const ARBSettingsPressed()), buttonStyle: const ButtonStyle(), textStyle: state.actionRailButtonStates[ActionRailButtons.settings]!.textStyle),
    );
  }
}
