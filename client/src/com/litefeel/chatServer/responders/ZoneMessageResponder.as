package com.litefeel.chatServer.responders {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class ZoneMessageResponder extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const HEAD:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.litefeel.chatServer.responders.ZoneMessageResponder.head", "head", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var head$field:int;

		private var hasField$0:uint = 0;

		public function clearHead():void {
			hasField$0 &= 0xfffffffe;
			head$field = new int();
		}

		public function get hasHead():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set head(value:int):void {
			hasField$0 |= 0x1;
			head$field = value;
		}

		public function get head():int {
			if(!hasHead) {
				return 1;
			}
			return head$field;
		}

		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.litefeel.chatServer.responders.ZoneMessageResponder.type", "type", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var type$field:int;

		public function clearType():void {
			hasField$0 &= 0xfffffffd;
			type$field = new int();
		}

		public function get hasType():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set type(value:int):void {
			hasField$0 |= 0x2;
			type$field = value;
		}

		public function get type():int {
			if(!hasType) {
				return 3;
			}
			return type$field;
		}

		/**
		 *  @private
		 */
		public static const USERID:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.litefeel.chatServer.responders.ZoneMessageResponder.userId", "userId", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var userId:String;

		/**
		 *  @private
		 */
		public static const USERNAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.litefeel.chatServer.responders.ZoneMessageResponder.userName", "userName", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var userName:String;

		/**
		 *  @private
		 */
		public static const MSG:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.litefeel.chatServer.responders.ZoneMessageResponder.msg", "msg", (5 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var msg:String;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasHead) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, head$field);
			}
			if (hasType) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, type$field);
			}
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.userId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.userName);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 5);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.msg);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var head$count:uint = 0;
			var type$count:uint = 0;
			var userId$count:uint = 0;
			var userName$count:uint = 0;
			var msg$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (head$count != 0) {
						throw new flash.errors.IOError('Bad data format: ZoneMessageResponder.head cannot be set twice.');
					}
					++head$count;
					this.head = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: ZoneMessageResponder.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (userId$count != 0) {
						throw new flash.errors.IOError('Bad data format: ZoneMessageResponder.userId cannot be set twice.');
					}
					++userId$count;
					this.userId = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 4:
					if (userName$count != 0) {
						throw new flash.errors.IOError('Bad data format: ZoneMessageResponder.userName cannot be set twice.');
					}
					++userName$count;
					this.userName = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 5:
					if (msg$count != 0) {
						throw new flash.errors.IOError('Bad data format: ZoneMessageResponder.msg cannot be set twice.');
					}
					++msg$count;
					this.msg = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
