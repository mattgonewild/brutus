// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.3.0
// - protoc             v4.25.1
// source: api.proto

package proto

import (
	context "context"
	_go "github.com/mattgonewild/brutus/proto/go"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.32.0 or later.
const _ = grpc.SupportPackageIsVersion7

const (
	Decrypt_Set_FullMethodName      = "/decrypt.Decrypt/Set"
	Decrypt_Connect_FullMethodName  = "/decrypt.Decrypt/Connect"
	Decrypt_Shutdown_FullMethodName = "/decrypt.Decrypt/Shutdown"
)

// DecryptClient is the client API for Decrypt service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type DecryptClient interface {
	Set(ctx context.Context, in *_go.Target, opts ...grpc.CallOption) (*emptypb.Empty, error)
	Connect(ctx context.Context, opts ...grpc.CallOption) (Decrypt_ConnectClient, error)
	Shutdown(ctx context.Context, in *emptypb.Empty, opts ...grpc.CallOption) (*emptypb.Empty, error)
}

type decryptClient struct {
	cc grpc.ClientConnInterface
}

func NewDecryptClient(cc grpc.ClientConnInterface) DecryptClient {
	return &decryptClient{cc}
}

func (c *decryptClient) Set(ctx context.Context, in *_go.Target, opts ...grpc.CallOption) (*emptypb.Empty, error) {
	out := new(emptypb.Empty)
	err := c.cc.Invoke(ctx, Decrypt_Set_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *decryptClient) Connect(ctx context.Context, opts ...grpc.CallOption) (Decrypt_ConnectClient, error) {
	stream, err := c.cc.NewStream(ctx, &Decrypt_ServiceDesc.Streams[0], Decrypt_Connect_FullMethodName, opts...)
	if err != nil {
		return nil, err
	}
	x := &decryptConnectClient{stream}
	return x, nil
}

type Decrypt_ConnectClient interface {
	Send(*_go.Permutation) error
	Recv() (*_go.Result, error)
	grpc.ClientStream
}

type decryptConnectClient struct {
	grpc.ClientStream
}

func (x *decryptConnectClient) Send(m *_go.Permutation) error {
	return x.ClientStream.SendMsg(m)
}

func (x *decryptConnectClient) Recv() (*_go.Result, error) {
	m := new(_go.Result)
	if err := x.ClientStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

func (c *decryptClient) Shutdown(ctx context.Context, in *emptypb.Empty, opts ...grpc.CallOption) (*emptypb.Empty, error) {
	out := new(emptypb.Empty)
	err := c.cc.Invoke(ctx, Decrypt_Shutdown_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// DecryptServer is the server API for Decrypt service.
// All implementations must embed UnimplementedDecryptServer
// for forward compatibility
type DecryptServer interface {
	Set(context.Context, *_go.Target) (*emptypb.Empty, error)
	Connect(Decrypt_ConnectServer) error
	Shutdown(context.Context, *emptypb.Empty) (*emptypb.Empty, error)
	mustEmbedUnimplementedDecryptServer()
}

// UnimplementedDecryptServer must be embedded to have forward compatible implementations.
type UnimplementedDecryptServer struct {
}

func (UnimplementedDecryptServer) Set(context.Context, *_go.Target) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Set not implemented")
}
func (UnimplementedDecryptServer) Connect(Decrypt_ConnectServer) error {
	return status.Errorf(codes.Unimplemented, "method Connect not implemented")
}
func (UnimplementedDecryptServer) Shutdown(context.Context, *emptypb.Empty) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Shutdown not implemented")
}
func (UnimplementedDecryptServer) mustEmbedUnimplementedDecryptServer() {}

// UnsafeDecryptServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to DecryptServer will
// result in compilation errors.
type UnsafeDecryptServer interface {
	mustEmbedUnimplementedDecryptServer()
}

func RegisterDecryptServer(s grpc.ServiceRegistrar, srv DecryptServer) {
	s.RegisterService(&Decrypt_ServiceDesc, srv)
}

func _Decrypt_Set_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(_go.Target)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(DecryptServer).Set(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: Decrypt_Set_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(DecryptServer).Set(ctx, req.(*_go.Target))
	}
	return interceptor(ctx, in, info, handler)
}

func _Decrypt_Connect_Handler(srv interface{}, stream grpc.ServerStream) error {
	return srv.(DecryptServer).Connect(&decryptConnectServer{stream})
}

type Decrypt_ConnectServer interface {
	Send(*_go.Result) error
	Recv() (*_go.Permutation, error)
	grpc.ServerStream
}

type decryptConnectServer struct {
	grpc.ServerStream
}

func (x *decryptConnectServer) Send(m *_go.Result) error {
	return x.ServerStream.SendMsg(m)
}

func (x *decryptConnectServer) Recv() (*_go.Permutation, error) {
	m := new(_go.Permutation)
	if err := x.ServerStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

func _Decrypt_Shutdown_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(emptypb.Empty)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(DecryptServer).Shutdown(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: Decrypt_Shutdown_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(DecryptServer).Shutdown(ctx, req.(*emptypb.Empty))
	}
	return interceptor(ctx, in, info, handler)
}

// Decrypt_ServiceDesc is the grpc.ServiceDesc for Decrypt service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var Decrypt_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "decrypt.Decrypt",
	HandlerType: (*DecryptServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "Set",
			Handler:    _Decrypt_Set_Handler,
		},
		{
			MethodName: "Shutdown",
			Handler:    _Decrypt_Shutdown_Handler,
		},
	},
	Streams: []grpc.StreamDesc{
		{
			StreamName:    "Connect",
			Handler:       _Decrypt_Connect_Handler,
			ServerStreams: true,
			ClientStreams: true,
		},
	},
	Metadata: "api.proto",
}
