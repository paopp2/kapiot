import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/place/place_suggester.dart';
import 'package:kapiot/logic/shared/extensions.dart';
import 'package:kapiot/ui/place/components/base_place_picker.dart';

class SavePlacePicker extends HookConsumerWidget {
  const SavePlacePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeSuggester = ref.watch(placeSuggesterProvider);
    final initialText = ModalRoute.of(context)?.settings.arguments as String?;
    final tecSaveLoc = useTextEditingController(text: initialText);

    useEffect(() {
      tecSaveLoc.selectText();
    }, []);

    return BasePlacePicker(
      onPlaceSuggestionTap: (suggestion) async {
        final suggestedLoc = await placeSuggester.getLocation(suggestion);
        AppRouter.instance.popView(suggestedLoc!.copyWith(address: suggestion));
      },
      header: (context, constraints) {
        return [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffF8F9FD),
              border: Border.all(
                color: const Color(0xffF2F3F8),
                width: 2,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.05,
            ),
            margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.01),
            child: TextField(
              controller: tecSaveLoc,
              autofocus: true,
              style: GoogleFonts.montserrat(
                fontSize: 17,
                color: const Color(0xff333333),
              ),
              decoration: InputDecoration(
                hintText: "Enter Address",
                border: InputBorder.none,
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 17,
                  color: const Color(0xffaaaaaa),
                ),
              ),
              onChanged: placeSuggester.updateSuggestions,
            ),
          ),
        ];
      },
    );
  }
}
