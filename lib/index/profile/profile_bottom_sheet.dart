import 'package:flutter/material.dart';

class ShowBottomSheet extends StatefulWidget {
  final int id;
  const ShowBottomSheet({Key? key, required this.id}) : super(key: key);

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white)),
        child: const Icon(Icons.menu),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return BottomSheetButtons(id: widget.id);
              });
        });
  }
}

class BottomSheetButtons extends StatelessWidget {
  final int id;
  BottomSheetButtons({Key? key, required this.id}) : super(key: key);

  final ButtonStyle style = ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      alignment: Alignment.centerLeft,
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.infinity, 50)));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton.icon(
            style: style,
            icon: const Icon(
              Icons.settings,
            ),
            label: const Text('Configurações'),
            onPressed: () => Navigator.pushNamed(context, '/profile_settings',
                arguments: id)),
        TextButton.icon(
          style: style,
          icon: const Icon(
            Icons.history,
          ),
          label: const Text('Itens Arquivados'),
          onPressed: () {},
        ),
        TextButton.icon(
          style: style,
          icon: const Icon(
            Icons.watch_later_outlined,
          ),
          label: const Text('Sua Atividade'),
          onPressed: () {},
        ),
        TextButton.icon(
          style: style,
          icon: const Icon(
            Icons.bookmark_border,
          ),
          label: const Text('Salvo'),
          onPressed: () {},
        ),
      ],
    );
  }
}
