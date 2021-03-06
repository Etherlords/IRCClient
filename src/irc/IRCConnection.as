package irc {
	
	import core.net.Socket;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	
	import irc.events.IRCEvent;
	import irc.names.IIRCName;
	
	public class IRCConnection extends EventDispatcher {
		private var _socket:Socket;
		private var _buffer:String;
		
		public function IRCConnection() {
			_buffer = "";
		}
		
		public function get connected():Boolean {
			return (_socket != null && _socket.connected);
		}
		
		public function connect(host:String, port:uint = 6667, overTLS:Boolean = false):void {
			if (connected)
				throw new Error("Already connected");
				
			dispose();
			
			_socket = createSocket();
			
			if (!_socket)
				return;
			
			try {
				_socket.connect(host, port);
				
			} catch (e:Error) {
				return;
			}
			
		}
		
		public function disconnect():void {
			if (_socket != null && _socket.connected)
				_socket.close();
			dispose();
		}
		
		private function dispose():void {
			releaseSocket();
			_buffer = "";
		}
		
		private function releaseSocket():void {
			
			if (!_socket)
				return;
			
			_socket.removeEventListener(Event.CONNECT, dispatchEvent);
			_socket.removeEventListener(Event.CLOSE, closeHandler);
			_socket.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_socket.removeEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			_socket = null;
		}
		
		public function send(msg:IRCMessage):void {
			if (!(_socket && _socket.connected))
				throw new Error("Socket is not connected");
			
			_socket.writeBytes(msg.toByteArray());
			
			
			_socket.flush();
		}
		
		private function createSocket():Socket {
			try {
				var s:Socket = new Socket();
				
			} catch (e:Error) {
				return null
			}
			
			s.addEventListener(Event.CONNECT, dispatchEvent);
			s.addEventListener(Event.CLOSE, closeHandler);
			s.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			s.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			s.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			return s;
		}
		
		private function closeHandler(e:Event):void {
			dispose();
			dispatchEvent(e);
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void {
			disconnect();
			dispatchEvent(e);
		}
		
		private function securityErrorHandler(e:SecurityErrorEvent):void {
			disconnect();
			dispatchEvent(e);
			
		}
		
		public function sendMessage(command:String, params:Array, trailing:String = null, prefix:IIRCName = null):void {
			send(new IRCMessage(command, params, trailing, prefix));
		}
		
		private function socketDataHandler(e:ProgressEvent):void {
			while (_socket != null && _socket.bytesAvailable) {
				var bytes:ByteArray = new ByteArray();
				_socket.readBytes(bytes, 0, _socket.bytesAvailable);
				bytes.position = 0;
				_buffer += bytes.readUTFBytes(bytes.bytesAvailable);
			}
			var eol:int;
			var line:String;
			var msg:IRCMessage;
			while (true) {
				eol = _buffer.indexOf("\r\n");
				if (eol == -1)
					break;
				line = _buffer.substring(0, eol);
				_buffer = _buffer.substring(eol + 2);
				msg = IRCMessageParser.parse(line);
				if (msg != null)
					dispatchEvent(new IRCEvent(IRCEvent.RECEIVED, msg));
			}
		}
	}
}

