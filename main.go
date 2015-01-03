package main

import (
  "gopkg.in/qml.v1"
  
  "fmt"
  "os"
  "net/http"
)

type RequestResponsePair struct {
  Request http.Request
  Response http.Response
}

type State struct {
  SomeValue int
  ReqResps []RequestResponsePair
}

func main() {
  setupProxy()
  
  if err := qml.Run(run); err != nil {
    fmt.Fprintf(os.Stderr, "error: %v\n", err)
    os.Exit(1)
  }
}

func run() error {
  engine := qml.NewEngine()

  // var state = &State{}

  controls, err := engine.LoadFile("main.qml")
  if err != nil {
    return err
  }

  window := controls.CreateWindow(nil)

  window.Show()
  window.Wait()
  return nil
}
