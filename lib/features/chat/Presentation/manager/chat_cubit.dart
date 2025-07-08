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

      // تسجيل الاتصال
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

      await chatService.init(currentUserId: userId);
      await completer.future; // ✨ انتظر الاتصال

      await chatService.joinChat(requestId);
      final messages = await chatService.getMessages(requestId);
      _safeEmit(ChatMessagesLoaded(messages));

      // استقبال الرسائل
      chatService.onMessageReceived = (message) {
        final previousMessages = state is ChatMessagesLoaded
            ? (state as ChatMessagesLoaded).messages
            : [];
        final updatedMessages = List<dynamic>.from(previousMessages)
          ..add(message);
        _safeEmit(ChatMessagesLoaded(updatedMessages));
      };

      // تأكيد الرسائل المرسلة
      chatService.onMessageSent = (sentMessage) {
        final previousMessages = state is ChatMessagesLoaded
            ? (state as ChatMessagesLoaded).messages
            : [];
        final updatedMessages = List<dynamic>.from(previousMessages)
          ..add(sentMessage);
        _safeEmit(ChatMessagesLoaded(updatedMessages));
      };
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
    if (!_isClosed) emit(state);
  }

  Future<void> dispose() async {
    _isClosed = true;
    await chatService.dispose();
    close();
  }
}
