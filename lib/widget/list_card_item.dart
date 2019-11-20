import 'package:flutter/material.dart';
import 'package:npa_user/page/services_page.dart';

class CardListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  CardListItem(this.title, {this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 170,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
      child: Card(
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, "/bookDetails");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext cotext) => ServicesPage()));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                child: Icon(
                  icon,
                  size: 80,
                ),
              ),
              Text(
                title,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    Theme.of(context).textTheme.subtitle.copyWith(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
