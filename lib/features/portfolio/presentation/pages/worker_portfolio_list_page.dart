import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/portfolio/domain/entities/project.dart';
import 'package:home_service/features/portfolio/presentation/manager/portfolio_cubit.dart';
import 'package:home_service/features/portfolio/presentation/pages/worker_portfolio_page.dart';
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/widgets/button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PortfolioListPage extends StatefulWidget {
  const PortfolioListPage({super.key});
  static const String id = 'portfolioListPage';

  @override
  State<PortfolioListPage> createState() => _PortfolioListPageState();
}

class _PortfolioListPageState extends State<PortfolioListPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<PortfolioCubit>().getPortfolios();
  }

  void _showEditDialog(Project project) {
    final nameController = TextEditingController(text: project.name);
    final descriptionController =
        TextEditingController(text: project.description);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Project'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Project Name')),
            TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              context.read<PortfolioCubit>().updatePortfolio(
                    project.id,
                    nameController.text,
                    descriptionController.text,
                  );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PortfolioCubit, PortfolioState>(
      listener: (context, state) {
        if (state is PortfolioLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is PortfolioLoaded) {
          setState(() {
            isLoading = false;
          });
        } else if (state is PortfolioError) {
          setState(() {
            isLoading = false;
          });
          showErrorOverlayMessage(context, errorMessage: state.message);
        } else if (state is PortfolioUpdated) {
          setState(() {
            isLoading = false;
          });
          showCustomOverlayMessage(context,
              message: 'Success',
              subMessage: 'Your project has been updated successfully.');
          context
              .read<PortfolioCubit>()
              .getPortfolios(); // Reload projects after successful action
        } else if (state is PortfolioDeleted) {
          setState(() {
            isLoading = false;
          });
          showCustomOverlayMessage(context,
              message: 'Success',
              subMessage: 'Your project has been deleted successfully.');
          context
              .read<PortfolioCubit>()
              .getPortfolios(); // Reload projects after successful action
        }
      },
      builder: (context, state) {
        List<Project> projects = [];
        if (state is PortfolioLoaded) {
          projects = state.portfolios;
        }
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Your Projects',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: kPrimaryColor,
              elevation: 0,
              leading: const BackButton(color: Colors.white),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Text(project.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(project.description),
                          leading: project.imageUrls.isNotEmpty
                              ? Image.network(project.imageUrls.first,
                                  width: 50, height: 50, fit: BoxFit.cover)
                              : const Icon(Icons.image,
                                  size: 50, color: Colors.grey),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showEditDialog(project),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => context
                                    .read<PortfolioCubit>()
                                    .deletePortfolio(project.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Button(
                          title: 'Add another project',
                          ontap: () async {
                            final result = await Navigator.pushNamed(
                                context, PortfolioPage.id);
                            if (result == true) {
                              context.read<PortfolioCubit>().getPortfolios();
                            }
                          }),
                      const SizedBox(height: 10),
                      Button(
                        title: 'Continue',
                        ontap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
