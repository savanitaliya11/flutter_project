import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.account_circle,
                size: 64,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My status',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2, right: 75),
                        child: Text('Tap to add status update'),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.5, horizontal: 10),
                child: Text(
                  'Recent updates',
                  textAlign: TextAlign.start,
                ),
              ),
              height: 30,
              width: MediaQuery.of(context).size.width,
              color: Color(0xffECE5DD),
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 64,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'SAVAN',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              '6 minutes ago',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            itemCount: 20,
          ),
        )
      ],
    );
  }
}
