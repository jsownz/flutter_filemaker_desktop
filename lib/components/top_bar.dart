import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_filemaker_desktop/providers/selected_layout_provider.dart';

class TopBar extends ConsumerWidget {
  TopBar({super.key});

  List<DropdownMenuEntry> layoutEntries = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text('Layout: ${ref.watch(selectedLayoutProvider)}'),
            DropdownMenu(dropdownMenuEntries: layoutEntries)
          ],
        ),
        MenuBar(
          style: MenuStyle(
            elevation: MaterialStateProperty.resolveWith<double>(
              // As you said you dont need elevation. I'm returning 0 in both case
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return 0;
                }
                return 0; // Defer to the widget's default.
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.transparent;
                }
                return Colors.transparent; // Defer to the widget's default.
              },
            ),
          ),
          children: [
            SubmenuButton(
              menuChildren: const [
                MenuItemButton(
                  // onPressed: () {
                  //   print("test");
                  // },
                  child: Text("About"),
                )
              ],
              style: SubmenuButton.styleFrom(
                alignment: Alignment.center,
              ),
              child: const Icon(Icons.menu),
            )
          ],
        ),
      ],
    );
  }
}
