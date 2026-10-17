import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../domain/entities/request_stage.dart';

/// Seguimiento vertical por etapas.
class RequestTracker extends StatelessWidget {
  const RequestTracker({super.key, required this.current});
  final RequestStage current;

  @override
  Widget build(BuildContext context) {
    final stages = RequestStage.values;
    return Column(
      children: [
        for (final s in stages)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 36,
                  child: Column(children: [
                    _dot(s),
                    if (s != stages.last)
                      Expanded(
                        child: Container(
                          width: 3,
                          color: s.index < current.index
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                      ),
                  ]),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: s == stages.last ? 0 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s == current ? '${s.title} · Etapa actual' : s.title,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: s.index > current.index
                                  ? AppColors.muted
                                  : AppColors.text),
                        ),
                        Text(s.description,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _dot(RequestStage s) {
    final done = s.index < current.index;
    final active = s == current;
    final filled = done || active;
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.primary : Colors.white,
        border: Border.all(
            color: filled ? AppColors.primary : AppColors.border, width: 2),
      ),
      child: Center(
        child: done
            ? const Icon(Icons.check, color: Colors.white, size: 22)
            : Text('${s.index + 1}',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: active ? Colors.white : AppColors.muted)),
      ),
    );
  }
}
