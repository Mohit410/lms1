import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/data/models/user_detail_response.dart';
import 'package:lms1/presentation/screens/dashboard/dashboard.dart';
import 'package:lms1/presentation/screens/dashboard/view/components/dashboard_card.dart';
import 'package:lms1/presentation/screens/dashboard/view/components/dashboard_data_tables.dart';
import 'package:lms1/presentation/screens/dashboard/view/components/logout_alert_dialog.dart';
import 'package:lms1/presentation/screens/profile/profile.dart';
import 'package:restart_app/restart_app.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardBloc _bloc;
  late UserModel? _user;
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
    _user = null;
  }

  @override
  void didChangeDependencies() {
    _bloc.add(FetchDashboardData());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Restart.restartApp();
        }
        if (state is DashboardLoaded) {
          setState(() {
            _user = state.dashboardData.user;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text('DashBoard'),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => const LogoutAlertDialog());
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.redAccent,
                ),
              ),
            ],
            leading: IconButton(
              onPressed: () {
                if (_user != null) {
                  Navigator.of(context).push(ProfilePage.route(_user!));
                }
              },
              splashRadius: 24,
              icon: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(48),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: Text(
                    _user?.name
                            .splitMapJoin(
                              RegExp(r' '),
                              onMatch: (m) => m[0]!,
                              onNonMatch: (n) => n[0],
                            )
                            .trim()
                            .replaceAll(RegExp(r' '), '') ??
                        'NA',
                    style: GoogleFonts.lato(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          body: (state is DashboardLoading)
              ? const Center(child: CircularProgressIndicator())
              : _buildBody(state),
        );
      },
    );
  }

  _buildBody(DashboardState state) {
    return RefreshIndicator(
      onRefresh: () async {
        _bloc.add(FetchDashboardData());
      },
      child: _getRefreshIndicatorChild(state),
    );
  }

  _getRefreshIndicatorChild(state) {
    if (state is DashboardLoaded) {
      if (state.dashboardData is AdminDashboardResponse) {
        _adminDashboardResponse = state.dashboardData as AdminDashboardResponse;
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: _adminCardsGridView(_adminDashboardResponse),
        );
      } else if (state.dashboardData is LibrarianDashboardResponse) {
        _librarianDashboardResponse =
            state.dashboardData as LibrarianDashboardResponse;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ExpansionPanelList.radio(
                initialOpenPanelValue: 0,
                animationDuration: const Duration(seconds: 1),
                children: [
                  ExpansionPanelRadio(
                    value: 0,
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) => const ListTile(
                      title: Text("Issued Books"),
                    ),
                    body: _buildIssuedBookListView(
                        _studentDashbaordResponse.issuedBooks),
                  ),
                  ExpansionPanelRadio(
                    value: 1,
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) => const ListTile(
                      title: Text("Transactions"),
                    ),
                    body: _buildTransactionsListView(
                        _studentDashbaordResponse.transactions),
                  ),
                  ExpansionPanelRadio(
                    value: 2,
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) => const ListTile(
                      title: Text("Fine History"),
                    ),
                    body: _buildFineExpansionListView(
                        _studentDashbaordResponse.fineHistory),
                  ),
                ],
              ),
              /* Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIssueBookList(_studentDashbaordResponse.issuedBooks),
                  const SizedBox(height: 30),
                  _buildTransactionsList(_studentDashbaordResponse.transactions),
                  const SizedBox(height: 30),
                  _buildFineList(_studentDashbaordResponse.fineHistory),
                ],
              ), */
            ),
          ),
        );
      }
    }
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          state is DashboardFailed ? Text(state.message) : Container(),
          TextButton(
            onPressed: () {
              _bloc.add(FetchDashboardData());
            },
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }

  GridView _adminCardsGridView(AdminDashboardResponse dashboardData) {
    return GridView.count(
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
      physics: const NeverScrollableScrollPhysics(),
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

  _buildIssuedBookListView(List<IssuedBookModel> books) => ListView.builder(
        shrinkWrap: true,
        cacheExtent: 100,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (context, index) => ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Book Name : ${books[index].name}",
                  overflow: TextOverflow.clip,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                "Fine : \u{20B9}${books[index].fine}",
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
          subtitle: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text('Issue Date : ${books[index].issueDate}'),
              Text('Return Date : ${books[index].returnDate}'),
            ],
          ),
        ),
      );

  _buildIssueBookExpansionTile(List<IssuedBookModel> books) => ExpansionTile(
        title: const Text('Issued Books'),
        childrenPadding: const EdgeInsets.all(16),
        initiallyExpanded: true,
        children: [
          ListView.builder(
            shrinkWrap: true,
            cacheExtent: 100,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: books.length,
            itemBuilder: (context, index) => ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Book Name : ${books[index].name}",
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Fine : \u{20B9}${books[index].fine}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
              subtitle: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text('Issue Date : ${books[index].issueDate}'),
                  Text('Return Date : ${books[index].returnDate}'),
                ],
              ),
            ),
          ),
        ],
      );

  _buildTransactionsListView(List<TransactionModel> transactions) =>
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: transactions.length,
        itemBuilder: (context, index) => ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Purpose : ${transactions[index].purpose}",
                  overflow: TextOverflow.clip,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                "Amount : \u{20B9}${transactions[index].amount}",
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
          subtitle: Text("Date : ${transactions[index].transactionDate}"),
        ),
      );

  _buildTransactionsExpansionTile(List<TransactionModel> transactions) =>
      ExpansionTile(
        title: const Text('Transactions'),
        childrenPadding: const EdgeInsets.all(16),
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (context, index) => ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Purpose : ${transactions[index].purpose}",
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Amount : \u{20B9}${transactions[index].amount}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
              subtitle: Text("Date : ${transactions[index].transactionDate}"),
            ),
          ),
        ],
      );

  _buildFineExpansionListView(List<FineHistoryModel> fines) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: fines.length,
        itemBuilder: (context, index) => ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Book Id : ${fines[index].bookId}",
                  overflow: TextOverflow.clip,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                "Fine : \u{20B9}${fines[index].fine}",
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
          subtitle: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text('Actual Return Date : ${fines[index].actualReturnDate}'),
              Text('User Return Date : ${fines[index].userReturnDate}'),
            ],
          ),
        ),
      );

  _buildFineExpansionTile(List<FineHistoryModel> fines) => ExpansionTile(
        title: const Text("Fine History"),
        childrenPadding: const EdgeInsets.all(16),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: fines.length,
            itemBuilder: (context, index) => ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Book Id : ${fines[index].bookId}",
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Fine : \u{20B9}${fines[index].fine}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
              subtitle: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text('Actual Return Date : ${fines[index].actualReturnDate}'),
                  Text('User Return Date : ${fines[index].userReturnDate}'),
                ],
              ),
            ),
          ),
        ],
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

  _getTransactionsTable() => PaginatedDataTable(
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

  _getFineHistoryTable() => PaginatedDataTable(
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

  _getIssuedBookTable() => PaginatedDataTable(
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

  _buildGreetings() {
    return [
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
                text: _user!.name,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blueAccent,
                ),
              ),
              TextSpan(
                text: " (${_user!.role.capitalize()})",
                style: GoogleFonts.ubuntu(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 20),
    ];
  }
}
