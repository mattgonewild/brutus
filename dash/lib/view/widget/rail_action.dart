part of 'rail_action_amal.dart';

class ActionRail extends StatelessWidget {
  const ActionRail({super.key});

  Widget _buildActionRailButtonIcon(ActionRailButtons button, Color iconColor, double iconOpacity) {
    final Widget icon;
    switch (button) {
      case ActionRailButtons.start:
        icon = DicePaint(color: iconColor, opacity: iconOpacity);
      case ActionRailButtons.stop:
        icon = StopPaint(color: iconColor, opacity: iconOpacity);
      case ActionRailButtons.log:
        icon = ScrollPaint(color: iconColor, opacity: iconOpacity);
      case ActionRailButtons.settings:
        icon = GearPaint(color: iconColor, opacity: iconOpacity);
    }
    return FractionallySizedBox(widthFactor: 0.75, heightFactor: 0.75, child: icon);
  }

  Widget _buildActionRailButton(BoxConstraints constraints, VoidCallback onTap, ActionRailButtons button) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: constraints.maxHeight / 4),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: BlocBuilder<UIBloc, UIState>(
            buildWhen: (previous, current) => previous.actionRailButtonStates[button] != current.actionRailButtonStates[button] && current.actionRailButtonStates[button] != null,
            builder: (context, state) => Card(
              color: state.actionRailButtonStates[button]!.backgroundColor,
              clipBehavior: Clip.hardEdge,
              elevation: 0.0,
              child: InkWell(
                onTap: onTap,
                onHover: (hover) {
                  context.read<UIBloc>().add(hover ? ARBHovered(button) : ARBUnhovered(button));
                },
                child: Column(children: [
                  Expanded(child: _buildActionRailButtonIcon(button, state.actionRailButtonStates[button]!.iconColor, state.actionRailButtonStates[button]!.iconOpacity)),
                ]),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Column(children: [
              _buildActionRailButton(constraints, () => context.read<UIBloc>().add(const ARBStartPressed()), ActionRailButtons.start),
              _buildActionRailButton(constraints, () => context.read<UIBloc>().add(const ARBStopPressed()), ActionRailButtons.stop),
              _buildActionRailButton(constraints, () => context.read<UIBloc>().add(const ARBLogPressed()), ActionRailButtons.log),
              const Spacer(),
              _buildActionRailButton(constraints, () => context.read<UIBloc>().add(const ARBSettingsPressed()), ActionRailButtons.settings),
            ]));
  }
}
