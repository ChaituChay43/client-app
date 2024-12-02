import 'package:flutter/material.dart';

class ColumnConfig {
  final String name;
  final int flex;
  final TextAlign textAlign;
  final bool isBold;
  final bool isEllipsis;
  final Color backgroundColor;
  final bool isChange;
  final Color smallboxColor;

  ColumnConfig({
    required this.name,
    this.flex = 1,
    this.textAlign = TextAlign.center,
    this.isBold = false,
    this.isEllipsis = false,
    this.backgroundColor = Colors.transparent,
    this.smallboxColor = Colors.red,
    this.isChange = false,
  });
}

class ReusableTable extends StatelessWidget {
  final List<Map<String, dynamic>> tableData;
  final List<ColumnConfig> columns;
  final List<Color> colors;

  const ReusableTable({
    required this.tableData,
    required this.columns,
    required this.colors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      child: tableData.isEmpty
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            )
          : Column(
              children: [
                // Table Headers
                Row(
                  children: columns.map((column) {
                    return Expanded(
                      flex: column.flex,
                      child: Center(
                        child: Text(
                          column.name,
                          style: const TextStyle(fontSize: 13.0,color: Colors.black),
                          overflow: column.isEllipsis ? TextOverflow.ellipsis : null,
                          textAlign: column.textAlign,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const Divider(thickness: 1),
                // Expanding ListView to take the remaining space
                Expanded(
                  child: ListView.separated(
                    itemCount: tableData.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final item = tableData[index];
                      return Row(
                        children: columns.map((column) {
                          return Expanded(
                            flex: column.flex,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10.0)),
                                  color: column.backgroundColor,
                                ),
                                child: Center(
                                  child: column.isChange
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                color: colors[index % colors.length],
                                              ),
                                              margin:
                                                  const EdgeInsets.only(right: 10.0),
                                              child: const SizedBox(
                                                height: 10.0,
                                                width: 10.0,
                                              ),
                                            ),
                                            Expanded(
                                              child: Tooltip(
                                                message: item[column.name]
                                                        ?.toString() ??
                                                    '',
                                                child: Text(
                                                  item[column.name]?.toString() ??
                                                      '',
                                                  style: TextStyle(
                                                    fontWeight: column.isBold
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                  ),
                                                  overflow: column.isEllipsis
                                                      ? TextOverflow.ellipsis
                                                      : TextOverflow.visible,
                                                  textAlign: column.textAlign,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Tooltip(
                                          message: item[column.name]?.toString() ??
                                              '',
                                          child: Text(
                                            item[column.name]?.toString() ?? '',
                                            style: TextStyle(
                                                fontWeight: column.isBold
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                fontSize: 7.0),
                                            overflow: column.isEllipsis
                                                ? TextOverflow.ellipsis
                                                : null,
                                            textAlign: column.textAlign,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
