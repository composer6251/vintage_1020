import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

class BoothMetadataWidget extends StatelessWidget {
  const BoothMetadataWidget({
    super.key,
    required this.boothCost,
    required this.boothValue,
    required this.boothRentRemaining,
    required this.boothProfitMonthToDate,
  });

  final double boothCost;
  final double boothValue;
  final double boothRentRemaining;
  final double boothProfitMonthToDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 50,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('Cost: ${NumberFormat.currency(symbol: '\$').format(boothCost)}',style: TextStyle(fontSize: 20)),
                Text('Value: ${NumberFormat.currency(symbol: '\$').format(boothValue)}', style: TextStyle(fontSize: 20)),
              ],
            ),
            Column(
              children: [
                Text('Rent: ${NumberFormat.currency(symbol: '\$').format(boothRentRemaining)}', style: TextStyle(fontSize: 20)),
                Text('Profit: ${NumberFormat.currency(symbol: '\$').format(boothProfitMonthToDate)}!', style: TextStyle(color: Colors.green, fontSize: 20)),
              ],
            ),
        ])
      ),
    );
  }
}
