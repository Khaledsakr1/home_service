import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/services/presentation/manager/services_cubit.dart';
import 'package:home_service/features/services/domain/entities/service.dart';
import 'package:home_service/features/services/presentation/pages/see_all_services_page.dart';
import 'package:home_service/features/worker_details/domain/usecases/get_worker_by_id.dart';
import 'package:home_service/features/worker_details/presentation/pages/service_details_page.dart';
import 'package:home_service/features/worker_search/presentation/manager/worker_search_cubit.dart';
import 'package:home_service/features/worker_search/presentation/pages/worker_search_page.dart';
import 'package:home_service/injection_container.dart';
import 'package:home_service/widgets/PopularServicelist.dart';
import 'package:home_service/widgets/HomeServicelist.dart';
import 'package:home_service/widgets/RepairandInstallationlist.dart';
import 'package:home_service/widgets/TitleWithSeeAll.dart';

class MainServicePage extends StatefulWidget {
  const MainServicePage({super.key});
  static String id = 'home page for worker';

  @override
  State<MainServicePage> createState() => _MainServicePageState();
}

class _MainServicePageState extends State<MainServicePage> {
  final Map<String, String> serviceCategoryMap = {
    'House Cleaning': 'Jobs',
    'Electrical': 'Jobs',
    'Furniture Moving': 'Jobs',
    'Water Filter': 'Jobs',
    'Pest Control': 'Jobs',
    'Apartment Finishing': 'Home Jobs',
    'Door Carpenter': 'Home Jobs',
    'Interior Design': 'Home Jobs',
    'Air Conditioning Maintenance And Installation': 'Repair and Installation',
    'Installing Surveillance Cameras': 'Repair and Installation',
    'Plumbing Establishment': 'Repair and Installation',
  };

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>().fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<GetWorkerById>(
      create: (_) => sl<GetWorkerById>(),
      child: BlocProvider(
        create: (_) => sl<WorkerSearchCubit>(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<ServicesCubit, ServicesState>(
            builder: (context, state) {
              if (state is ServicesLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
              }

              if (state is ServicesLoaded) {
                final allServices = state.services;
                List<Service> jobs = allServices
                    .where((s) => serviceCategoryMap[s.name] == 'Jobs')
                    .toList();
                List<Service> homeJobs = allServices
                    .where((s) => serviceCategoryMap[s.name] == 'Home Jobs')
                    .toList();
                List<Service> repair = allServices
                    .where((s) =>
                        serviceCategoryMap[s.name] == 'Repair and Installation')
                    .toList();

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      expandedHeight: 85,
                      floating: true,
                      snap: true,
                      pinned: false,
                      centerTitle: true,
                      elevation: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        titlePadding: const EdgeInsets.only(bottom: 4),
                        title: Image.asset(
                          'assets/images/logo native.jpg',
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 1, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      onChanged: (value) {
                                        setState(
                                            () {}); // triggers rebuild to update icon
                                      },
                                      onSubmitted: (value) {
                                        if (value.trim().isNotEmpty) {
                                          context
                                              .read<WorkerSearchCubit>()
                                              .search(value);
                                          FocusScope.of(context)
                                              .unfocus(); // hide keyboard
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        hintText:
                                            'Find the perfect job you need',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                      ),
                                    ),
                                  ),
                                  // --- This is the conditional icon! ---
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 150),
                                    transitionBuilder: (child, anim) =>
                                        ScaleTransition(
                                            scale: anim, child: child),
                                    child: _searchController.text.isEmpty
                                        ? IconButton(
                                            key: const ValueKey('search'),
                                            icon: const Icon(Icons.search,
                                                color: Colors.grey),
                                            onPressed: () {
                                              final query =
                                                  _searchController.text;
                                              if (query.trim().isNotEmpty) {
                                                context
                                                    .read<WorkerSearchCubit>()
                                                    .search(query);
                                                FocusScope.of(context)
                                                    .unfocus();
                                              }
                                            },
                                          )
                                        : IconButton(
                                            key: const ValueKey('clear'),
                                            icon: const Icon(Icons.clear,
                                                color: Colors.grey),
                                            onPressed: () {
                                              _searchController.clear();
                                              FocusScope.of(context).unfocus();
                                              setState(() {}); // Update UI
                                              context
                                                  .read<WorkerSearchCubit>()
                                                  .clear(); // hide results
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),

                            BlocBuilder<WorkerSearchCubit, WorkerSearchState>(
                              builder: (context, state) {
                                if (state is WorkerSearchLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: kPrimaryColor,
                                  ));
                                } else if (state is WorkerSearchError) {
                                  return Text(state.message,
                                      style:
                                          const TextStyle(color: Colors.red));
                                } else if (state is WorkerSearchLoaded) {
                                  final workerIds = state.workerIds;
                                  return SizedBox(
                                    height: 300,
                                    child: WorkerSearchResultsList(
                                        workerIds: workerIds),
                                  );
                                }
                                // Initial state: don't show results list!
                                return const SizedBox.shrink();
                              },
                            ),

                            // Jobs Section
                            TitleWithSeeAll(
                              title: 'Jobs',
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeeallServicepage(
                                      pageTitle: 'Jobs',
                                      services: jobs,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 120,
                              child: jobs.isEmpty
                                  ? Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 20),
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.grey[50]!,
                                            Colors.grey[100]!
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: Colors.grey[300]!,
                                            width: 1.5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.work_off_outlined,
                                            size: 32,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'No Jobs Available',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Check back later for new opportunities',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: jobs.length,
                                      itemBuilder: (context, index) {
                                        final service = jobs[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ServiceDetailsPage(
                                                        service: service),
                                              ),
                                            );
                                          },
                                          child: PopularServiceList(
                                              service.name, service.imageUrl),
                                        );
                                      },
                                    ),
                            ),

                            // Home Jobs Section
                            TitleWithSeeAll(
                              title: 'Home Jobs',
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeeallServicepage(
                                      pageTitle: 'Home Jobs',
                                      services: homeJobs,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 200,
                              child: homeJobs.isEmpty
                                  ? Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 20),
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.grey[50]!,
                                            Colors.grey[100]!
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: Colors.grey[300]!,
                                            width: 1.5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.home_repair_service_outlined,
                                            size: 32,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'No Home Jobs Available',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Check back later for new opportunities',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeJobs.length,
                                      itemBuilder: (context, index) {
                                        final service = homeJobs[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ServiceDetailsPage(
                                                        service: service),
                                              ),
                                            );
                                          },
                                          child: HomeServicelist(
                                              service.name, service.imageUrl),
                                        );
                                      },
                                    ),
                            ),

                            // Repair Section
                            TitleWithSeeAll(
                              title: 'Repair and Installation',
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeeallServicepage(
                                      pageTitle: 'Repair and Installation',
                                      services: repair,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 230,
                              child: repair.isEmpty
                                  ? Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 20),
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.grey[50]!,
                                            Colors.grey[100]!
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: Colors.grey[300]!,
                                            width: 1.5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.build_outlined,
                                            size: 32,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'No Repair Services Available',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Check back later for new opportunities',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: repair.length,
                                      itemBuilder: (context, index) {
                                        final service = repair[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ServiceDetailsPage(
                                                        service: service),
                                              ),
                                            );
                                          },
                                          child: Repairandinstallationlist(
                                              service.name, service.imageUrl),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (state is ServicesError) {
                return Center(child: Text(state.message));
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
