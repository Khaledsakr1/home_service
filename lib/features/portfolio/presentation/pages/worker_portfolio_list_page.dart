import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/portfolio/domain/entities/project.dart';
import 'package:home_service/features/portfolio/presentation/manager/portfolio_cubit.dart';
import 'package:home_service/features/portfolio/presentation/pages/worker_portfolio_page.dart';
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/widgets/button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class Textfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? headtextfield;
  final bool obscuretext;
  final bool readOnly;
  final TextInputType? inputType;
  final Function(String)? onchanged;
  final String? Function(String?)? validator;
  final IconData? icon;
  final int maxLines;

  const Textfield({
    Key? key,
    this.readOnly = false,
    this.controller,
    this.title,
    this.headtextfield,
    this.obscuretext = false,
    this.onchanged,
    this.inputType,
    this.validator,
    this.icon,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
        ],
        TextFormField(
          keyboardType: inputType,
          inputFormatters: inputType == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          controller: controller,
          obscureText: obscuretext,
          readOnly: readOnly,
          maxLines: maxLines,
          style: const TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
          validator: validator ??
              (data) {
                if (data == null || data.isEmpty) {
                  return 'Required Field';
                }
                return null;
              },
          onChanged: onchanged,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon, color: kPrimaryColor) : null,
            labelText: headtextfield,
            labelStyle: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              height: 1.5,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: kPrimaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: kPrimaryColor),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
          ),
        ),
      ],
    );
  }
}

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

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Edit Project",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Edit Project',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Textfield(
                      controller: nameController,
                      title: 'Project Name',
                      headtextfield: 'Enter project name',
                      icon: Icons.title,
                    ),
                    const SizedBox(height: 16),
                    Textfield(
                      controller: descriptionController,
                      title: 'Description',
                      headtextfield: 'Enter description',
                      icon: Icons.description,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildButton(
                          label: 'Cancel',
                          backgroundColor: Colors.grey.shade200,
                          textColor: Colors.black87,
                          onTap: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 12),
                        _buildButton(
                          label: 'Save',
                          backgroundColor: Colors.green.shade700,
                          textColor: Colors.white,
                          onTap: () {
                            Navigator.pop(context);
                            context.read<PortfolioCubit>().updatePortfolio(
                                  project.id,
                                  nameController.text,
                                  descriptionController.text,
                                );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            ),
            child: child,
          ),
        );
      },
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
          context.read<PortfolioCubit>().getPortfolios();
        } else if (state is PortfolioDeleted) {
          setState(() {
            isLoading = false;
          });
          showCustomOverlayMessage(context,
              message: 'Success',
              subMessage: 'Your project has been deleted successfully.');
          context.read<PortfolioCubit>().getPortfolios();
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
                      return PortfolioCard(
                        project: project,
                        index: index,
                        onEdit: () => _showEditDialog(project),
                        onDelete: () => context
                            .read<PortfolioCubit>()
                            .deletePortfolio(project.id),
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
                        },
                      ),
                      const SizedBox(height: 10),
                      Button(
                        title: 'Continue',
                        ontap: () => Navigator.pop(context),
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

class PortfolioCard extends StatelessWidget {
  final Project project;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PortfolioCard({
    super.key,
    required this.project,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              child: project.imageUrls.isNotEmpty
                  ? Image.network(
                      project.imageUrls.first,
                      width: 125,
                      height: 110,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 120,
                      height: 120,
                      color: Colors.grey[200],
                      child:
                          const Icon(Icons.image, size: 40, color: Colors.grey),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      project.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _iconButton(Icons.edit, Colors.green, onEdit),
                  const SizedBox(height: 12),
                  _iconButton(Icons.delete, Colors.red, onDelete),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

Widget _buildButton({
  required String label,
  required Color backgroundColor,
  required Color textColor,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: textColor,
          letterSpacing: 1.1,
        ),
      ),
    ),
  );
}
