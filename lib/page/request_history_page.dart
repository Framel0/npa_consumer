import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class RequestHistoryPage extends StatefulWidget {
  @override
  _RequestHistoryPageState createState() => _RequestHistoryPageState();
}

class _RequestHistoryPageState extends State<RequestHistoryPage> {
  @override
  void initState() {
    super.initState();

    _getRequestHistory();
  }

  _getRequestHistory() async {
    final user = await readUserData();

    BlocProvider.of<RefillRequestHistoryBloc>(context)
        .dispatch(FetchRefillRequestHistory(consumerId: user.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Request History",
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
            ),
            tooltip: 'Refresh',
            onPressed: _getRequestHistory,
          ),
        ],
      ),
      body: BlocBuilder<RefillRequestHistoryBloc, RefillRequestHistoryState>(
          builder: (context, state) {
        if (state is RefillRequestHistoryLoading) {
          return Center(
            child: LoadingIndicator(),
          );
        }
        if (state is RefillRequestHistoryLoaded) {
          final history = state.histories;
          if (history.isEmpty) {
            return Center(child: Text("No History Available"));
          } else {
            return _buildHistoryList(history);
          }
        }
        if (state is RefillRequestHistoryError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Something went wrong!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorPrimary,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.replay,
                  color: colorSecondaryOrange,
                ),
                onPressed: _getRequestHistory,
              )
            ],
          );
        }
      }),
    );
  }

  Widget _buildHistoryItems(
      BuildContext context, int position, RequestHistory history) {
    return RequestHistoryListItem(history);
  }

  Widget _buildHistoryList(List<RequestHistory> histories) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return _buildHistoryItems(context, index, histories[index]);
      },
      itemCount: histories.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 4,
          thickness: 2,
          color: colorSecondaryOrangeLight,
        );
      },
    );
  }
}
