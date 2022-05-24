import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/presentation/components/widgets/loading_widget.dart';
import 'package:lms1/presentation/screens/dashboard/dashboard.dart';
import 'package:lms1/presentation/screens/dashboard/view/components/dashboard_card.dart';
import 'package:lms1/presentation/screens/dashboard/view/components/dashboard_data_tables.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardBloc _bloc;
  int _isSelectedLibrarian = 0;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<DashboardBloc>(context);
  }

  @override
  void didChangeDependencies() {
    _bloc.add(FetchDashboardData());
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
              _bloc.add(FetchDashboardData());
            });
      },
    );
  }

  getRefreshIndicatorChild(state) {
    if (state is DashboardLoading) {
      return const Center(child: LoadingWidget());
    } else if (state is DashboardEmpty) {
      return const Center(child: Text('Nothing to show'));
    } else if (state is DashboardLoaded) {
      if (state.dashboardData is AdminDashboardResponse) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: _adminCardsGridView(
              state.dashboardData as AdminDashboardResponse),
        );
      } else if (state.dashboardData is LibrarianDashboardResponse) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _librarianCardsGridView(
                    state.dashboardData as LibrarianDashboardResponse),
                const SizedBox(height: 30),
                _getChoiceChipsForLibrarian(),
                const SizedBox(height: 10),
                _getList(state.dashboardData as LibrarianDashboardResponse),
              ],
            ),
          ),
        );
      }
    } else if (state is DashboardFailed) {
      return Center(
        child: Text(state.message),
      );
    }
    return const Text('data');
  }

  GridView _adminCardsGridView(AdminDashboardResponse dashboardData) {
    return GridView.count(
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        DashbaordCard(
          title: 'Total Users',
          data: "${dashboardData.totalUsers}",
          svgSrc: 'assets/svgs/person.svg',
          color: const Color(0xFFA4CDFF),
        ),
        DashbaordCard(
          title: 'Total Books',
          data: "${dashboardData.totalBooks}",
          svgSrc: 'assets/svgs/book.svg',
          color: const Color.fromARGB(255, 209, 163, 180),
        ),
        DashbaordCard(
          title: 'Total Fine Collection',
          data: "Rs. ${dashboardData.totalFineCollection}",
          svgSrc: 'assets/svgs/rupee.svg',
          color: const Color.fromARGB(255, 232, 159, 51),
        ),
      ],
    );
  }

  GridView _librarianCardsGridView(LibrarianDashboardResponse dashboardData) {
    return GridView.count(
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        DashbaordCard(
          title: 'Total Students',
          data: "${dashboardData.totalStudents}",
          svgSrc: 'assets/svgs/person.svg',
          color: const Color(0xFFA4CDFF),
        ),
        DashbaordCard(
          title: 'Total Books',
          data: "${dashboardData.totalBooks}",
          svgSrc: 'assets/svgs/book.svg',
          color: const Color.fromARGB(255, 209, 163, 180),
        ),
      ],
    );
  }

  _getChoiceChipsForLibrarian() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChoiceChip(
          label: const Text('Unavailable Books'),
          selected: _isSelectedLibrarian == 0,
          onSelected: (value) => setState(() => _isSelectedLibrarian = 0),
        ),
        ChoiceChip(
          label: const Text('Overdue Fines'),
          selected: _isSelectedLibrarian == 1,
          onSelected: (value) => setState(() => _isSelectedLibrarian = 1),
        ),
      ],
    );
  }

  _getList(LibrarianDashboardResponse librarianData) {
    return (_isSelectedLibrarian == 0)
        ? PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("Book Id")),
              DataColumn(label: Text("Book Name")),
            ],
            header: const Text('Unavailable Books'),
            source: UnavailableBooksTable(librarianData.unavailableBooks),
            horizontalMargin: 10,
            columnSpacing: 120,
            rowsPerPage: 5,
            showCheckboxColumn: false,
          )
        : PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("Email")),
              DataColumn(
                  label: Text(
                "Fine",
                style: TextStyle(color: Colors.red),
              )),
            ],
            arrowHeadColor: Colors.teal,
            sortColumnIndex: 1,
            header: const Text('Overdue Fines'),
            source: OverdueFineBooksTable(librarianData.studentsHeavyFine),
            horizontalMargin: 10,
            rowsPerPage: 5,
            showCheckboxColumn: false,
          );
  }
}
