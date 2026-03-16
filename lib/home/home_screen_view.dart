import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pord_practice/home/slider_provider.dart';

class HomeScreenView extends ConsumerWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Item List")),
      body: items.isEmpty
          ? const Center(
        child: Text(
          "No items found",
          style: TextStyle(fontSize: 20),
        ),
      )
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final itemDetail = items[index];
          return ListTile(
            title: Text(itemDetail.name),
            subtitle: Text(itemDetail.id),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref
                    .read(itemProvider.notifier)
                    .removeItem(itemDetail.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(itemProvider.notifier).addItem("New Item");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}