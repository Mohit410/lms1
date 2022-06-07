import 'package:flutter/material.dart';
import 'package:lms1/core/utils/constants.dart';
import 'package:lms1/core/utils/user_preferences.dart';
import 'package:lms1/presentation/components/widgets/custom_shimmer.dart';

const shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class DashboardShimmer extends StatefulWidget {
  const DashboardShimmer({Key? key}) : super(key: key);

  @override
  State<DashboardShimmer> createState() => _DashboardShimmerState();
}

class _DashboardShimmerState extends State<DashboardShimmer> {
  @override
  Widget build(BuildContext context) {
    final shimmer = Shimmer.of(context)!;
    if (!shimmer.isSized) {
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return Shimmer(
      linearGradient: shimmerGradient,
      child: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) {
          return shimmerGradient.createShader(
            Rect.fromLTWH(
              -offsetWithinShimmer.dx,
              -offsetWithinShimmer.dy,
              shimmerSize.width,
              shimmerSize.height,
            ),
          );
        },
        child: _getShimmerFromRole(),
      ),
    );
  }

  Widget _getShimmerFromRole() {
    if (UserPreferences.userRole == Role.admin.name) {
      return const AdminDashboardShimmer();
    } else if (UserPreferences.userRole == Role.librarian.name) {
      return const LibrarianDashboardShimmer();
    } else if (UserPreferences.userRole == Role.student.name) {
      return const StudentDashboardShimmer();
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class AdminDashboardShimmer extends StatelessWidget {
  const AdminDashboardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        crossAxisCount: 2,
        children: const [
          CardGridItem(),
          CardGridItem(),
          CardGridItem(),
        ],
      ),
    );
  }
}

class LibrarianDashboardShimmer extends StatelessWidget {
  const LibrarianDashboardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            crossAxisCount: 2,
            children: const [
              CardGridItem(),
              CardGridItem(),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 26,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              Container(
                height: 26,
                width: 110,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 28,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ..._getTableRow(),
                ..._getTableRow(),
                ..._getTableRow(),
                ..._getTableRow(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _getTableRow() => [
        Row(
          children: [
            Container(
              height: 14,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            const Spacer(),
            Container(
              height: 14,
              width: 130,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 15),
        const Divider(height: 1),
        const SizedBox(height: 15),
      ];
}

class StudentDashboardShimmer extends StatelessWidget {
  const StudentDashboardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ..._buildExpansionTile(),
            ..._buildListView(),
            ..._buildExpansionTile(),
            ..._buildExpansionTile(),
          ],
        ),
      ),
    );
  }

  _buildExpansionTile() => [
        const Divider(
          height: 1.5,
          color: Colors.black,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 16,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              height: 16,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
      ];

  _buildListView() => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
          title: Container(
            width: 100,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        itemCount: 7,
      );
}

class CardGridItem extends StatelessWidget {
  const CardGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Container(
            width: 100,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 50,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      ),
    );
  }
}
