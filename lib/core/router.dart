import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:la_fecha/data/models/event.dart';
import 'package:la_fecha/ui/pages/event_detail_page.dart';
import 'package:la_fecha/ui/pages/home_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: ':id',
          builder: (BuildContext context, GoRouterState state) {
            final Event event = state.extra as Event;
            return EventDetailPage(
              event: event,
            );
          },
        ),
      ],
    ),
  ],
);
