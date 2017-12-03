package main

import (
    "fmt"
    "math"
    "os"
    "strconv"
)

func getSpiralCoords(n float64) (float64, float64) {
    // (2 * ceil((sqrt(x) - 1) / 2) + 1)^2
    k := math.Ceil((math.Sqrt(n) - 1.0) / 2.0)
    t := 2.0 * k + 1.0
    m := math.Pow(t, 2.0)
    t -= 1.0
    if (n >= m - t) { return k - (m - n), -k }
    m -= t
    if (n >= m - t) { return -k, -k + (m - n)}
    m -= t
    if (n >= m - t) { return -k + (m - n), k }
    return k, k - (m - n - t)
}

func manhattanDistance(x, y float64) float64 {
    return math.Abs(x) + math.Abs(y)
}

func main() {
    num := os.Args[1]
    n, _ := strconv.Atoi(num)
    if (n != 0) {
        x, y := getSpiralCoords(float64(n))
        dist := manhattanDistance(x, y)
        fmt.Println(dist)
    }
}