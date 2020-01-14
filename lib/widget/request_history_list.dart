import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/widget/widgets.dart';

class RequestHistoryList extends StatefulWidget {
  @override
  _RequestHistoryListState createState() => _RequestHistoryListState();
}

class _RequestHistoryListState extends State<RequestHistoryList> {
  @override
  void initState() {
    super.initState();

    getRequestHistory();
  }

  getRequestHistory() async {
    final user = await readUserData();

    BlocProvider.of<RefillRequestHistoryBloc>(context)
        .dispatch(FetchRefillRequestHistory(userId: user.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefillRequestHistoryBloc, RefillRequestHistoryState>(
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
        return Container();
      }
    });
  }

  Widget _buildHistoryItems(
      BuildContext context, int position, RequestHistory history) {
    return RequestHistoryListItem(history);
  }

  Widget _buildHistoryList(List<RequestHistory> histories) {
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
        );
      },
    );
  }
}
