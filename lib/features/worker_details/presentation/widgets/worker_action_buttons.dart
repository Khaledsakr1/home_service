import 'package:flutter/material.dart';

class WorkerActionButtons extends StatelessWidget {
  final String status; // 'pending', 'accepted', 'approve', etc.
  final bool requestLoading;
  final VoidCallback? onSendRequest;
  final VoidCallback? onCancelRequest;
  final VoidCallback? onFinish;
  final VoidCallback? onMessage;
  final VoidCallback? onAcceptOffer;
  final VoidCallback? onRejectOffer;

  const WorkerActionButtons({
    Key? key,
    required this.status,
    required this.requestLoading,
    this.onSendRequest,
    this.onCancelRequest,
    this.onFinish,
    this.onMessage,
    this.onAcceptOffer,
    this.onRejectOffer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 'request' || status == 'cancelled' || status == 'rejected' || status == 'completed') {
      return Center(
        child: SizedBox(
          width: 300,
          child: ElevatedButton.icon(
            onPressed: requestLoading ? null : onSendRequest,
            icon: requestLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.send),
            label: Text(requestLoading ? 'Sending...' : 'Send Request'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      );
    }

    if (status == 'pending') {
      return Column(
        children: [
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton.icon(
                onPressed: requestLoading ? null : onCancelRequest,
                icon: requestLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.cancel),
                label: Text(requestLoading ? 'Cancelling...' : 'Cancel Request'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 300,
              child: OutlinedButton.icon(
                onPressed: onMessage ??
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Messaging feature coming soon!')),
                      );
                    },
                icon: const Icon(Icons.message_outlined, color: Colors.green),
                label: const Text('Message', style: TextStyle(color: Colors.green)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (status == 'accepted') {
      return Column(
        children: [
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton.icon(
                onPressed: onFinish,
                icon: const Icon(Icons.done_all),
                label: const Text('Finish'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 300,
              child: OutlinedButton.icon(
                onPressed: onMessage ??
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Messaging feature coming soon!')),
                      );
                    },
                icon: const Icon(Icons.message_outlined, color: Colors.green),
                label: const Text('Message', style: TextStyle(color: Colors.green)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // New approve status handling
    if (status == 'approve') {
      return Column(
        children: [
          // Accept Offer Button
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton.icon(
                onPressed: requestLoading ? null : onAcceptOffer,
                icon: requestLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.check_circle),
                label: Text(requestLoading ? 'Processing...' : 'Accept Offer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Reject Offer Button
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton.icon(
                onPressed: requestLoading ? null : onRejectOffer,
                icon: requestLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.close),
                label: Text(requestLoading ? 'Processing...' : 'Reject Offer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Message Button
          Center(
            child: SizedBox(
              width: 300,
              child: OutlinedButton.icon(
                onPressed: onMessage ??
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Messaging feature coming soon!')),
                      );
                    },
                icon: const Icon(Icons.message_outlined, color: Colors.green),
                label: const Text('Message', style: TextStyle(color: Colors.green)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Default fallback (show nothing)
    return const SizedBox.shrink();
  }
}