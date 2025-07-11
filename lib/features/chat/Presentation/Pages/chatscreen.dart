import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/features/chat/Presentation/manager/chat_cubit.dart';
import 'package:home_service/features/chat/Presentation/manager/chat_state.dart';

class ChatScreen extends StatefulWidget {
  final int userId;
  final int requestId;
  final int receiverId;

  const ChatScreen({
    super.key,
    required this.userId,
    required this.requestId,
    required this.receiverId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      context.read<ChatCubit>().init(
            userId: widget.userId,
            requestId: widget.requestId,
          );
      _initialized = true;
    }
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    context.read<ChatCubit>().sendMessage(
          requestId: widget.requestId,
          receiverId: widget.receiverId,
          content: content,
        );

    _messageController.clear();
    FocusScope.of(context).unfocus();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatMessagesLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToBottom();
            });
          } else if (state is ChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ChatDisconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('❌Bad Connection....')),
            );
          } else if (state is ChatReconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅Connected')),
            );
          }
        },
        builder: (context, state) {
          List<dynamic> messages = [];

          if (state is ChatMessagesLoaded) {
            messages = List.from(state.messages);
            messages.sort((a, b) {
              final aTime =
                  DateTime.tryParse(a['sentAt'] ?? '') ?? DateTime.now();
              final bTime =
                  DateTime.tryParse(b['sentAt'] ?? '') ?? DateTime.now();
              return aTime.compareTo(bTime);
            });
          }

          final bool isDisconnected = state is ChatDisconnected;

          return Column(
            children: [
              if (isDisconnected)
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '🚫Lost Connection ,Please Try Again...',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              Expanded(
                child: state is ChatLoading
                    ? const Center(child: CircularProgressIndicator())
                    : messages.isEmpty
                        ? const Center(child: Text("No Messages"))
                        : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              final isMe = message['isMe'] == true;

                              return Align(
                                alignment: isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.75),
                                  decoration: BoxDecoration(
                                    color: isMe
                                        ? const Color(0xFFDCF8C6)
                                        : const Color(0xFFF1F0F0),
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(16),
                                      topRight: const Radius.circular(16),
                                      bottomLeft:
                                          Radius.circular(isMe ? 16 : 0),
                                      bottomRight:
                                          Radius.circular(isMe ? 0 : 16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: isMe
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isMe
                                            ? "You"
                                            : message['senderName'] ?? "User",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        message['content'] ?? '',
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        message['sentAt'] != null
                                            ? message['sentAt']
                                                .toString()
                                                .substring(11, 16)
                                            : '',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
              const Divider(height: 1),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _messageController,
                          enabled: !isDisconnected,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: isDisconnected
                                ? 'Way To Connect...'
                                : 'Write Your Message',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: isDisconnected ? null : _sendMessage,
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
