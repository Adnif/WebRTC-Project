import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCall extends StatefulWidget {
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  late RTCPeerConnection _peerConnection;

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _createPeerConnection().then((pc) {
      _peerConnection = pc;
      _createOffer();
    });
  }

  void _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  Future<RTCPeerConnection> _createPeerConnection() async {
    Map<String, dynamic> configuration = {
      "iceServers": [
        {"url": "stun:stun.l.google.com:19302"},
      ],
    };
    final pc = await createPeerConnection(configuration, {});
    
    final Map<String, dynamic> mediaConstraints = {
      "audio": true,
      "video": true,
    };
    final mediaStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    pc.addStream(mediaStream);
    
    pc.onIceCandidate = (candidate) {
      // Handle ICE candidate events
    };
    pc.onIceConnectionState = (state) {
      // Handle ICE connection state events
    };
    pc.onIceGatheringState = (state) {
      // Handle ICE gathering state events
    };
    pc.onAddStream = (stream) {
      _remoteRenderer.srcObject = stream;
    };
    return pc;
  }

  void _createOffer() async {
    RTCSessionDescription description = await _peerConnection.createOffer({});
    await _peerConnection.setLocalDescription(description);
    // Send the offer to the other party
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: RTCVideoView(_remoteRenderer),
        ),
        Expanded(
          child: RTCVideoView(_localRenderer),
        ),
      ],
    );
  }
}
