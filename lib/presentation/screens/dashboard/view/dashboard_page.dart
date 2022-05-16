import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/presentation/components/widgets/loading_widget.dart';
import 'package:lms1/presentation/screens/dashboard/dashboard.dart';
import 'package:lms1/presentation/screens/dashboard/view/components/dashboard_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<DashboardBloc>(context);
  }

  @override
  void didChangeDependencies() {
    _bloc.add(FetchData());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'DashBoard',
            style: GoogleFonts.pacifico(),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        foregroundColor: AppBarColors.foregroundColor.color,
        backgroundColor: AppBarColors.backgroundColor.color,
      ),
      body: buildBody(context),
      //buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
            child: getRefreshIndicatorChild(state),
            onRefresh: () async {
              _bloc.add(FetchData());
            });
      },
    );
  }

  getRefreshIndicatorChild(state) {
    if (state is Loading) {
      return const Center(child: LoadingWidget());
    } else if (state is Empty) {
      return const Center(child: Text('Nothing to show'));
    } else if (state is Loaded) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: cardsGridView(state),
      );
    } else if (state is Failed) {
      return Center(
        child: Text(state.message),
      );
    }
    return const Text('data');
  }

  GridView cardsGridView(Loaded state) {
    return GridView.count(
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      crossAxisCount: 2,
      children: [
        DashbaordCard(
          title: 'Total Users',
          data: "${state.totalUsers}",
          svgSrc: 'assets/svgs/person.svg',
          color: const Color(0xFFA4CDFF),
        ),
        DashbaordCard(
          title: 'Total Books',
          data: "${state.totalBooks}",
          svgSrc: 'assets/svgs/book.svg',
          color: const Color.fromARGB(255, 209, 163, 180),
        ),
        DashbaordCard(
          title: 'Total Fine Collection',
          data: "Rs. ${state.totalFine}",
          svgSrc: 'assets/svgs/rupee.svg',
          color: const Color.fromARGB(255, 232, 159, 51),
        ),
      ],
    );
  }
}
