import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/features/chat/Presentation/manager/chat_state.dart';
import 'package:home_service/features/chat/data/datasources/chat_signalr_service.dart';
import 'dart:async';

class ChatCubit extends Cubit<ChatState> {
  final ChatSignalRService chatService;
  bool _isClosed = false;

  ChatCubit({required this.chatService}) : super(ChatInitial());

  Future<void> init({required int userId, required int requestId}) async {
    try {
      emit(ChatLoading());

      final completer = Completer<void>();

      chatService.onConnected = () {
        _safeEmit(ChatReconnected());
        if (!completer.isCompleted) {
          completer.complete();
        }
      };

      chatService.onError = (message) {
        _safeEmit(ChatError(message));
      };

      chatService.onDisconnected = () {
        _safeEmit(ChatDisconnected());
      };

      chatService.onMessageReceived = (message) {
        final previousMessages = state is ChatMessagesLoaded
            ? (state as ChatMessagesLoaded).messages
            : [];

        final updatedMessage = {
          ...message,
          'isMe': message['senderId'].toString() == userId.toString(),
        };

        final updatedMessages = List<dynamic>.from(previousMessages)..add(updatedMessage);
        _safeEmit(ChatMessagesLoaded(updatedMessages));
      };

      chatService.onMessageSent = (sentMessage) {
        final previousMessages = state is ChatMessagesLoaded
            ? (state as ChatMessagesLoaded).messages
            : [];

        final updatedMessage = {
          ...sentMessage,
          'isMe': true,
        };

        final updatedMessages = List<dynamic>.from(previousMessages)..add(updatedMessage);
        _safeEmit(ChatMessagesLoaded(updatedMessages));
      };

      if (chatService.isConnected) {
        await chatService.joinChat(requestId);
        final messages = await chatService.getMessages(requestId);

        final updatedMessages = messages.map((msg) => {
              ...msg,
              'isMe': msg['senderId'].toString() == userId.toString(),
            }).toList();

        _safeEmit(ChatMessagesLoaded(updatedMessages));
        return;
      }

      await chatService.init(currentUserId: userId);
      await completer.future;

      await chatService.joinChat(requestId);
      final messages = await chatService.getMessages(requestId);

      final updatedMessages = messages.map((msg) => {
            ...msg,
            'isMe': msg['senderId'].toString() == userId.toString(),
          }).toList();

      _safeEmit(ChatMessagesLoaded(updatedMessages));
    } catch (e) {
      _safeEmit(ChatError('فشل في تهيئة المحادثة: $e'));
    }
  }

  Future<void> sendMessage({
    required int requestId,
    required int receiverId,
    required String content,
  }) async {
    try {
      await chatService.sendMessage(
        requestId: requestId,
        receiverId: receiverId,
        content: content,
      );
    } catch (e) {
      _safeEmit(ChatError('فشل في إرسال الرسالة: $e'));
    }
  }

  void _safeEmit(ChatState state) {
    if (!_isClosed && !isClosed) {
      emit(state);
    }
  }

  Future<void> dispose() async {
    _isClosed = true;

    chatService.onConnected = null;
    chatService.onError = null;
    chatService.onDisconnected = null;
    chatService.onMessageReceived = null;
    chatService.onMessageSent = null;

    await chatService.dispose();

    close();
  }
}
