import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:listview_bloc/feature/destination/widget/app_text.dart';
import 'package:listview_bloc/feature/destination/widget/grid_item.dart';
import 'package:listview_bloc/feature/destination/widget/indicator.dart';

import '../../../core/destination/data/destination_bloc/destination_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DestinationBloc>(
      create: (_) => DestinationBloc()
        ..add(
          const DestinationFetched(),
        ),
      child: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc list view'),
      ),
      body: BlocBuilder<DestinationBloc, DestinationState>(
        builder: (context, state) {
          switch (state.status) {
            case DestinationStatus.failure:
              return Center(
                child: AppText(
                  padding: EdgeInsets.zero,
                  text: "Something went wrong",
                ),
              );
            case DestinationStatus.success:
              if (state.destinations.isEmpty) {
                return const Center(
                  child: Text("Destination not found"),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  itemCount: state.destinations.length,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  itemBuilder: (context, index) => GridItem(
                    name: state.destinations[index].name,
                    region: state.destinations[index].region,
                    photo: state.destinations[index].photoUrl[0],
                  ),
                ),
              );
            default:
              return Center(
                child: Column(
                  children: const [
                    Text("Please, wait"),
                    Indicator(),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
