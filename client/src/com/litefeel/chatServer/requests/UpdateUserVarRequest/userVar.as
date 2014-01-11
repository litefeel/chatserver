package com.litefeel.chatServer.requests.UpdateUserVarRequest {
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
		public static const OP:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.litefeel.chatServer.requests.UpdateUserVarRequest.UserVar.op", "op", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var op:int;

		/**
		 *  @private
		 */
		public static const KEY:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.litefeel.chatServer.requests.UpdateUserVarRequest.UserVar.key", "key", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var key:String;

		/**
		 *  @private
		 */
		public static const VALUE:FieldDescriptor$TYPE_BYTES = new FieldDescriptor$TYPE_BYTES("com.litefeel.chatServer.requests.UpdateUserVarRequest.UserVar.value", "value", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.op);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.key);
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
			var op$count:uint = 0;
			var key$count:uint = 0;
			var value$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (op$count != 0) {
						throw new flash.errors.IOError('Bad data format: UserVar.op cannot be set twice.');
					}
					++op$count;
					this.op = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (key$count != 0) {
						throw new flash.errors.IOError('Bad data format: UserVar.key cannot be set twice.');
					}
					++key$count;
					this.key = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
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
