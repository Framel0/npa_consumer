import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Contact Us",
      )),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        children: <Widget>[
          _buildListItem(
              icon: Icons.phone,
              iconColor: Colors.green,
              title: "Phone",
              subTitle: "(+233) 54 50 061 11",
              onTap: () async {
                const number = 'tel:+233 54 50 061 11';
                if (await canLaunch(number)) {
                  await launch(number);
                } else {
                  throw 'Could not launch $number';
                }
              }),
          _divider(),
          _buildListItem(
              icon: Icons.email,
              iconColor: Colors.lightBlue,
              title: "Email",
              subTitle: "info@npa.gov.gh",
              onTap: () async {
                const url = 'info@npa.gov.gh?subject=NPA Customer=New%20plugin';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              }),
          _divider(),
          _buildListItem(
              icon: Icons.room,
              iconColor: Colors.red,
              title: "Address",
              subTitle: "Adjacent Petroleum Commission,Dzorwulu, Accra."),
          _divider(),
          _buildListItem(
              icon: Icons.web,
              iconColor: Colors.purple,
              title: "Website",
              subTitle: "www.npa.gov.gh",
              onTap: () async {
                const url = 'http://www.npa.gov.gh';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              }),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 4,
      thickness: 2,
    );
  }

  Widget _buildListItem(
      {IconData icon,
      Color iconColor,
      String title,
      String subTitle,
      GestureTapCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 16),
          children: <TextSpan>[
            TextSpan(
                text: '$title: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: subTitle),
          ],
        ),
      ),
    );
  }
}
