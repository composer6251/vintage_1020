import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BoothMetricsWidget extends StatelessWidget{
  BoothMetricsWidget({required super.key, required this.boothItemCount, required this.boothCost, required this.boothValue});

  final int boothItemCount;
  final double boothCost;
  final double boothValue;

  @override
  Widget build(BuildContext context) {
      return Flexible(
              flex: 2,
              child: Card(
                elevation: 3.0,
                shadowColor: Colors.blueAccent,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                      'Items: $boothItemCount',
                    ),
                    Text(
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                      'Cost: ${NumberFormat.currency(symbol: '\$').format(boothCost)}',
                    ),
                    Text(
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                      'Value: ${NumberFormat.currency(symbol: '\$').format(boothValue)}',
                    ),
                  ],
                ),
              ),
            );
  }
}