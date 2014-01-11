package com.litefeel.chatServer.serialization
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class CodedInputStream
	{
		/**
		* Create a new CodedInputStream wrapping the given byte array.
		*/
//		public static function  newInstance(buf:ByteArray):CodedInputStream {
//			return newInstance1(buf, 0, buf.length);
//		}

		/**
		* Create a new CodedInputStream wrapping the given byte array slice.
		*/
//		public static function newInstance1(buf:ByteArray, off:int, len:int):CodedInputStream {
//			const result:CodedInputStream = new CodedInputStream(buf, off, len);
//			try {
//			  result.pushLimit(len);
//			} catch (ex:Error) {
//			  throw ex;
//			}
//			return result;
//		}
		
//		private function pushLimit(byteLimit:int):void 
//		{
//			if (byteLimit < 0) {
//			  throw new Error("InvalidProtocolBufferException.negativeSize()");
//			}
//			byteLimit += totalBytesRetired + bufferPos;
//			final int oldLimit = currentLimit;
//			if (byteLimit > oldLimit) {
//			  throw InvalidProtocolBufferException.truncatedMessage();
//			}
//			currentLimit = byteLimit;
//
//			recomputeBufferSizeAfterLimit();
//
//			return oldLimit;
//		}
		
			
//		public function readTag():int {
//			if (isAtEnd()) {
//				lastTag = 0;
//				return 0;
//			}
//
//			lastTag = readRawVarint32();
//			if (WireFormat.getTagFieldNumber(lastTag) == 0) {
//			// If we actually read zero (or any tag number corresponding to field
//			// number zero), that's not a valid tag.
//				throw InvalidProtocolBufferException.invalidTag();
//			}
//			return lastTag;
//		}
  
  
		private var bytes:ByteArray;
		
		public function CodedInputStream(buf:ByteArray, off:int = 0, len:int = 0)
		{
			bytes.position = 0;
			this.bytes = bytes;
//			bytes.endian = Endian.LITTLE_ENDIAN;
		}
		public function readInt32():int
		{
			return readRawVarint32();
		}
		
		public function readRawByte():int
		{
			return bytes.readByte();
		}
		
		public function readRawVarint32():int {
			var tmp:int = readRawByte();
			if (tmp >= 0) {
				return tmp;
			}
			var result:int = tmp & 0x7f;
			if ((tmp = readRawByte()) >= 0) {
				result |= (tmp << 7) & 0xFF;
			} else {
				result |= ((tmp & 0x7f) << 7) & 0xFF;
				if ((tmp = readRawByte()) >= 0) {
					result |= (tmp << 14) & 0xFF;
				} else {
					result |= ((tmp & 0x7f) << 14) & 0xFF;
					if ((tmp = readRawByte()) >= 0) {
						result |= (tmp << 21) & 0xFF;
					} else {
						result |= ((tmp & 0x7f) << 21) & 0xFF;
						result |= ((tmp = readRawByte()) << 28) & 0xFF;
						if (tmp < 0) {
							// Discard upper 32 bits.
							for (var i:int = 0; i < 5; i++) {
								if (readRawByte() >= 0) {
									return result;
								}
							}
							throw new Error("InvalidProtocolBufferException.malformedVarint()");
//							throw InvalidProtocolBufferException.malformedVarint();
						}
					}
				}
			}
			return result;
		}
	}
}