import 'package:dash/bloc/conf/conf_bloc.dart';
import 'package:dash/bloc/node/node_bloc.dart';
import 'package:dash/bloc/sys/sys_bloc.dart';
import 'package:dash/bloc/ui/ui_bloc.dart';
import 'package:dash/repo/conf_repo.dart';
import 'package:dash/repo/node_repo.dart';
import 'package:dash/repo/sys_repo.dart';
import 'package:dash/view/dashboard_route.dart';
import 'package:dash/view/log_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiRepositoryProvider(providers: [
        RepositoryProvider<ConfRepo>(create: (context) => const ConfRepo()),
        RepositoryProvider<NodeRepo>(create: (context) => const NodeRepo()),
        RepositoryProvider<SysRepo>(create: (context) => const SysRepo()),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<ConfBloc>(create: (context) => ConfBloc(confRepo: context.read<ConfRepo>())),
        BlocProvider<NodeBloc>(create: (context) => NodeBloc(nodeRepo: context.read<NodeRepo>())),
        BlocProvider<SysBloc>(create: (context) => SysBloc(sysRepo: context.read<SysRepo>())),
        BlocProvider<UIBloc>(create: (context) => UIBloc(sysBloc: context.read<SysBloc>())),
      ],
      child: MaterialApp(initialRoute: 'dashboard',
      routes: {
        'dashboard': (context) => const DashboardRoute(),
        'log': (context) => const LogRoute(),
      },
    ))));
}
