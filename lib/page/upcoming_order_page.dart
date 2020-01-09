import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npa_user/bloc/blocs.dart';
import 'package:npa_user/data/consumer_info.dart';
import 'package:npa_user/model/models.dart';
import 'package:npa_user/values/color.dart';
import 'package:npa_user/widget/widgets.dart';

class UpcomingOrderPage extends StatefulWidget {
  @override
  _UpcomingOrderPageState createState() => _UpcomingOrderPageState();
}

class _UpcomingOrderPageState extends State<UpcomingOrderPage> {
  @override
  void initState() {
    super.initState();

    getRequests();
  }

  getRequests() async {
    final user = await readUserData();

    BlocProvider.of<UpcomingRequestBloc>(context)
        .dispatch(FetchUpcomingRequests(userId: user.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upcoming Orders")),
      body: BlocBuilder<UpcomingRequestBloc, UpcomingRequestState>(
          builder: (context, state) {
        if (state is UpcomingRequestLoading) {
          return Center(child: LoadingIndicator());
        }
        if (state is UpcomingRequestLoaded) {
          final upcomingRequests = state.upcomingRequests;

          if (upcomingRequests.isEmpty) {
            return Center(child: Text("No Upcoming Orders Available"));
          } else {
            return _buildUpcomingOrderList(upcomingRequests);
          }
        }

        if (state is UpcomingRequestError) {
          return Container();
        }
      }),
    );
  }

  Widget _buildUpcomingOrderItems(
      BuildContext context, int position, UpcomingRequest upcomingOrder) {
    return UpcomingOrderListItem(
      upcomingRequest: upcomingOrder,
    );
  }

  Widget _buildUpcomingOrderList(List<UpcomingRequest> upcomingOrders) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      itemBuilder: (BuildContext context, int index) {
        return _buildUpcomingOrderItems(context, index, upcomingOrders[index]);
      },
      itemCount: upcomingOrders.length,
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
