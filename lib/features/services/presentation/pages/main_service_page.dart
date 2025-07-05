import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/services/presentation/manager/services_cubit.dart';
import 'package:home_service/features/services/domain/entities/service.dart';
import 'package:home_service/features/services/presentation/pages/see_all_services_page.dart';
import 'package:home_service/features/worker_details/presentation/pages/service_details_page.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>().fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        // Search Field
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const TextField(
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: 'Find the perfect job you need',
                              prefixIcon: Icon(Icons.search, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: jobs.length,
                            itemBuilder: (context, index) {
                              final service = jobs[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ServiceDetailsPage(service: service),
                                    ),
                                  );
                                },
                                child: PopularServiceList(service.name, service.imageUrl),
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeJobs.length,
                            itemBuilder: (context, index) {
                              final service = homeJobs[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ServiceDetailsPage(service: service),
                                    ),
                                  );
                                },
                                child: HomeServicelist(service.name, service.imageUrl),
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: repair.length,
                            itemBuilder: (context, index) {
                              final service = repair[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ServiceDetailsPage(service: service),
                                    ),
                                  );
                                },
                                child: Repairandinstallationlist(service.name, service.imageUrl),
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
    );
  }
}
