import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_management_app/common/utils/constants.dart';
import 'package:task_management_app/common/widgets/xpansion_tile.dart';
import 'package:task_management_app/features/todo/controllers/todo/todo_provider.dart';
import 'package:task_management_app/features/todo/controllers/xpansion_provider.dart';
import 'package:task_management_app/features/todo/pages/update_task.dart';
import 'package:task_management_app/features/todo/widgets/todo_tile.dart';

class DayAfterTomorrow extends ConsumerWidget {
  const DayAfterTomorrow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.read(todoStateProvider.notifier).getRandomColor();
    String dayafter = ref.read(todoStateProvider.notifier).getDayAfterTomorrow();

    var tomorrowTaks =
        todos.where((element) => element.date!.contains(dayafter));
    return XpansionTile(
        text: DateTime.now()
                      .add(const Duration(days: 2))
                      .toString()
                      .substring(5, 10),
                  text2: "Day After tomorrow tasks",
        onExpansionChanged: (bool expanded) {
          ref.read(xpansionStateProvider.notifier).setStart(!expanded);
        },
        trailing: Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: ref.watch(xpansionStateProvider)
              ? const Icon(
                  AntDesign.circledown,
                  
                )
              : const Icon(
                  AntDesign.closecircleo,
                  
                ),
        ),
        children: [
          for(final todo in tomorrowTaks)
          TodoTile(
            title: todo.title,
            description: todo.description,
            color: color,
            start: todo.startTime,
            end: todo.endTime,
            delete: () {
              ref.read(todoStateProvider.notifier).deleteTodo(todo.id ?? 0);
            },
            editWidget: GestureDetector(
              onTap: () {
                 titles = todo.title.toString();
                  descriptions = todo.description.toString();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateTask(
                                id: todo.id ?? 0,
                              )));
              },
              child: const Icon(MaterialCommunityIcons.circle_edit_outline),
            ),
            switcher: const SizedBox.shrink(),
          ),
        ]);
  }
}
