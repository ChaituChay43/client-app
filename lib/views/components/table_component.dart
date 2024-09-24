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
    this.smallboxColor=Colors.red,
    this.isChange=false,
  });
}

class ReusableTable extends StatelessWidget {
  final List<Map<String, dynamic>> tableData;
  final List<ColumnConfig> columns;

  const ReusableTable({
    required this.tableData,
    required this.columns,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int totalColumns = 12;
    final totalFlex = columns.fold<int>(0, (sum, column) => sum + column.flex);
   const Color darkBlue = Color(0xFF0E3D66);  // #0E3D66
    const Color green = Color(0xFF43C478); 
  const Color lightBlue = Color(0xFF1195D6);
  const Color mediumBlue = Color(0xFF08548A); // #1195D6
  
  final List<Color> _colors = [darkBlue,green,lightBlue, mediumBlue,];

    return Container(
      padding: EdgeInsets.all(18.0),
      child: Column(
        children: [
          // Table Headers
          Row(
            children: columns.map((column) {
              return Expanded(
                flex: column.flex,
                child: Center(
                  child: Text(
                    column.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                          padding: EdgeInsets.all(10.0),
                         decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: column.backgroundColor,
                          
                         ),
                          child: Center(
                            child:column.isChange?Container(
                              child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: SizedBox(
                                    height: 10.0,
                                    width: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(1.0)),
                                    color: _colors[index],
                                  ),
                                  margin: EdgeInsets.only(right: 10.0),
                                ),
                                Expanded(
                                  child: Text(
                                    item[column.name]?.toString() ?? '',
                                    style: TextStyle(
                                      fontWeight: column.isBold ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    overflow: column.isEllipsis ? TextOverflow.ellipsis : TextOverflow.visible,
                                    textAlign: column.textAlign,
                                  ),
                                ),
                              ],
                            )

                            ): Text(
                              item[column.name]?.toString() ?? '',
                              style: TextStyle(
                                fontWeight: column.isBold ? FontWeight.bold : FontWeight.normal,
                                fontSize: 13.0
                              ),
                              overflow: column.isEllipsis ? TextOverflow.ellipsis : null,
                              textAlign: column.textAlign,
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