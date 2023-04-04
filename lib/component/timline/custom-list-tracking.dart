library list_timeline;

import 'package:flutter/material.dart';
import 'image-component.dart';

class CustomListTracking<T> extends StatelessWidget {
  final List<T>? listItem;
  final String Function(T)? valueTextOfTitle;
  final String Function(T)? valueTextOfDesc;
  final String Function(T)? valueOfLeftSource;
  final bool showLeftWidget;
  final Color Function(T)? colorCircleTimeline;
  final bool isPrimary;
  final double textSize;
  final double textSizeOfDateLeftTimeline;
  final Widget Function(T)? customTitleWidget;
  final Widget Function(T)? customDescWidget;
  final Widget Function(T)? customLeftWidget;

  const CustomListTracking({
    Key? key,
    required this.listItem,
    this.isPrimary = false,
    this.valueTextOfTitle,
    this.valueTextOfDesc,
    this.valueOfLeftSource,
    this.colorCircleTimeline,
    this.showLeftWidget = false,
    this.customTitleWidget,
    this.customDescWidget,
    this.customLeftWidget,
    this.textSize = 12,
    this.textSizeOfDateLeftTimeline = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: !isPrimary,
        primary: isPrimary,
        itemCount: listItem!.length,
        itemBuilder: (context, index) => _itemTimeline(index));
  }

  Widget _itemTimeline(
    int currentIndex,
  ) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: showLeftWidget,
              child: Padding(
                padding: const EdgeInsets.only(top: 3, left: 5, right: 5),
                child: customLeftWidget == null
                    ? Text(
                        (valueOfLeftSource == null)
                            ? ""
                            : valueOfLeftSource!(listItem![currentIndex]),
                        style: TextStyle(fontSize: textSizeOfDateLeftTimeline),
                      )
                    : customLeftWidget!(listItem![currentIndex]),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 2,
              ),
              Container(
                width: 14,
                height: 14,
                margin:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              (currentIndex + 1 != listItem!.length)
                  ? Expanded(
                      child: Container(
                        height: double.infinity,
                        width: 1.5,
                        color: Colors.black87,
                      ),
                    )
                  : Container()
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTitleWidget == null
                      ? Text(
                          valueTextOfTitle == null
                              ? ""
                              : valueTextOfTitle!(listItem![currentIndex]),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : customTitleWidget!(listItem![currentIndex]),
                  customDescWidget == null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 12),
                          child: Text(valueTextOfDesc == null
                              ? ""
                              : valueTextOfDesc!(listItem![currentIndex])),
                        )
                      : customDescWidget!(listItem![currentIndex]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
