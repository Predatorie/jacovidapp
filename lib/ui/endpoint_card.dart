import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jacovida/app/services/api.dart';

class EndPointCardData {
  final String title;
  final String assetName;
  final Color color;

  EndPointCardData(
    this.title,
    this.assetName,
    this.color,
  );
}

class EndPointCard extends StatelessWidget {
  final EndPoint endPoint;
  final int value;

  const EndPointCard({Key key, this.endPoint, this.value}) : super(key: key);

  static Map<EndPoint, EndPointCardData> _cardData = {
    EndPoint.cases:
        EndPointCardData('Cases', 'assets/count.png', Colors.orange),
    EndPoint.casesSuspected: EndPointCardData(
        'Suspected Cases', 'assets/suspect.png', Colors.yellow),
    EndPoint.casesConfirmed:
        EndPointCardData('Confirmed Cases', 'assets/fever.png', Colors.pink),
    EndPoint.deaths: EndPointCardData('Deaths', 'assets/death.png', Colors.red),
    EndPoint.recovered:
        EndPointCardData('Recovered', 'assets/patient.png', Colors.green),
  };

  String get formattedValue {
    if (value == null) {
      return '';
    }

    return NumberFormat('#,###,###,###').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardData[endPoint];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData.title,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: cardData.color),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      cardData.assetName,
                      color: cardData.color,
                    ),
                    Text(
                      formattedValue,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: cardData.color, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
