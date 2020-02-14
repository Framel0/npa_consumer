import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class UpcomingRequestPage extends StatefulWidget {
  @override
  _UpcomingRequestPageState createState() => _UpcomingRequestPageState();
}

class _UpcomingRequestPageState extends State<UpcomingRequestPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();

    _refreshCompleter = Completer<void>();

    _getRequests();
  }

  _getRequests() async {
    final user = await readUserData();

    BlocProvider.of<UpcomingRequestBloc>(context)
        .dispatch(FetchUpcomingRequests(
      userId: user.id,
    ));
  }

  Future _refresh() async {
    final user = await readUserData();

    BlocProvider.of<UpcomingRequestBloc>(context)
        .dispatch(RefreshUpcomingRequest(userId: user.id));
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upcoming Orders",
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
            ),
            tooltip: 'Refresh',
            onPressed: _getRequests,
          ),
        ],
      ),
      body: BlocBuilder<UpcomingRequestBloc, UpcomingRequestState>(
          builder: (context, state) {
        if (state is UpcomingRequestLoading) {
          return Center(child: LoadingIndicator());
        }
        if (state is UpcomingRequestLoaded) {
          final upcomingRequests = state.upcomingRequests;

          _refreshCompleter?.complete();
          _refreshCompleter = Completer();

          return _buildUpcomingOrderList(upcomingRequests);
        }

        if (state is UpcomingRequestError) {
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
                onPressed: _getRequests,
              )
            ],
          );
        }
      }),
    );
  }

  Widget _buildUpcomingOrderItems(
      BuildContext context, int position, UpcomingRequest upcomingOrder) {
    return UpcomingRequestListItem(
      upcomingRequest: upcomingOrder,
    );
  }

  Widget _buildUpcomingOrderList(List<UpcomingRequest> upcomingOrders) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: upcomingOrders.isNotEmpty
            ? ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return _buildUpcomingOrderItems(
                      context, index, upcomingOrders[index]);
                },
                itemCount: upcomingOrders.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 2,
                    thickness: 2,
                    color: colorSecondaryOrangeLight,
                  );
                },
              )
            : Center(child: Text("No Upcoming Orders Available")));
  }
}
