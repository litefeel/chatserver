package com.litefeel.chatServer.responders {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.litefeel.chatServer.responders.UserVo;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class UserJoinResponder extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const HEAD:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.litefeel.chatServer.responders.UserJoinResponder.head", "head", (1 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const TYPE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.litefeel.chatServer.responders.UserJoinResponder.type", "type", (2 << 3) | com.netease.protobuf.WireType.VARINT);

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
				return 7;
			}
			return type$field;
		}

		/**
		 *  @private
		 */
		public static const ROOMID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.litefeel.chatServer.responders.UserJoinResponder.roomId", "roomId", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var roomId:int;

		/**
		 *  @private
		 */
		public static const USER:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.litefeel.chatServer.responders.UserJoinResponder.user", "user", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.litefeel.chatServer.responders.UserVo; });

		public var user:com.litefeel.chatServer.responders.UserVo;

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
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.roomId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
			com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.user);
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
			var roomId$count:uint = 0;
			var user$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (head$count != 0) {
						throw new flash.errors.IOError('Bad data format: UserJoinResponder.head cannot be set twice.');
					}
					++head$count;
					this.head = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: UserJoinResponder.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (roomId$count != 0) {
						throw new flash.errors.IOError('Bad data format: UserJoinResponder.roomId cannot be set twice.');
					}
					++roomId$count;
					this.roomId = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 4:
					if (user$count != 0) {
						throw new flash.errors.IOError('Bad data format: UserJoinResponder.user cannot be set twice.');
					}
					++user$count;
					this.user = new com.litefeel.chatServer.responders.UserVo();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.user);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
