package main

import (
	"compress/zlib"
	"fmt"
	"io"
	"os"
	"sync"
	"time"
)

func main() {
	start := time.Now()
	var wg sync.WaitGroup

	var i int = -1
	var file string
	for i, file = range os.Args[1:] {
		wg.Add(1)
		go func(filename string) {
			compress(filename)
			wg.Done()
		}(file)
	}
	wg.Wait()

	fmt.Printf("Compressed %d files in %fs.\n", i+1, time.Since(start).Seconds())
}

func compress(filename string) error {
	// Open target file
	in, err := os.Open(filename)
	if err != nil {
		return err
	}
	defer in.Close()

	// Create zip file
	out, err := os.Create(filename + ".zip")
	if err != nil {
		return err
	}
	defer out.Close()

	// Compress
	gz := zlib.NewWriter(out)
	_, err = io.Copy(gz, in)
	gz.Close()

	return err // expect nil
}
