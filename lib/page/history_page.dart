import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/model/history.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order History",
        ),
      ),
      body: BlocBuilder<RefillRequestHistoryBloc, RefillRequestHistoryState>(
          builder: (context, state) {
        if (state is RefillRequestHistoryLoading) {
          return Container();
        }
        if (state is RefillRequestHistoryLoaded) {
          final history = state.histories;

          return _buildHistoryList(history);
        }
        if (state is RefillRequestHistoryError) {
          return Container();
        }
      }),
    );
  }

  Widget _buildHistoryItems(
      BuildContext context, int position, History history) {
    return HistoryListItem(history);
  }

  Widget _buildHistoryList(List<History> histories) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      itemBuilder: (BuildContext context, int index) {
        return _buildHistoryItems(context, index, histories[index]);
      },
      itemCount: histories.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 4,
          thickness: 2,
          color: colorAccentYellow,
        );
      },
    );
  }
}
