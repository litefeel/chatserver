package com.litefeel.chatServer.responders {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.litefeel.chatServer.requests.UserVar;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class UserVo extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const UID:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.litefeel.chatServer.responders.UserVo.uid", "uid", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var uid:String;

		/**
		 *  @private
		 */
		public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.litefeel.chatServer.responders.UserVo.name", "name", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		public var name:String;

		/**
		 *  @private
		 */
		public static const POSLIST:RepeatedFieldDescriptor$TYPE_FLOAT = new RepeatedFieldDescriptor$TYPE_FLOAT("com.litefeel.chatServer.responders.UserVo.posList", "posList", (3 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		[ArrayElementType("Number")]
		public var posList:Array = [];

		/**
		 *  @private
		 */
		public static const VARLIST:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.litefeel.chatServer.responders.UserVo.varList", "varList", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.litefeel.chatServer.requests.UserVar; });

		[ArrayElementType("com.litefeel.chatServer.requests.UserVar")]
		public var varList:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.uid);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.name);
			for (var posList$index:uint = 0; posList$index < this.posList.length; ++posList$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_FLOAT(output, this.posList[posList$index]);
			}
			for (var varList$index:uint = 0; varList$index < this.varList.length; ++varList$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.varList[varList$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var uid$count:uint = 0;
			var name$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (uid$count != 0) {
						throw new flash.errors.IOError('Bad data format: UserVo.uid cannot be set twice.');
					}
					++uid$count;
					this.uid = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 2:
					if (name$count != 0) {
						throw new flash.errors.IOError('Bad data format: UserVo.name cannot be set twice.');
					}
					++name$count;
					this.name = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 3:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_FLOAT, this.posList);
						break;
					}
					this.posList.push(com.netease.protobuf.ReadUtils.read$TYPE_FLOAT(input));
					break;
				case 4:
					this.varList.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.litefeel.chatServer.requests.UserVar()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
