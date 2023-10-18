// import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

// class TopBar extends StatelessWidget {
//   const TopBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return WindowTitleBarBox(
//       child: Row(
//         children: [Expanded(child: MoveWindow()), const WindowButtons()],
//       ),
//     );
//   }
// }

// final buttonColors = WindowButtonColors(
//     iconNormal: const Color(0xFF805306),
//     mouseOver: const Color(0xFFF6A00C),
//     mouseDown: const Color(0xFF805306),
//     iconMouseOver: const Color(0xFF805306),
//     iconMouseDown: const Color(0xFFFFD500));

// final closeButtonColors = WindowButtonColors(
//     mouseOver: const Color(0xFFD32F2F),
//     mouseDown: const Color(0xFFB71C1C),
//     iconNormal: const Color(0xFF805306),
//     iconMouseOver: Colors.white);

// class WindowButtons extends StatefulWidget {
//   const WindowButtons({Key? key}) : super(key: key);

//   @override
//   _WindowButtonsState createState() => _WindowButtonsState();
// }

// class _WindowButtonsState extends State<WindowButtons> {
//   void maximizeOrRestore() {
//     setState(() {
//       appWindow.maximizeOrRestore();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         MinimizeWindowButton(colors: buttonColors),
//         appWindow.isMaximized
//             ? RestoreWindowButton(
//                 colors: buttonColors,
//                 onPressed: maximizeOrRestore,
//               )
//             : MaximizeWindowButton(
//                 colors: buttonColors,
//                 onPressed: maximizeOrRestore,
//               ),
//         CloseWindowButton(colors: closeButtonColors),
//       ],
//     );
//   }
// }

class TopBar extends StatelessWidget {
  TopBar({super.key});

  List<DropdownMenuEntry> layoutEntries = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        layoutEntries.isNotEmpty
            ? Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Layout: '),
                  DropdownMenu(dropdownMenuEntries: layoutEntries)
                ],
              )
            : const SizedBox(
                width: 10,
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
