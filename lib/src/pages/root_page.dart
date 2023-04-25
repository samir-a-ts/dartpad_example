import 'package:dartpad_flutter/src/domain/dartpad.dart';
import 'package:dartpad_flutter/src/state/link_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final _linkGenerator = LinkGenerator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedBuilder(
          animation: _linkGenerator,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Тип страницы',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                PageChooseWidget(
                  onChose: (value) {
                    if (value != null) {
                      _linkGenerator.setPage(value);
                    }
                  },
                  selectedPage: _linkGenerator.selectedPage,
                ),
                if (_linkGenerator.selectedPage != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    'Дополнительные данные',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  for (final input in dartPadFieldsMap[_linkGenerator.selectedPage!]!) ...[
                    if (input == DartPadField.theme) ...[
                      const Text('Тема'),
                      ThemeChoseWidget(
                        selectedTheme: _linkGenerator.theme,
                        onChose: (DartPadTheme? value) {
                          if (value != null) {
                            _linkGenerator.setTheme(value);
                          }
                        },
                      )
                    ] else if (input == DartPadField.run)
                      Row(
                        children: [
                          const Text('Запустить при открытии?'),
                          Checkbox(
                            value: _linkGenerator.run != null,
                            onChanged: (value) {
                              if (value != null) {
                                _linkGenerator.setRun(value);
                              }
                            },
                          )
                        ],
                      )
                    else if (input == DartPadField.split) ...[
                      Slider(
                        divisions: 100,
                        min: 1,
                        max: 100,
                        value: (_linkGenerator.split ?? 50).toDouble(),
                        onChanged: (value) {
                          _linkGenerator.setSplit(value.toInt());
                        },
                      ),
                    ] else
                      const SizedBox(),
                    const SizedBox(height: 10),
                  ],
                ],
              ],
            );
          },
        ),
      ),
      bottomSheet: AnimatedBuilder(
        animation: _linkGenerator,
        builder: (context, widget) {
          return GeneratedLinkWidget(
            link: _linkGenerator.buildUri(),
          );
        },
      ),
    );
  }
}

class ThemeChoseWidget extends StatelessWidget {
  final ValueChanged<DartPadTheme?> onChose;

  final DartPadTheme? selectedTheme;

  const ThemeChoseWidget({
    super.key,
    required this.onChose,
    this.selectedTheme,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: const Icon(Icons.chevron_right),
      items: <DropdownMenuItem<DartPadTheme>>[
        for (final item in DartPadTheme.values)
          DropdownMenuItem(
            value: item,
            child: Text(
              item.toTitleString(),
            ),
          ),
      ],
      value: selectedTheme,
      onChanged: onChose,
    );
  }
}

class PageChooseWidget extends StatelessWidget {
  final ValueChanged<DartPadPage?> onChose;

  final DartPadPage? selectedPage;

  const PageChooseWidget({
    super.key,
    required this.onChose,
    this.selectedPage,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: const Icon(Icons.chevron_right),
      items: <DropdownMenuItem<DartPadPage>>[
        for (final item in DartPadPage.values)
          DropdownMenuItem(
            value: item,
            child: Text(
              item.toTitleString(),
            ),
          ),
      ],
      value: selectedPage,
      onChanged: onChose,
    );
  }
}

class GeneratedLinkWidget extends StatelessWidget {
  final Uri? link;

  const GeneratedLinkWidget({
    super.key,
    this.link,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (link != null) {
          final url = link.toString();

          Clipboard.setData(
            ClipboardData(text: url),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Введите валидные данные'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              color: Colors.grey,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                link != null ? link.toString() : 'Введите корректные данные',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: link != null ? Colors.black : Colors.redAccent,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              const Text('Нажмите, чтобы скопировать'),
            ],
          ),
        ),
      ),
    );
  }
}
