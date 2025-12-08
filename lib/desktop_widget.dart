import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, BlocBuilder, ReadContext;
import 'package:portfolio/cubit/time_cubit_cubit.dart';
import 'package:portfolio/cubit/window_cubit.dart';
import 'package:portfolio/window_model.dart';
import 'package:portfolio/window_widget.dart';

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(context),
      body: BlocProvider(
        create: (context) => WindowCubit(),
        child: BlocBuilder<WindowCubit, List<WindowWidget>>(
          builder: (context, state) {
            return Stack(
              children: [
                Background(),
                Row(
                  spacing: 16,
                  children: [
                    Dock(),
                    Column(
                      spacing: 16,
                      children: [
                        DesktopIcon(
                          icon: Icons.person,
                          tooltip: "Profile",
                          onTap: () {
                            final id = Random().nextInt(1000).toString();
                            context.read<WindowCubit>().addWindow(
                              plantillaWindow(id, context, "Profile"),
                            );
                          },
                        ),
                        DesktopIcon(
                          icon: Icons.folder,
                          tooltip: "Projects",
                          onTap: () {
                            final id = Random().nextInt(1000).toString();
                            context.read<WindowCubit>().addWindow(
                              plantillaWindow(id, context, "Projects"),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                ...state,
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar topBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: MediaQuery.of(context).size.height * 0.05,
      backgroundColor: Theme.of(context).colorScheme.surface,
      actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],

      title: BlocProvider(
        create: (context) => TimeCubitCubit(),
        child: BlocBuilder<TimeCubitCubit, String>(
          builder: (context, state) {
            context.read<TimeCubitCubit>().update();
            return Text(
              state,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }
}

class Dock extends StatelessWidget {
  const Dock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,

        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: BlocBuilder<WindowCubit, List<WindowWidget>>(
        builder: (context, state) {
          final pinnedApps = {"Projects"};
          final openApps = state.map((w) => w.window.title).toSet();
          final minimizedApps = context
              .read<WindowCubit>()
              .minimizedWindows
              .map((w) => w.window.title)
              .toSet();

          final dockApps = {...pinnedApps, ...openApps, ...minimizedApps};

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dockApps.map((title) {
              return DockIcon(
                icon: _getIconForTitle(title),
                tooltip: title,
                onTap: () => _handleWindowAction(context, state, title),
                minimized: context.read<WindowCubit>().minimizedWindows.any(
                  (w) => w.window.title == title,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title) {
      case "Projects":
        return Icons.folder;
      case "Profile":
        return Icons.person;
      default:
        return Icons.app_shortcut;
    }
  }

  void _handleWindowAction(
    BuildContext context,
    List<WindowWidget> activeWindows,
    String title,
  ) {
    final cubit = context.read<WindowCubit>();
    final minimizedWindow = cubit.minimizedWindows
        .where((w) => w.window.title == title)
        .firstOrNull;
    final activeWindow = activeWindows
        .where((w) => w.window.title == title)
        .firstOrNull;

    if (minimizedWindow != null) {
      cubit.maximizeWindow(minimizedWindow.window.id);
    } else if (activeWindow != null) {
      cubit.focusWindow(activeWindow.window.id);
    } else {
      final id = Random().nextInt(1000).toString();
      cubit.addWindow(plantillaWindow(id, context, title));
    }
  }
}

class DockIcon extends StatelessWidget {
  const DockIcon({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onTap,
    this.minimized = false,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;
  final bool minimized;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          minimized
              ? Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                )
              : SizedBox(),
          IconButton(
            onPressed: onTap,
            icon: Icon(icon, size: 30),
            tooltip: tooltip,
          ),
        ],
      ),
    );
  }
}

class DesktopIcon extends StatelessWidget {
  const DesktopIcon({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onTap,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: 50),
          tooltip: tooltip,
        ),
        Text(
          tooltip,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withAlpha(0)),
        ),
      ),
    );
  }
}

WindowWidget plantillaWindow(String id, BuildContext context, String title) {
  return WindowWidget(
    window: WindowModel(
      id: id,
      title: title,
      content: Container(),
      size: const Size(800, 500),
    ),
    onClose: () {
      context.read<WindowCubit>().removeWindow(id);
    },
    onFocus: () {
      context.read<WindowCubit>().focusWindow(id);
    },
    onMinimize: () {
      context.read<WindowCubit>().minimizeWindow(id);
    },
    onMaximize: () {
      context.read<WindowCubit>().maximizeWindow(id);
    },
    screenSize: MediaQuery.of(context).size,
  );
}
