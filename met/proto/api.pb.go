// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.32.0
// 	protoc        v4.25.1
// source: api.proto

package proto

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type Status struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Code    int32  `protobuf:"varint,1,opt,name=code,proto3" json:"code,omitempty"`
	Message string `protobuf:"bytes,2,opt,name=message,proto3" json:"message,omitempty"`
}

func (x *Status) Reset() {
	*x = Status{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Status) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Status) ProtoMessage() {}

func (x *Status) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Status.ProtoReflect.Descriptor instead.
func (*Status) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{0}
}

func (x *Status) GetCode() int32 {
	if x != nil {
		return x.Code
	}
	return 0
}

func (x *Status) GetMessage() string {
	if x != nil {
		return x.Message
	}
	return ""
}

type WorkersResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Workers []*Worker `protobuf:"bytes,1,rep,name=workers,proto3" json:"workers,omitempty"`
}

func (x *WorkersResponse) Reset() {
	*x = WorkersResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *WorkersResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*WorkersResponse) ProtoMessage() {}

func (x *WorkersResponse) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use WorkersResponse.ProtoReflect.Descriptor instead.
func (*WorkersResponse) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{1}
}

func (x *WorkersResponse) GetWorkers() []*Worker {
	if x != nil {
		return x.Workers
	}
	return nil
}

type WorkerRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Id string `protobuf:"bytes,1,opt,name=id,proto3" json:"id,omitempty"`
}

func (x *WorkerRequest) Reset() {
	*x = WorkerRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[2]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *WorkerRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*WorkerRequest) ProtoMessage() {}

func (x *WorkerRequest) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[2]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use WorkerRequest.ProtoReflect.Descriptor instead.
func (*WorkerRequest) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{2}
}

func (x *WorkerRequest) GetId() string {
	if x != nil {
		return x.Id
	}
	return ""
}

type WorkerResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Worker *Worker `protobuf:"bytes,1,opt,name=worker,proto3" json:"worker,omitempty"`
}

func (x *WorkerResponse) Reset() {
	*x = WorkerResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[3]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *WorkerResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*WorkerResponse) ProtoMessage() {}

func (x *WorkerResponse) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[3]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use WorkerResponse.ProtoReflect.Descriptor instead.
func (*WorkerResponse) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{3}
}

func (x *WorkerResponse) GetWorker() *Worker {
	if x != nil {
		return x.Worker
	}
	return nil
}

type ProcResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Proc *Proc `protobuf:"bytes,1,opt,name=proc,proto3" json:"proc,omitempty"`
}

func (x *ProcResponse) Reset() {
	*x = ProcResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[4]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ProcResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ProcResponse) ProtoMessage() {}

func (x *ProcResponse) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[4]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ProcResponse.ProtoReflect.Descriptor instead.
func (*ProcResponse) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{4}
}

func (x *ProcResponse) GetProc() *Proc {
	if x != nil {
		return x.Proc
	}
	return nil
}

type CpuResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Cpu *Cpu `protobuf:"bytes,1,opt,name=cpu,proto3" json:"cpu,omitempty"`
}

func (x *CpuResponse) Reset() {
	*x = CpuResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[5]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *CpuResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*CpuResponse) ProtoMessage() {}

func (x *CpuResponse) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[5]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use CpuResponse.ProtoReflect.Descriptor instead.
func (*CpuResponse) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{5}
}

func (x *CpuResponse) GetCpu() *Cpu {
	if x != nil {
		return x.Cpu
	}
	return nil
}

type MemResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Mem *Mem `protobuf:"bytes,1,opt,name=mem,proto3" json:"mem,omitempty"`
}

func (x *MemResponse) Reset() {
	*x = MemResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[6]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *MemResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*MemResponse) ProtoMessage() {}

func (x *MemResponse) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[6]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use MemResponse.ProtoReflect.Descriptor instead.
func (*MemResponse) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{6}
}

func (x *MemResponse) GetMem() *Mem {
	if x != nil {
		return x.Mem
	}
	return nil
}

type NetResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Net *Net `protobuf:"bytes,1,opt,name=net,proto3" json:"net,omitempty"`
}

func (x *NetResponse) Reset() {
	*x = NetResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[7]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *NetResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*NetResponse) ProtoMessage() {}

func (x *NetResponse) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[7]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use NetResponse.ProtoReflect.Descriptor instead.
func (*NetResponse) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{7}
}

func (x *NetResponse) GetNet() *Net {
	if x != nil {
		return x.Net
	}
	return nil
}

type UptimeResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Uptime *Uptime `protobuf:"bytes,1,opt,name=uptime,proto3" json:"uptime,omitempty"`
}

func (x *UptimeResponse) Reset() {
	*x = UptimeResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[8]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *UptimeResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*UptimeResponse) ProtoMessage() {}

func (x *UptimeResponse) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[8]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use UptimeResponse.ProtoReflect.Descriptor instead.
func (*UptimeResponse) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{8}
}

func (x *UptimeResponse) GetUptime() *Uptime {
	if x != nil {
		return x.Uptime
	}
	return nil
}

type LoadavgResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	LoadAvg *LoadAvg `protobuf:"bytes,1,opt,name=LoadAvg,proto3" json:"LoadAvg,omitempty"`
}

func (x *LoadavgResponse) Reset() {
	*x = LoadavgResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[9]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *LoadavgResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*LoadavgResponse) ProtoMessage() {}

func (x *LoadavgResponse) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[9]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use LoadavgResponse.ProtoReflect.Descriptor instead.
func (*LoadavgResponse) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{9}
}

func (x *LoadavgResponse) GetLoadAvg() *LoadAvg {
	if x != nil {
		return x.LoadAvg
	}
	return nil
}

type PoolLoadRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Type string `protobuf:"bytes,1,opt,name=type,proto3" json:"type,omitempty"`
}

func (x *PoolLoadRequest) Reset() {
	*x = PoolLoadRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[10]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *PoolLoadRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*PoolLoadRequest) ProtoMessage() {}

func (x *PoolLoadRequest) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[10]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use PoolLoadRequest.ProtoReflect.Descriptor instead.
func (*PoolLoadRequest) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{10}
}

func (x *PoolLoadRequest) GetType() string {
	if x != nil {
		return x.Type
	}
	return ""
}

type PoolLoadResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Load float64 `protobuf:"fixed64,1,opt,name=load,proto3" json:"load,omitempty"`
}

func (x *PoolLoadResponse) Reset() {
	*x = PoolLoadResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_api_proto_msgTypes[11]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *PoolLoadResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*PoolLoadResponse) ProtoMessage() {}

func (x *PoolLoadResponse) ProtoReflect() protoreflect.Message {
	mi := &file_api_proto_msgTypes[11]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use PoolLoadResponse.ProtoReflect.Descriptor instead.
func (*PoolLoadResponse) Descriptor() ([]byte, []int) {
	return file_api_proto_rawDescGZIP(), []int{11}
}

func (x *PoolLoadResponse) GetLoad() float64 {
	if x != nil {
		return x.Load
	}
	return 0
}

var File_api_proto protoreflect.FileDescriptor

var file_api_proto_rawDesc = []byte{
	0x0a, 0x09, 0x61, 0x70, 0x69, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x03, 0x6d, 0x65, 0x74,
	0x1a, 0x0c, 0x77, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x1a, 0x0a,
	0x70, 0x72, 0x6f, 0x63, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x1a, 0x1b, 0x67, 0x6f, 0x6f, 0x67,
	0x6c, 0x65, 0x2f, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2f, 0x65, 0x6d, 0x70, 0x74,
	0x79, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x22, 0x36, 0x0a, 0x06, 0x53, 0x74, 0x61, 0x74, 0x75,
	0x73, 0x12, 0x12, 0x0a, 0x04, 0x63, 0x6f, 0x64, 0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x05, 0x52,
	0x04, 0x63, 0x6f, 0x64, 0x65, 0x12, 0x18, 0x0a, 0x07, 0x6d, 0x65, 0x73, 0x73, 0x61, 0x67, 0x65,
	0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x07, 0x6d, 0x65, 0x73, 0x73, 0x61, 0x67, 0x65, 0x22,
	0x38, 0x0a, 0x0f, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x73, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e,
	0x73, 0x65, 0x12, 0x25, 0x0a, 0x07, 0x77, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x73, 0x18, 0x01, 0x20,
	0x03, 0x28, 0x0b, 0x32, 0x0b, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72,
	0x52, 0x07, 0x77, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x73, 0x22, 0x1f, 0x0a, 0x0d, 0x57, 0x6f, 0x72,
	0x6b, 0x65, 0x72, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x0e, 0x0a, 0x02, 0x69, 0x64,
	0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x02, 0x69, 0x64, 0x22, 0x35, 0x0a, 0x0e, 0x57, 0x6f,
	0x72, 0x6b, 0x65, 0x72, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x23, 0x0a, 0x06,
	0x77, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x0b, 0x2e, 0x6d,
	0x65, 0x74, 0x2e, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x52, 0x06, 0x77, 0x6f, 0x72, 0x6b, 0x65,
	0x72, 0x22, 0x2d, 0x0a, 0x0c, 0x50, 0x72, 0x6f, 0x63, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73,
	0x65, 0x12, 0x1d, 0x0a, 0x04, 0x70, 0x72, 0x6f, 0x63, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b, 0x32,
	0x09, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x50, 0x72, 0x6f, 0x63, 0x52, 0x04, 0x70, 0x72, 0x6f, 0x63,
	0x22, 0x29, 0x0a, 0x0b, 0x43, 0x70, 0x75, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12,
	0x1a, 0x0a, 0x03, 0x63, 0x70, 0x75, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x08, 0x2e, 0x6d,
	0x65, 0x74, 0x2e, 0x43, 0x70, 0x75, 0x52, 0x03, 0x63, 0x70, 0x75, 0x22, 0x29, 0x0a, 0x0b, 0x4d,
	0x65, 0x6d, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x1a, 0x0a, 0x03, 0x6d, 0x65,
	0x6d, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x08, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x4d, 0x65,
	0x6d, 0x52, 0x03, 0x6d, 0x65, 0x6d, 0x22, 0x29, 0x0a, 0x0b, 0x4e, 0x65, 0x74, 0x52, 0x65, 0x73,
	0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x1a, 0x0a, 0x03, 0x6e, 0x65, 0x74, 0x18, 0x01, 0x20, 0x01,
	0x28, 0x0b, 0x32, 0x08, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x4e, 0x65, 0x74, 0x52, 0x03, 0x6e, 0x65,
	0x74, 0x22, 0x35, 0x0a, 0x0e, 0x55, 0x70, 0x74, 0x69, 0x6d, 0x65, 0x52, 0x65, 0x73, 0x70, 0x6f,
	0x6e, 0x73, 0x65, 0x12, 0x23, 0x0a, 0x06, 0x75, 0x70, 0x74, 0x69, 0x6d, 0x65, 0x18, 0x01, 0x20,
	0x01, 0x28, 0x0b, 0x32, 0x0b, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x55, 0x70, 0x74, 0x69, 0x6d, 0x65,
	0x52, 0x06, 0x75, 0x70, 0x74, 0x69, 0x6d, 0x65, 0x22, 0x39, 0x0a, 0x0f, 0x4c, 0x6f, 0x61, 0x64,
	0x61, 0x76, 0x67, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x26, 0x0a, 0x07, 0x4c,
	0x6f, 0x61, 0x64, 0x41, 0x76, 0x67, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x0c, 0x2e, 0x6d,
	0x65, 0x74, 0x2e, 0x4c, 0x6f, 0x61, 0x64, 0x41, 0x76, 0x67, 0x52, 0x07, 0x4c, 0x6f, 0x61, 0x64,
	0x41, 0x76, 0x67, 0x22, 0x25, 0x0a, 0x0f, 0x50, 0x6f, 0x6f, 0x6c, 0x4c, 0x6f, 0x61, 0x64, 0x52,
	0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x12, 0x0a, 0x04, 0x74, 0x79, 0x70, 0x65, 0x18, 0x01,
	0x20, 0x01, 0x28, 0x09, 0x52, 0x04, 0x74, 0x79, 0x70, 0x65, 0x22, 0x26, 0x0a, 0x10, 0x50, 0x6f,
	0x6f, 0x6c, 0x4c, 0x6f, 0x61, 0x64, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x12,
	0x0a, 0x04, 0x6c, 0x6f, 0x61, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x01, 0x52, 0x04, 0x6c, 0x6f,
	0x61, 0x64, 0x32, 0xaf, 0x04, 0x0a, 0x03, 0x4d, 0x65, 0x74, 0x12, 0x26, 0x0a, 0x06, 0x52, 0x65,
	0x70, 0x6f, 0x72, 0x74, 0x12, 0x0b, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x57, 0x6f, 0x72, 0x6b, 0x65,
	0x72, 0x1a, 0x0b, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x53, 0x74, 0x61, 0x74, 0x75, 0x73, 0x28, 0x01,
	0x30, 0x01, 0x12, 0x3a, 0x0a, 0x0a, 0x47, 0x65, 0x74, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x73,
	0x12, 0x16, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62,
	0x75, 0x66, 0x2e, 0x45, 0x6d, 0x70, 0x74, 0x79, 0x1a, 0x14, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x57,
	0x6f, 0x72, 0x6b, 0x65, 0x72, 0x73, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x34,
	0x0a, 0x09, 0x47, 0x65, 0x74, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x12, 0x12, 0x2e, 0x6d, 0x65,
	0x74, 0x2e, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a,
	0x13, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x52, 0x65, 0x73, 0x70,
	0x6f, 0x6e, 0x73, 0x65, 0x12, 0x36, 0x0a, 0x0d, 0x47, 0x65, 0x74, 0x57, 0x6f, 0x72, 0x6b, 0x65,
	0x72, 0x50, 0x72, 0x6f, 0x63, 0x12, 0x12, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x57, 0x6f, 0x72, 0x6b,
	0x65, 0x72, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x11, 0x2e, 0x6d, 0x65, 0x74, 0x2e,
	0x50, 0x72, 0x6f, 0x63, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x34, 0x0a, 0x0c,
	0x47, 0x65, 0x74, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x43, 0x70, 0x75, 0x12, 0x12, 0x2e, 0x6d,
	0x65, 0x74, 0x2e, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74,
	0x1a, 0x10, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x43, 0x70, 0x75, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e,
	0x73, 0x65, 0x12, 0x34, 0x0a, 0x0c, 0x47, 0x65, 0x74, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x4d,
	0x65, 0x6d, 0x12, 0x12, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x52,
	0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x10, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x4d, 0x65, 0x6d,
	0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x34, 0x0a, 0x0c, 0x47, 0x65, 0x74, 0x57,
	0x6f, 0x72, 0x6b, 0x65, 0x72, 0x4e, 0x65, 0x74, 0x12, 0x12, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x57,
	0x6f, 0x72, 0x6b, 0x65, 0x72, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x10, 0x2e, 0x6d,
	0x65, 0x74, 0x2e, 0x4e, 0x65, 0x74, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x3a,
	0x0a, 0x0f, 0x47, 0x65, 0x74, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x55, 0x70, 0x74, 0x69, 0x6d,
	0x65, 0x12, 0x12, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x52, 0x65,
	0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x13, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x55, 0x70, 0x74, 0x69,
	0x6d, 0x65, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x3c, 0x0a, 0x10, 0x47, 0x65,
	0x74, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x4c, 0x6f, 0x61, 0x64, 0x61, 0x76, 0x67, 0x12, 0x12,
	0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x57, 0x6f, 0x72, 0x6b, 0x65, 0x72, 0x52, 0x65, 0x71, 0x75, 0x65,
	0x73, 0x74, 0x1a, 0x14, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x4c, 0x6f, 0x61, 0x64, 0x61, 0x76, 0x67,
	0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x3a, 0x0a, 0x0b, 0x47, 0x65, 0x74, 0x50,
	0x6f, 0x6f, 0x6c, 0x4c, 0x6f, 0x61, 0x64, 0x12, 0x14, 0x2e, 0x6d, 0x65, 0x74, 0x2e, 0x50, 0x6f,
	0x6f, 0x6c, 0x4c, 0x6f, 0x61, 0x64, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x15, 0x2e,
	0x6d, 0x65, 0x74, 0x2e, 0x50, 0x6f, 0x6f, 0x6c, 0x4c, 0x6f, 0x61, 0x64, 0x52, 0x65, 0x73, 0x70,
	0x6f, 0x6e, 0x73, 0x65, 0x42, 0x2a, 0x5a, 0x28, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63,
	0x6f, 0x6d, 0x2f, 0x6d, 0x61, 0x74, 0x74, 0x67, 0x6f, 0x6e, 0x65, 0x77, 0x69, 0x6c, 0x64, 0x2f,
	0x62, 0x72, 0x75, 0x74, 0x75, 0x73, 0x2f, 0x6d, 0x65, 0x74, 0x2f, 0x70, 0x72, 0x6f, 0x74, 0x6f,
	0x62, 0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_api_proto_rawDescOnce sync.Once
	file_api_proto_rawDescData = file_api_proto_rawDesc
)

func file_api_proto_rawDescGZIP() []byte {
	file_api_proto_rawDescOnce.Do(func() {
		file_api_proto_rawDescData = protoimpl.X.CompressGZIP(file_api_proto_rawDescData)
	})
	return file_api_proto_rawDescData
}

var file_api_proto_msgTypes = make([]protoimpl.MessageInfo, 12)
var file_api_proto_goTypes = []interface{}{
	(*Status)(nil),           // 0: met.Status
	(*WorkersResponse)(nil),  // 1: met.WorkersResponse
	(*WorkerRequest)(nil),    // 2: met.WorkerRequest
	(*WorkerResponse)(nil),   // 3: met.WorkerResponse
	(*ProcResponse)(nil),     // 4: met.ProcResponse
	(*CpuResponse)(nil),      // 5: met.CpuResponse
	(*MemResponse)(nil),      // 6: met.MemResponse
	(*NetResponse)(nil),      // 7: met.NetResponse
	(*UptimeResponse)(nil),   // 8: met.UptimeResponse
	(*LoadavgResponse)(nil),  // 9: met.LoadavgResponse
	(*PoolLoadRequest)(nil),  // 10: met.PoolLoadRequest
	(*PoolLoadResponse)(nil), // 11: met.PoolLoadResponse
	(*Worker)(nil),           // 12: met.Worker
	(*Proc)(nil),             // 13: met.Proc
	(*Cpu)(nil),              // 14: met.Cpu
	(*Mem)(nil),              // 15: met.Mem
	(*Net)(nil),              // 16: met.Net
	(*Uptime)(nil),           // 17: met.Uptime
	(*LoadAvg)(nil),          // 18: met.LoadAvg
	(*emptypb.Empty)(nil),    // 19: google.protobuf.Empty
}
var file_api_proto_depIdxs = []int32{
	12, // 0: met.WorkersResponse.workers:type_name -> met.Worker
	12, // 1: met.WorkerResponse.worker:type_name -> met.Worker
	13, // 2: met.ProcResponse.proc:type_name -> met.Proc
	14, // 3: met.CpuResponse.cpu:type_name -> met.Cpu
	15, // 4: met.MemResponse.mem:type_name -> met.Mem
	16, // 5: met.NetResponse.net:type_name -> met.Net
	17, // 6: met.UptimeResponse.uptime:type_name -> met.Uptime
	18, // 7: met.LoadavgResponse.LoadAvg:type_name -> met.LoadAvg
	12, // 8: met.Met.Report:input_type -> met.Worker
	19, // 9: met.Met.GetWorkers:input_type -> google.protobuf.Empty
	2,  // 10: met.Met.GetWorker:input_type -> met.WorkerRequest
	2,  // 11: met.Met.GetWorkerProc:input_type -> met.WorkerRequest
	2,  // 12: met.Met.GetWorkerCpu:input_type -> met.WorkerRequest
	2,  // 13: met.Met.GetWorkerMem:input_type -> met.WorkerRequest
	2,  // 14: met.Met.GetWorkerNet:input_type -> met.WorkerRequest
	2,  // 15: met.Met.GetWorkerUptime:input_type -> met.WorkerRequest
	2,  // 16: met.Met.GetWorkerLoadavg:input_type -> met.WorkerRequest
	10, // 17: met.Met.GetPoolLoad:input_type -> met.PoolLoadRequest
	0,  // 18: met.Met.Report:output_type -> met.Status
	1,  // 19: met.Met.GetWorkers:output_type -> met.WorkersResponse
	3,  // 20: met.Met.GetWorker:output_type -> met.WorkerResponse
	4,  // 21: met.Met.GetWorkerProc:output_type -> met.ProcResponse
	5,  // 22: met.Met.GetWorkerCpu:output_type -> met.CpuResponse
	6,  // 23: met.Met.GetWorkerMem:output_type -> met.MemResponse
	7,  // 24: met.Met.GetWorkerNet:output_type -> met.NetResponse
	8,  // 25: met.Met.GetWorkerUptime:output_type -> met.UptimeResponse
	9,  // 26: met.Met.GetWorkerLoadavg:output_type -> met.LoadavgResponse
	11, // 27: met.Met.GetPoolLoad:output_type -> met.PoolLoadResponse
	18, // [18:28] is the sub-list for method output_type
	8,  // [8:18] is the sub-list for method input_type
	8,  // [8:8] is the sub-list for extension type_name
	8,  // [8:8] is the sub-list for extension extendee
	0,  // [0:8] is the sub-list for field type_name
}

func init() { file_api_proto_init() }
func file_api_proto_init() {
	if File_api_proto != nil {
		return
	}
	file_worker_proto_init()
	file_proc_proto_init()
	if !protoimpl.UnsafeEnabled {
		file_api_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Status); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*WorkersResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_proto_msgTypes[2].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*WorkerRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_proto_msgTypes[3].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*WorkerResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_proto_msgTypes[4].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ProcResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_proto_msgTypes[5].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*CpuResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_proto_msgTypes[6].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*MemResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_proto_msgTypes[7].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*NetResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_proto_msgTypes[8].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*UptimeResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_proto_msgTypes[9].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*LoadavgResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_proto_msgTypes[10].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*PoolLoadRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_api_proto_msgTypes[11].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*PoolLoadResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_api_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   12,
			NumExtensions: 0,
			NumServices:   1,
		},
		GoTypes:           file_api_proto_goTypes,
		DependencyIndexes: file_api_proto_depIdxs,
		MessageInfos:      file_api_proto_msgTypes,
	}.Build()
	File_api_proto = out.File
	file_api_proto_rawDesc = nil
	file_api_proto_goTypes = nil
	file_api_proto_depIdxs = nil
}
