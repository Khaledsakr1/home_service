import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:signalr_core/signalr_core.dart';
import 'package:home_service/injection_container.dart' as di;
import 'package:home_service/core/services/token_service.dart';

class ChatSignalRService {
  HubConnection? _connection;
  int? _userId;
  bool _isConnected = false;
  bool _isInitialized = false;

  // Listeners
  Function(dynamic message)? onMessageReceived;
  Function(String systemMessage)? onSystemMessage;
  Function(dynamic sentMessage)? onMessageSent;
  Function(String error)? onError;
  Function()? onConnected;
  Function()? onDisconnected;

  bool get isConnected => _isConnected;

  //================= Init ===================
  Future<void> init({required int currentUserId}) async {
    if (_isInitialized && !_isConnected) {
      print('♻️ Retrying SignalR connection...');

      if (_connection?.state != HubConnectionState.disconnected) {
        print('⚠️ Connection not in disconnected state: ${_connection?.state}');
        return;
      }

      try {
        await _connection!.start();
        _isConnected = true;
        onConnected?.call();
        return;
      } catch (e) {
        print('❌ Retry Start Error: $e');
        onError?.call('Failed to reconnect SignalR: $e');
        rethrow;
      }
    }

    if (_isInitialized && _isConnected) {
      print('⚠️ Already initialized and connected');
      return;
    }

    try {
      final token = await di.sl<TokenService>().getToken();
      if (token == null || token.isEmpty) throw Exception('Missing token');

      _userId ??= currentUserId;
      _isInitialized = true;

      _connection = HubConnectionBuilder()
          .withUrl(
            'https://projectapi-ekhpcndsdgbahqhm.canadacentral-01.azurewebsites.net/chatHub',
            HttpConnectionOptions(
              accessTokenFactory: () async => token,
              transport: HttpTransportType.longPolling,
              skipNegotiation: false,
            ),
          )
          .withAutomaticReconnect()
          .build();

      _connection!.onclose((error) {
        print('❌ Connection Closed: $error');
        _isConnected = false;
        onDisconnected?.call();
      });

      _connection!.onreconnecting((error) {
        print('🔄 Reconnecting: $error');
        _isConnected = false;
      });

      _connection!.onreconnected((connectionId) {
        print('✅ Reconnected: $connectionId');
        _isConnected = true;
        onConnected?.call();
      });

      _connection!.on('ReceiveMessage', _handleIncomingMessage);
      _connection!.on('SystemMessage', _handleSystemMessage);
      _connection!.on('MessageSent', _handleMessageSent);

      print('🌐 Connecting as userId: $_userId...');
      print('🔌 Starting SignalR connection...');

      if (_connection!.state != HubConnectionState.disconnected) {
        await _connection!.stop();
      }

      await _connection!.start();

      print('✅ Connected successfully');
      _isConnected = true;
      onConnected?.call();
    } catch (e) {
      print('❌ Init Error: $e');
      onError?.call('Failed to initialize chat connection: $e');
      rethrow;
    }
  }

  //================= Join / Leave Chat ===================
  Future<void> joinChat(int requestId) async {
    try {
      if (!_isConnected) throw Exception('SignalR not connected');
      await _connection!.invoke('JoinRequestChat', args: [requestId]);
      print('🏠 Joined chat for request: $requestId');
    } catch (e) {
      print('❌ Join Chat Error: $e');
      onError?.call('Failed to join chat: $e');
      rethrow;
    }
  }

  Future<void> leaveChat(int requestId) async {
    try {
      if (!_isConnected) return;
      await _connection!.invoke('LeaveRequestChat', args: [requestId]);
      print('🚪 Left chat for request: $requestId');
    } catch (e) {
      print('❌ Leave Chat Error: $e');
      onError?.call('Failed to leave chat: $e');
    }
  }

  //================= Send Message ===================
  Future<void> sendMessage({
    required int requestId,
    required int receiverId,
    required String content,
  }) async {
    try {
      if (!_isConnected) throw Exception('SignalR not connected');
      if (content.trim().isEmpty) throw Exception('Empty message');

      await _connection!.invoke('SendMessage', args: [requestId, receiverId, content]);
      print('📤 Message sent to request: $requestId, receiver: $receiverId');
    } catch (e) {
      print('❌ Send Message Error: $e');
      onError?.call('Failed to send message: $e');
      rethrow;
    }
  }

  //================= Message Handlers ===================
  void _handleIncomingMessage(List<Object?>? args) {
    try {
      final messageData = args?[0];
      print('📩 Received: $messageData');
      onMessageReceived?.call(messageData);
    } catch (e) {
      print('❌ Incoming Message Error: $e');
      onError?.call('Error handling received message: $e');
    }
  }

  void _handleSystemMessage(List<Object?>? args) {
    try {
      final message = args?[0] as String? ?? 'Unknown system message';
      print('📢 System Message: $message');
      onSystemMessage?.call(message);
    } catch (e) {
      print('❌ System Message Error: $e');
      onError?.call('Error handling system message: $e');
    }
  }

  void _handleMessageSent(List<Object?>? args) {
    try {
      final sentMessage = args?[0];
      print('📤 Sent Confirmed: $sentMessage');
      onMessageSent?.call(sentMessage);
    } catch (e) {
      print('❌ Message Sent Error: $e');
      onError?.call('Error confirming sent message: $e');
    }
  }

  //================= API - Get Messages ===================
  Future<List<Map<String, dynamic>>> getMessages(int requestId) async {
    try {
      final token = await di.sl<TokenService>().getToken();

      final url = Uri.parse(
        'https://projectapi-ekhpcndsdgbahqhm.canadacentral-01.azurewebsites.net/api/Chat/request/$requestId',
      );

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'text/plain',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map<Map<String, dynamic>>((msg) => msg as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load messages: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ getMessages API Error: $e');
      onError?.call('Failed to load messages: $e');
      rethrow;
    }
  }

  //================= Connection Utilities ===================
  Future<void> reconnect() async {
    try {
      if (_isConnected) await _connection!.stop();
      await _connection!.start();
      _isConnected = true;
      onConnected?.call();
      print('🔁 Manual reconnect successful');
    } catch (e) {
      print('❌ Reconnect Error: $e');
      onError?.call('Failed to reconnect: $e');
      rethrow;
    }
  }

  Future<void> dispose() async {
    try {
      if (_isConnected) await _connection!.stop();
      _connection = null;
      _isConnected = false;
      _isInitialized = false;
      print('🔌 SignalR disposed');
    } catch (e) {
      print('❌ Dispose Error: $e');
    }
  }
}
