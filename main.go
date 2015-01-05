package main

import (
	"gopkg.in/qml.v1"
	
	"fmt"
	"log"
	"os"
	"net/http"
)

type RequestResponsePair struct {
	Request http.Request
	Response http.Response
}

type State struct {
	CaptureEnabled false
	ReqResps []RequestResponsePair
	Window   qml.Object
}

var state State

func main() {
	var outChan chan RequestResponsePair
	outChan = make(chan RequestResponsePair, 10)
	go setupProxy(outChan)
	go func() {
		for {
			blah := <-outChan

			log.Println("Request: ", blah.Request)
			log.Println("Response: ", blah.Response)

			state.CaptureEnabled = !state.CaptureEnabled
			log.Println("Toggled to: ", state.CaptureEnabled)
		}
	}()
	
	if err := qml.Run(run); err != nil {
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}
}

func run() error {
	engine := qml.NewEngine()

	controls, err := engine.LoadFile("main.qml")
	if err != nil {
		return err
	}

	context := engine.Context()
	context.SetVar("state", &state)

	window := controls.CreateWindow(nil)
	state.Window = window

	window.Show()
	window.Wait()
	return nil
}
