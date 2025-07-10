import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/features/chat/Presentation/Pages/chatscreen.dart';
import 'package:home_service/features/chat/Presentation/manager/chat_cubit.dart';
import 'package:home_service/features/chat/data/datasources/chat_signalr_service.dart';
import 'package:home_service/features/client_project/presentation/pages/project_list_page.dart';
import 'package:home_service/features/requests/presentation/manager/request_cubit.dart';
import 'package:home_service/features/requests/presentation/manager/request_state.dart';
import 'package:home_service/features/requests/presentation/widgets/review_dialog.dart';
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
import 'package:http/http.dart' as http;

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
  bool _hasReviewed = false; // This will track if review has been submitted
  bool _showReviewDialogValiable =
      false; // This will control when to show the dialog

  @override
  void initState() {
    super.initState();
    _currentRequestStatus = widget.requestStatus?.toLowerCase();
    _sentRequestId = widget.requestId;

    // Set initial request pending state based on status
    if (widget.formRequsted && _currentRequestStatus == 'pending') {
      _requestPending = true;
    }

    // If coming from a completed request, don't show review dialog yet
    if (_currentRequestStatus == 'completed') {
      _hasReviewed =
          true; // Assume already reviewed if coming from completed status
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

  void _onAcceptOfferPressed() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const ConfirmationDialog(
        title: 'Accept Final Offer',
        content:
            'Are you sure you want to accept this final offer? This will proceed with the project.',
        confirmText: 'Accept Offer',
        cancelText: 'Cancel',
        isDestructive: false,
      ),
    );

    if (confirmed == true) {
      setState(() => _requestLoading = true);
      final requestId = _sentRequestId ?? widget.requestId;
      if (requestId != null) {
        context.read<RequestCubit>().approveFinalOffer(requestId, true);
      }
    }
  }

  void _onRejectOfferPressed() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const ConfirmationDialog(
        title: 'Reject Final Offer',
        content:
            'Are you sure you want to reject this final offer? This will end the project negotiation.',
        confirmText: 'Reject Offer',
        cancelText: 'Keep Offer',
        isDestructive: true,
      ),
    );

    if (confirmed == true) {
      setState(() => _requestLoading = true);
      final requestId = _sentRequestId ?? widget.requestId;
      if (requestId != null) {
        context.read<RequestCubit>().approveFinalOffer(requestId, false);
      }
    }
  }

  void _onFinishPressed() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const ConfirmationDialog(
        title: 'Complete Request',
        content:
            'Are you sure you want to mark this request as completed? This action cannot be undone.',
        confirmText: 'Complete Request',
        cancelText: 'Cancel',
        isDestructive: false,
      ),
    );

    if (confirmed == true) {
      setState(() => _requestLoading = true);
      final requestId = _sentRequestId ?? widget.requestId;
      if (requestId != null) {
        context.read<RequestCubit>().completeRequest(requestId);
      }
    }
  }

  void _showReviewDialog() {
    if (widget.workerId != null && !_hasReviewed) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (context) => BeautifulReviewDialog(
          workerId: widget.workerId!,
          workerName: 'Worker', // You can get this from the worker object
          onReviewSubmitted: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  void _onMessagePressed() {
    final token = di.sl<TokenService>().token;
    final requestId = _sentRequestId ?? widget.requestId;

    print(
        "token: $token | requestId: $requestId | workerId: ${widget.workerId}");

    if (token == null || requestId == null || widget.workerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Missing required chat information')),
      );
      return;
    }

    final userData = JwtDecoder.decode(token);

    final userId = int.tryParse(
      userData['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']
              ?.toString() ??
          '',
    );

    print('✅ Client userId: $userId');
    print('📨 Receiver (workerId): ${widget.workerId}');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID not found in token')),
      );
      return;
    }

    final receiverId = widget.workerId!;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          // create: (_) => di.sl<ChatCubit>(),
          create: (context) =>
              ChatCubit(chatService: di.sl<ChatSignalRService>()),
          child: ChatScreen(
            userId: userId,
            requestId: requestId,
            receiverId: receiverId,
          ),
        ),
      ),
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
        } else if (state is RequestCompleted) {
          setState(() {
            _currentRequestStatus = 'completed';
            _hasReviewed = false; // Reset this to allow review
            _showReviewDialogValiable = true; // Enable review dialog
          });

          // Show review dialog after completion ONLY if user is customer
          if (_userType != 'Worker') {
            Future.delayed(const Duration(milliseconds: 1000), () {
              _showReviewDialog();
            });
          }
        } else if (state is RequestApproved) {
          // Don't show review dialog here!
          setState(() {
            _currentRequestStatus = 'accepted'; // or 'approve', as needed
          });
          showCustomOverlayMessage(context,
              message: "Offer accepted successfully!");
        } else if (state is ReviewAdded) {
          setState(() {
            _hasReviewed = true; // Mark as reviewed
            _showReviewDialogValiable = false;
          });
          if (widget.workerId != null) {
            context.read<WorkerCubit>().fetchWorker(widget.workerId!);
          }
          Navigator.pop(context); // Close the review dialog
          showCustomOverlayMessage(context,
              message: "Thank you for your review!");
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
                // actions: [
                //   IconButton(
                //     icon: const Icon(Icons.bug_report, color: Colors.red),
                //     onPressed: () async {
                //       final token = await di.sl<TokenService>().getToken();
                //       print("🔑 Token: $token");

                //       final uri = Uri.parse(
                //           "https://projectapi-ekhpcndsdgbahqhm.canadacentral-01.azurewebsites.net/chatHub/negotiate");

                //       try {
                //         final response = await http.post(uri, headers: {
                //           'Authorization': 'Bearer $token',
                //         });

                //         print("📡 Status Code: ${response.statusCode}");
                //         print("📄 Response Body: ${response.body}");
                //       } catch (e) {
                //         print("❌ Network error: $e");
                //       }
                //     },
                //   ),
                // ],
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
                        status: _currentRequestStatus ?? '',
                        requestLoading: _requestLoading,
                        onSendRequest: _onSendRequestPressed,
                        onCancelRequest: _onCancelRequestPressed,
                        onFinish: _onFinishPressed,
                        onMessage: _onMessagePressed,
                        onAcceptOffer: _onAcceptOfferPressed, // Add this
                        onRejectOffer: _onRejectOfferPressed, // Add this
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
