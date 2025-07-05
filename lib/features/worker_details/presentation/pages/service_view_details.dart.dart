// lib/features/worker_details/presentation/pages/service_view_details.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/features/client_project/presentation/pages/project_list_page.dart';
import 'package:home_service/features/requests/presentation/manager/request_cubit.dart';
import 'package:home_service/features/requests/presentation/manager/request_state.dart';
import 'package:home_service/features/worker_details/domain/entities/worker.dart';
import 'package:home_service/features/worker_details/presentation/manager/worker_cubit.dart';
import 'package:home_service/features/worker_details/presentation/manager/worker_state.dart';
import 'package:home_service/features/worker_details/presentation/widgets/confirmation_dialog.dart';
import 'package:home_service/features/worker_details/presentation/widgets/section_divider.dart';
import 'package:home_service/features/worker_details/presentation/widgets/section_title.dart';
import 'package:home_service/features/worker_details/presentation/widgets/tab_selector.dart';
import 'package:home_service/features/worker_details/presentation/widgets/worker_action_buttons.dart';
import 'package:home_service/features/worker_details/presentation/widgets/worker_highlights.dart';
import 'package:home_service/features/worker_details/presentation/widgets/worker_portfolio_section.dart';
import 'package:home_service/features/worker_details/presentation/widgets/worker_profile_header.dart';
import 'package:home_service/features/worker_details/presentation/widgets/worker_reviews_section.dart';
import 'package:home_service/injection_container.dart' as di;
import 'package:jwt_decoder/jwt_decoder.dart';

class Serviceviewdetails extends StatefulWidget {
  static const routeName = '/serviceviewdetails';
  final int? workerId;
  final String? requestStatus;
  final int? requestId;
  final bool formRequsted;

  const Serviceviewdetails({
    Key? key,
    this.workerId,
    this.requestStatus,
    this.requestId,
    this.formRequsted = false,
  }) : super(key: key);

  @override
  State<Serviceviewdetails> createState() => _ServiceviewdetailsState();
}

class _ServiceviewdetailsState extends State<Serviceviewdetails> {
  final scrollController = ScrollController();
  final aboutKey = GlobalKey();
  final photosKey = GlobalKey();
  final reviewsKey = GlobalKey();

  int selectedTab = 0;
  bool _fetched = false;
  String? _userType;

  int? _sentRequestId;
  bool _requestPending = false;
  bool _requestLoading = false;
  String? _currentRequestStatus;

  @override
  void initState() {
    super.initState();
    _currentRequestStatus = widget.requestStatus?.toLowerCase();
    _sentRequestId = widget.requestId;

    // Set initial request pending state based on status
    if (widget.formRequsted && _currentRequestStatus == 'pending') {
      _requestPending = true;
    }

    // Decode user type from JWT token
    final token = di.sl<TokenService>().token;
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      _userType = decodedToken[
          'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_fetched && widget.workerId != null) {
      context.read<WorkerCubit>().fetchWorker(widget.workerId!);
      _fetched = true;
    }
  }

  void scrollTo(GlobalKey key, int tabIndex) {
    setState(() {
      selectedTab = tabIndex;
    });
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSendRequestPressed() async {
    setState(() => _requestLoading = true);

    final selectedProjectId = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProjectsListPage(pickMode: true)),
    );

    if (selectedProjectId != null && widget.workerId != null) {
      context
          .read<RequestCubit>()
          .sendRequest(widget.workerId!, selectedProjectId);
    } else {
      setState(() => _requestLoading = false);
    }
  }

  void _onCancelRequestPressed() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const ConfirmationDialog(
        title: 'Cancel Request',
        content:
            'Are you sure you want to cancel this request? This action cannot be undone.',
        confirmText: 'Cancel Request',
        cancelText: 'Keep Request',
        isDestructive: true,
      ),
    );

    if (confirmed == true) {
      setState(() => _requestLoading = true);
      final requestId = _sentRequestId ?? widget.requestId;
      if (requestId != null) {
        context.read<RequestCubit>().cancelRequest(requestId);
      }
    }
  }

  void _onFinishPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Finish functionality coming soon!')),
    );
  }

  void _onMessagePressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Messaging feature coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestCubit, RequestState>(
      listener: (context, state) {
        setState(() => _requestLoading = false);

        if (state is RequestSent) {
          setState(() {
            _sentRequestId = state.request.id;
            _requestPending = true;
            _currentRequestStatus = 'pending';
          });
          showCustomOverlayMessage(context,
              message: "Request sent successfully!");
        } else if (state is RequestCancelled) {
          setState(() {
            _sentRequestId = null;
            _requestPending = false;
            _currentRequestStatus = 'cancelled';
          });
          showCustomOverlayMessage(context,
              message: "Request cancelled successfully.");
        } else if (state is RequestError) {
          showErrorOverlayMessage(context, errorMessage: state.message);
        }
      },
      child: BlocBuilder<WorkerCubit, WorkerState>(
        builder: (context, state) {
          if (state is WorkerLoading) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: CircularProgressIndicator(
                color: kPrimaryColor,
              )),
            );
          }

          if (state is WorkerLoaded) {
            final Worker worker = state.worker;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  color: Colors.green,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  'Worker Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WorkerProfileHeader(worker: worker),
                    const SizedBox(height: 20),

                    TabSelector(
                      selectedTab: selectedTab,
                      onTabSelected: (index) {
                        switch (index) {
                          case 0:
                            scrollTo(aboutKey, 0);
                            break;
                          case 1:
                            scrollTo(photosKey, 1);
                            break;
                          case 2:
                            scrollTo(reviewsKey, 2);
                            break;
                        }
                      },
                    ),

                    const SizedBox(height: 20),
                    const SectionDivider(),

                    SectionTitle("About", key: aboutKey),
                    Text(
                      worker.description.isNotEmpty
                          ? worker.description
                          : 'No description available.',
                      style: const TextStyle(height: 1.4),
                    ),

                    const SizedBox(height: 20),

                    // Action buttons section
                    if (_userType != 'Worker') ...[
                      WorkerActionButtons(
                        status: _currentRequestStatus ??
                            '', // this is 'pending', 'accepted', etc.
                        requestLoading: _requestLoading,
                        onSendRequest:
                            _onSendRequestPressed, // Used for "Send Request" status
                        onCancelRequest:
                            _onCancelRequestPressed, // Used for "Cancel Request" in 'pending'
                        onFinish: _onFinishPressed, // Used for 'accepted'
                        onMessage:
                            _onMessagePressed, // Used everywhere for message button
                      ),
                    ],

                    const SizedBox(height: 20),
                    const SectionDivider(),

                    WorkerHighlights(worker: worker),

                    const SizedBox(height: 20),
                    const SectionDivider(),

                    WorkerPortfolioSection(
                      worker: worker,
                      key: photosKey,
                    ),

                    const SizedBox(height: 20),
                    const SectionDivider(),

                    WorkerReviewsSection(
                      worker: worker,
                      key: reviewsKey,
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is WorkerError) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  color: Colors.green,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  'Error',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
              ),
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text('No worker data available.')),
          );
        },
      ),
    );
  }
}
