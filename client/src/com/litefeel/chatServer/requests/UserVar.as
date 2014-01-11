package com.litefeel.chatServer.requests {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import flash.utils.ByteArray;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class UserVar extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const KEY:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.litefeel.chatServer.requests.UserVar.key", "key", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var key:String;

		/**
		 *  @private
		 */
		public static const OP:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.litefeel.chatServer.requests.UserVar.op", "op", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var op$field:int;

		private var hasField$0:uint = 0;

		public function clearOp():void {
			hasField$0 &= 0xfffffffe;
			op$field = new int();
		}

		public function get hasOp():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set op(value:int):void {
			hasField$0 |= 0x1;
			op$field = value;
		}

		public function get op():int {
			return op$field;
		}

		/**
		 *  @private
		 */
		public static const VALUE:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("com.litefeel.chatServer.requests.UserVar.value", "value", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var value$field:flash.utils.ByteArray;

		public function clearValue():void {
			value$field = null;
		}

		public function get hasValue():Boolean {
			return value$field != null;
		}

		public function set value(value:flash.utils.ByteArray):void {
			value$field = value;
		}

		public function get value():flash.utils.ByteArray {
			return value$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.key);
			if (hasOp) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, op$field);
			}
			if (hasValue) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_BYTES(output, value$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var key$count:uint = 0;
			var op$count:uint = 0;
			var value$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (key$count != 0) {
						throw new flash.errors.IOError('Bad data format: UserVar.key cannot be set twice.');
					}
					++key$count;
					this.key = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 2:
					if (op$count != 0) {
						throw new flash.errors.IOError('Bad data format: UserVar.op cannot be set twice.');
					}
					++op$count;
					this.op = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (value$count != 0) {
						throw new flash.errors.IOError('Bad data format: UserVar.value cannot be set twice.');
					}
					++value$count;
					this.value = com.netease.protobuf.ReadUtils.read$TYPE_BYTES(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
