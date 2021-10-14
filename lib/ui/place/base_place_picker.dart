import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/place/place_suggester.dart';
import 'package:kapiot/logic/shared/extensions.dart';

class BasePlacePicker extends HookConsumerWidget {
  const BasePlacePicker({
    Key? key,
    required this.header,
    required this.onPlaceSuggestionTap,
  }) : super(key: key);

  final List<Widget> Function(BuildContext, BoxConstraints) header;
  final void Function(String suggestion) onPlaceSuggestionTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeSuggestions = ref.watch(placeSuggestionsProvider).state;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: AppRouter.instance.popView,
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.blue,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: header(context, constraints)
                  ..add(
                    Expanded(
                      child: ListView.builder(
                        itemCount: placeSuggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = placeSuggestions[index] ?? "";
                          final suggestionSplit = suggestion.splitAddress();
                          return Column(
                            children: [
                              ListTile(
                                dense: true,
                                title: Text(
                                  suggestionSplit.first,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  suggestionSplit.last,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                onTap: () => onPlaceSuggestionTap(suggestion),
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                                height: 0.05,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
              ),
            ),
          ),
        );
      },
    );
  }
}
