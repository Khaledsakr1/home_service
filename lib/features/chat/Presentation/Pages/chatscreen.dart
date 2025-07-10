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

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().init(
      userId: widget.userId,
      requestId: widget.requestId,
    );
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
      appBar: AppBar(title: const Text("Chat")),
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
              const SnackBar(content: Text('❌ الاتصال انقطع، جاري إعادة المحاولة...')),
            );
          } else if (state is ChatReconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ تم إعادة الاتصال بنجاح')),
            );
          }
        },
        builder: (context, state) {
          List<dynamic> messages = [];

          if (state is ChatMessagesLoaded) {
            messages = List.from(state.messages);
            messages.sort((a, b) {
              final aTime = DateTime.tryParse(a['sentAt'] ?? '') ?? DateTime.now();
              final bTime = DateTime.tryParse(b['sentAt'] ?? '') ?? DateTime.now();
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
                    '🚫 تم فقد الاتصال، جاري إعادة الاتصال...',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              Expanded(
                child: state is ChatLoading
                    ? const Center(child: CircularProgressIndicator())
                    : messages.isEmpty
                        ? const Center(child: Text("لا توجد رسائل بعد"))
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];

                              final senderId = int.tryParse(message['senderId']?.toString() ?? '') ?? -1;
                              final isMe = senderId == widget.userId;

                              return Align(
                                alignment: isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isMe ? Colors.blue[200] : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: isMe
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isMe ? "أنت" : message['senderName'] ?? "مستخدم",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        message['content'] ?? '',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        message['sentAt'] != null
                                            ? message['sentAt'].toString().substring(11, 16)
                                            : '',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        enabled: !isDisconnected,
                        decoration: InputDecoration(
                          hintText: isDisconnected
                              ? 'جاري إعادة الاتصال...'
                              : 'اكتب رسالتك...',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: isDisconnected ? null : _sendMessage,
                      color: Colors.blue,
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