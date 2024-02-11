import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/conf/conf_amal.dart';
import './bloc/node/node_amal.dart';
import './bloc/sys/sys_amal.dart';
import './bloc/ui/ui_amal.dart';

import './repo/conf_repo.dart';
import './repo/node_repo.dart';
import './repo/sys_repo.dart';

import './view/dashboard_route_amal.dart';
import './view/log_route_amal.dart';

void main() {
  runApp(MultiRepositoryProvider(providers: [
        RepositoryProvider<ConfRepo>(create: (context) => const ConfRepo()),
        RepositoryProvider<NodeRepo>(create: (context) => NodeRepo()),
        RepositoryProvider<SysRepo>(create: (context) => const SysRepo()),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<ConfBloc>(create: (context) => ConfBloc(confRepo: context.read<ConfRepo>())),
        BlocProvider<NodeBloc>(create: (context) => NodeBloc(nodeRepo: context.read<NodeRepo>())),
        BlocProvider<SysBloc>(create: (context) => SysBloc(sysRepo: context.read<SysRepo>())),
        BlocProvider<UIBloc>(create: (context) => UIBloc(sysBloc: context.read<SysBloc>(), nodeBloc: context.read<NodeBloc>())),
      ],
      child: MaterialApp(initialRoute: 'dashboard',
      routes: {
        'dashboard': (context) => const DashboardRoute(),
        'log': (context) => const LogRoute(),
      },
    ))));
}
