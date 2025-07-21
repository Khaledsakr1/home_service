import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/features/client_project/domain/entities/client_project.dart';
import 'package:home_service/features/client_project/presentation/manager/client_project_cubit.dart';
import 'package:home_service/features/services/domain/entities/service.dart';
import 'package:home_service/features/services/presentation/manager/services_cubit.dart';
import 'package:home_service/widgets/DetailsInput.dart';
import 'package:home_service/widgets/ImagePicker.dart';
import 'package:home_service/widgets/Optiontile.dart';
import 'package:home_service/widgets/Optiontile1.dart';
import 'package:home_service/widgets/Optiontile2.dart';
import 'package:home_service/widgets/Optiontile3.dart';
import 'package:home_service/widgets/TextField2.dart';
import 'package:home_service/widgets/button.dart';
import 'package:image_picker/image_picker.dart';

class Startnewproject extends StatefulWidget {
  final ClientProject? project; // Add this parameter for editing

  const Startnewproject({Key? key, this.project}) : super(key: key);

  @override
  _NewProjectScreenState createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<Startnewproject> {
  // State variables
  String? _serviceName;
  int? _serviceId;
  String? _apartmentType;
  String? _apartmentSize;
  String? _preferredStyle;
  String? _materialQuality;
  String? _location;

  List<File> _selectedImages = [];
  List<ProjectImage> _existingProjectImages = [];
  List<int> _imagesToDelete = [];

  // UI controls
  bool _isServiceVisible = false;
  bool _isApartmentVisible = false;
  bool _isPreferredvisible = false;
  bool _isMaterialQualityvisible = false;
  bool _isLocationvisible = false;

  List<Service> _services = [];
  bool _isEditMode = false;

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  // Validation errors
  final Map<String, String?> _errors = {};

  // Services for which apartment, style, material fields are required
  final Set<String> _detailedRequiredServices = {
    'Apartment Finishing',
    'Interior Design',
    'House Cleaning',
  };

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.project != null;
    context.read<ServicesCubit>().fetchServices();

    if (_isEditMode) {
      _populateFieldsFromProject();
    }
  }

  void _populateFieldsFromProject() {
    final project = widget.project!;

    // Populate text fields
    _nameController.text = project.name;
    _detailsController.text = project.details;
    _minPriceController.text = project.minBudget.toString();
    _maxPriceController.text = project.maxBudget.toString();

    // Populate dropdown selections
    _serviceName = project.serviceName;
    _serviceId = project.serviceId;
    _apartmentType =
        project.apartmentType.isNotEmpty ? project.apartmentType : null;
    _apartmentSize =
        project.apartmentSize.isNotEmpty ? project.apartmentSize : null;
    _preferredStyle =
        project.preferredStyle.isNotEmpty ? project.preferredStyle : null;
    _materialQuality =
        project.materialQuality.isNotEmpty ? project.materialQuality : null;

    // Populate existing images
    _existingProjectImages = List.from(project.projectImages);
    _selectedImages = [];
  }

  int? _findServiceIdByName(String name) {
    try {
      return _services.firstWhere((s) => s.name == name).id;
    } catch (e) {
      return null;
    }
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) return File(pickedFile.path);
    return null;
  }

  bool get _shouldShowApartmentFields =>
      _serviceName != null && _detailedRequiredServices.contains(_serviceName);

  void _submit() {
    setState(() {
      _errors.clear();

      if (_nameController.text.trim().isEmpty) {
        _errors['name'] = "Project name is required";
      }
      if (_serviceName == null) {
        _errors['service'] = "Service is required";
      }
      if (_detailsController.text.trim().isEmpty) {
        _errors['desc'] = "Description is required";
      }
      if (_minPriceController.text.trim().isEmpty) {
        _errors['min'] = "Min price is required";
      }
      if (_maxPriceController.text.trim().isEmpty) {
        _errors['max'] = "Max price is required";
      }
      double? min = double.tryParse(_minPriceController.text);
      double? max = double.tryParse(_maxPriceController.text);
      if (min != null && max != null && min > max) {
        _errors['min'] = "Min must be ≤ Max";
        _errors['max'] = "Max must be ≥ Min";
      }
      if (_shouldShowApartmentFields) {
        if (_apartmentType == null || _apartmentType!.isEmpty) {
          _errors['apartmentType'] = "Required";
        }
        if (_preferredStyle == null || _preferredStyle!.isEmpty) {
          _errors['style'] = "Required";
        }
        if (_materialQuality == null || _materialQuality!.isEmpty) {
          _errors['material'] = "Required";
        }
      }
    });

    if (_errors.isNotEmpty) return;

    final data = {
      "name": _nameController.text.trim(),
      "serviceId": _serviceId,
      "serviceName": _serviceName ?? '',
      "apartmentType": _apartmentType ?? '',
      "apartmentSize": _apartmentSize ?? '',
      "preferredStyle": _preferredStyle ?? '',
      "materialQuality": _materialQuality ?? '',
      "minBudget": double.tryParse(_minPriceController.text),
      "maxBudget": double.tryParse(_maxPriceController.text),
      "details": _detailsController.text.trim(),
      "location": _location ?? '',
    };

    if (_isEditMode) {
      // Update existing project
      context
          .read<ClientProjectCubit>()
          .updateProject(widget.project!.id, data);

      // Delete images
      if (_imagesToDelete.isNotEmpty) {
        for (var imageId in _imagesToDelete) {
          context
              .read<ClientProjectCubit>()
              .deleteProjectImage(widget.project!.id, imageId);
        }
        _imagesToDelete.clear();
      }

      // Handle new images if any
      if (_selectedImages.isNotEmpty) {
        context
            .read<ClientProjectCubit>()
            .addProjectImages(widget.project!.id, _selectedImages);
      }
    } else {
      // Create new project
      context.read<ClientProjectCubit>().addProject(data, _selectedImages);
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Project',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to delete "${widget.project!.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to projects list
              context
                  .read<ClientProjectCubit>()
                  .deleteProject(widget.project!.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClientProjectCubit, ClientProjectState>(
      listener: (context, state) {
        if (state is ClientProjectActionSuccess) {
          showCustomOverlayMessage(context,
              message: 'Success',
              subMessage: _isEditMode
                  ? 'Your project updated successfully!'
                  : 'Your project added successfully!');
          Navigator.pop(context);
        } else if (state is ClientProjectError) {
          showErrorOverlayMessage(context,
              errorMessage: 'Error', subMessage: state.message);
        }
      },
      child: BlocListener<ServicesCubit, ServicesState>(
        listener: (context, state) {
          if (state is ServicesLoaded) {
            setState(() {
              _services = state.services;
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              _isEditMode ? "Edit Project" : "Start a New Project",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            leading: const BackButton(color: Colors.green),
            centerTitle: true,
            actions: _isEditMode
                ? [
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: _showDeleteConfirmation,
                    ),
                  ]
                : null,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (!_isEditMode)
                  Image.asset("assets/images/Attached files.png", height: 200),
                if (!_isEditMode) const SizedBox(height: 16),

                // Project name input
                Textfield2(
                  hint: 'Project name',
                  controller: _nameController,
                  errorText: _errors['name'],
                ),
                const SizedBox(height: 10),

                // Type of service
                OptionTile(
                  title: 'Type of service',
                  subtitle: _serviceName ?? "No service selected",
                  errorText: _errors['service'],
                  onTap: () {
                    setState(() => _isServiceVisible = !_isServiceVisible);
                  },
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _isServiceVisible
                      ? Optiontile1(
                          title: 'Type of service',
                          options: _services.map((s) => s.name).toList(),
                          closeOnSelect: true,
                          onSelected: (value, _) {
                            setState(() {
                              _serviceName = value;
                              _serviceId = _findServiceIdByName(value);
                              _isServiceVisible = false;
                              // Clear dependent fields and errors
                              if (!_isEditMode) {
                                _apartmentType = null;
                                _preferredStyle = null;
                                _materialQuality = null;
                              }
                              _errors.remove('apartmentType');
                              _errors.remove('style');
                              _errors.remove('material');
                            });
                          },
                        )
                      : const SizedBox.shrink(),
                ),

                // Apartment type & size (only for certain services)
                if (_shouldShowApartmentFields) ...[
                  OptionTile(
                    title: 'Apartment type & size',
                    subtitle: _apartmentType != null && _apartmentSize != null
                        ? '$_apartmentType - $_apartmentSize m²'
                        : "No type selected",
                    errorText: _errors['apartmentType'],
                    onTap: () {
                      setState(
                          () => _isApartmentVisible = !_isApartmentVisible);
                    },
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: _isApartmentVisible
                        ? Optiontile1(
                            title: 'Apartment type & size',
                            options: const [
                              'Commercial stores',
                              'Villa',
                              'House',
                              'Gym',
                            ],
                            onSelected: (type, size) {
                              setState(() {
                                _apartmentType = type;
                                _apartmentSize =
                                    size; // this is the size (entered by user)
                                _isApartmentVisible =
                                    false; // closes the expansion after selection
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                ],

                // Preferred style (only for certain services)
                if (_shouldShowApartmentFields) ...[
                  OptionTile(
                    title: 'Preferred style',
                    subtitle: _preferredStyle ?? "No type selected",
                    errorText: _errors['style'],
                    onTap: () {
                      setState(
                          () => _isPreferredvisible = !_isPreferredvisible);
                    },
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: _isPreferredvisible
                        ? Optiontile2(
                            title: 'Preferred style',
                            options: const [
                              'Modern',
                              'Traditional',
                              'Minimalist',
                              'Industrial',
                              'Eclectic',
                            ],
                            onSelected: (value) {
                              setState(() {
                                _preferredStyle = value;
                                _isPreferredvisible = false;
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                ],

                // Material quality (only for certain services)
                if (_shouldShowApartmentFields) ...[
                  OptionTile(
                    title: 'Material quality',
                    subtitle: _materialQuality ?? "No type selected",
                    errorText: _errors['material'],
                    onTap: () {
                      setState(() => _isMaterialQualityvisible =
                          !_isMaterialQualityvisible);
                    },
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: _isMaterialQualityvisible
                        ? Optiontile2(
                            title: 'Material quality',
                            options: const [
                              'High quality',
                              'Average quality',
                              'Low quality',
                            ],
                            onSelected: (value) {
                              setState(() {
                                _materialQuality = value;
                                _isMaterialQualityvisible = false;
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                ],

                const SizedBox(height: 20),

                // Min and Max Budget (required)
                Row(
                  children: [
                    Expanded(
                      child: Textfield2(
                        hint: 'Min Price',
                        controller: _minPriceController,
                        errorText: _errors['min'],
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Textfield2(
                        hint: 'Max Price',
                        controller: _maxPriceController,
                        errorText: _errors['max'],
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Location picker
                OptionTile(
                  title: 'Location',
                  subtitle: _location ?? "No location selected",
                  onTap: () {
                    setState(() => _isLocationvisible = !_isLocationvisible);
                  },
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: _isLocationvisible
                      ? Optiontile3(
                          onSelected: (val) {
                            setState(() {
                              _location = val;
                              _isLocationvisible = false;
                            });
                          },
                        )
                      : const SizedBox.shrink(),
                ),

                const SizedBox(height: 10),

                // Images with enhanced handling for edit mode
                ImagePickerWidget(
                  images: _selectedImages.map((file) => file.path).toList(),
                  networkImages:
                      _existingProjectImages.map((e) => e.imageUrl).toList(),
                  onAddImage: () async {
                    final file = await pickImage();
                    if (file != null) {
                      setState(() {
                        _selectedImages.add(file);
                      });
                    }
                  },
                  onRemoveImage: (index) {
                    setState(() {
                      _selectedImages.removeAt(index);
                    });
                  },
                  onRemoveNetworkImage: (index) {
                    setState(() {
                      _imagesToDelete.add(_existingProjectImages[index].id);
                      _existingProjectImages.removeAt(index);
                    });
                  },
                ),

                const SizedBox(height: 10),

                // Details input
                DetailsInput(
                  controller: _detailsController,
                  errorText: _errors['desc'],
                ),

                const SizedBox(height: 20),

                // Submit button
                BlocBuilder<ClientProjectCubit, ClientProjectState>(
                  builder: (context, state) {
                    bool loading = state is ClientProjectLoading;
                    return SizedBox(
                      width: double.infinity,
                      child: Button(
                        ontap: loading ? null : _submit,
                        title: loading
                            ? 'Saving...'
                            : _isEditMode
                                ? 'Update Project'
                                : 'Create Project',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }
}
