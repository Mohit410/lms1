import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/presentation/components/widgets/loading_widget.dart';
import 'package:lms1/presentation/screens/dashboard/dashboard.dart';
import 'package:lms1/presentation/screens/dashboard/view/components/dashboard_card.dart';
import 'package:lms1/presentation/screens/dashboard/view/components/dashboard_data_tables.dart';
import 'package:lms1/presentation/screens/profile/profile.dart';
import 'package:restart_app/restart_app.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardBloc _bloc;
  late UserModel _user;
  int _isSelectedLibrarian = 0;
  late FineHistoryTable _fineHistoryTable;
  late IssuedBooksTable _issuedBooksTable;
  late TransactionsTable _transactionsTable;
  late StudentDashboardResponse _studentDashbaordResponse;
  late AdminDashboardResponse _adminDashboardResponse;
  late LibrarianDashboardResponse _librarianDashboardResponse;

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
        actions: [
          IconButton(
            onPressed: () async {
              _bloc.add(LogOutClicked());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(ProfilePage.route(_user));
          },
          icon: const Icon(
            Icons.person_outline,
            size: 28,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        foregroundColor: AppBarColors.foregroundColor.color,
        backgroundColor: AppBarColors.backgroundColor.color,
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Restart.restartApp();
        }
      },
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
        _adminDashboardResponse = state.dashboardData as AdminDashboardResponse;
        _user = _adminDashboardResponse.adminData;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    text: 'Hi!  ',
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: _adminDashboardResponse.adminData.name,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blueAccent),
                      ),
                      TextSpan(
                          text:
                              " (${_adminDashboardResponse.adminData.role.capitalize()})",
                          style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _adminCardsGridView(_adminDashboardResponse),
            ],
          ),
        );
      } else if (state.dashboardData is LibrarianDashboardResponse) {
        _librarianDashboardResponse =
            state.dashboardData as LibrarianDashboardResponse;
        _user = _librarianDashboardResponse.librarianData;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Hi!  ',
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: _librarianDashboardResponse.librarianData.name,
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blueAccent),
                        ),
                        TextSpan(
                            text:
                                " (${_librarianDashboardResponse.librarianData.role.capitalize()})",
                            style: GoogleFonts.ubuntu(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _librarianCardsGridView(_librarianDashboardResponse),
                const SizedBox(height: 30),
                _getChoiceChipsForLibrarian(),
                const SizedBox(height: 10),
                _getList(_librarianDashboardResponse),
              ],
            ),
          ),
        );
      } else if (state.dashboardData is StudentDashboardResponse) {
        _studentDashbaordResponse =
            state.dashboardData as StudentDashboardResponse;
        _user = _studentDashbaordResponse.studentData;
        _fineHistoryTable =
            FineHistoryTable(_studentDashbaordResponse.fineHistory);
        _issuedBooksTable =
            IssuedBooksTable(_studentDashbaordResponse.issuedBooks);
        _transactionsTable =
            TransactionsTable(_studentDashbaordResponse.transactions);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Hi,  ',
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                          text: _studentDashbaordResponse.studentData.name,
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blueAccent)),
                      TextSpan(
                          text:
                              " (${_studentDashbaordResponse.studentData.role.capitalize()})",
                          style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _getIssuedBookList(),
                const SizedBox(height: 30),
                _getTransactionsList(),
                const SizedBox(height: 30),
                _getFineHistory(),
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
    return const Center(
      child: CircularProgressIndicator(),
    );
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

  _getIssuedBookList() => PaginatedDataTable(
        columns: const [
          DataColumn(label: Text("Book Name")),
          DataColumn(label: Text("Author")),
          DataColumn(label: Text("Publisher")),
          DataColumn(label: Text("Category")),
          DataColumn(label: Text("Issue Date")),
          DataColumn(label: Text("Return Date")),
          DataColumn(label: Text("Fine")),
        ],
        header: const Text('Issued Books'),
        source: _issuedBooksTable,
        horizontalMargin: 10,
        rowsPerPage: _issuedBooksTable.books.isNotEmpty
            ? _issuedBooksTable.books.length > 5
                ? 5
                : _issuedBooksTable.books.length
            : 1,
        showCheckboxColumn: false,
      );

  _getTransactionsList() => PaginatedDataTable(
        columns: const [
          DataColumn(label: Text("Amount")),
          DataColumn(label: Text("Date")),
          DataColumn(label: Text("Purpose")),
        ],
        header: const Text('Transactions'),
        source: _transactionsTable,
        horizontalMargin: 10,
        rowsPerPage: _transactionsTable.transactions.isNotEmpty
            ? _transactionsTable.transactions.length > 5
                ? 5
                : _transactionsTable.transactions.length
            : 1,
        showCheckboxColumn: false,
      );

  _getFineHistory() => PaginatedDataTable(
        columns: const [
          DataColumn(label: Text("Book Id")),
          DataColumn(label: Text("Actual Return Date")),
          DataColumn(label: Text("User Return date")),
          DataColumn(label: Text("Fine")),
        ],
        header: const Text('Fine History'),
        source: _fineHistoryTable,
        horizontalMargin: 10,
        rowsPerPage: _fineHistoryTable.fineHistory.isNotEmpty
            ? _fineHistoryTable.fineHistory.length > 5
                ? 5
                : _fineHistoryTable.fineHistory.length
            : 1,
        showCheckboxColumn: false,
      );

  _getList(LibrarianDashboardResponse librarianData) {
    final unavailableBooksTable =
        UnavailableBooksTable(librarianData.unavailableBooks);
    final overdueFineBooksTable =
        OverdueFineBooksTable(librarianData.studentsHeavyFine);
    return (_isSelectedLibrarian == 0)
        ? PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("Book Id")),
              DataColumn(label: Text("Book Name")),
            ],
            header: const Text('Unavailable Books'),
            source: unavailableBooksTable,
            horizontalMargin: 10,
            columnSpacing: 120,
            rowsPerPage: unavailableBooksTable.bookList.isNotEmpty
                ? unavailableBooksTable.bookList.length > 5
                    ? 5
                    : unavailableBooksTable.bookList.length
                : PaginatedDataTable.defaultRowsPerPage,
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
            source: overdueFineBooksTable,
            horizontalMargin: 10,
            rowsPerPage: overdueFineBooksTable.fineList.isNotEmpty
                ? overdueFineBooksTable.fineList.length > 5
                    ? 5
                    : overdueFineBooksTable.fineList.length
                : PaginatedDataTable.defaultRowsPerPage,
            showCheckboxColumn: false,
          );
  }
}
