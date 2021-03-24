package bitmaelum_client

import (
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"

	bitmaelumClientLib "github.com/bitmaelum/bitmaelum-client-lib/bridge"
)

const openVault = "openVault"

const channelName = "bitmaelum_flutter_plugin"

// Plugin implements flutter.Plugin and handles method.
type Plugin struct {
	channel *plugin.MethodChannel
}

var _ flutter.Plugin = &Plugin{} // compile-time type check

func (p *Plugin) InitPlugin(messenger plugin.BinaryMessenger) error {
	channel := plugin.NewMethodChannel(messenger, channelName, plugin.JSONMethodCodec{})
	channel.CatchAllHandleFunc(p.catchAll)
	return nil
}

func (p *Plugin) catchAll(methodCall interface{}) (reply interface{}, err error) {
	method := methodCall.(plugin.MethodCall)
	return bitmaelumClientLib.Call(method.Method, method.Arguments.([]byte))
}
